/* Exercice3.c
   Mini-shell for TP4_5

   Features implemented:
   - Command line parsing (Lire_commande) using strtok, recognizes pipelines '|', input '<', output '>', background '&'
   - Built-ins: cd, getenv, setenv, exit
   - Arbitrary-length pipelines using an array of pipes and forked children
   - I/O redirections per command
   - Background execution with '&'
   - Signal handling: SIGINT forwarded to foreground group, SIGCHLD reaps children with waitpid(WNOHANG)

   Limitations / assumptions:
   - Tokens must be separated by spaces (as allowed by the assignment)
   - No advanced quoting or escape handling
   - setenv usage: "setenv" prints all environment vars; "setenv NAME VALUE" sets variable

   Compile: gcc -Wall -o minishell Exercice3.c

*/

#define _POSIX_C_SOURCE 200809L
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <signal.h>
#include <fcntl.h>
#include <errno.h>

#define MAXLINE 4096
#define MAX_TOKENS 256
#define MAX_CMDS 64

/* Data structure representing one command in a pipeline */
typedef struct command {
    char *argv[MAX_TOKENS];
    char *infile;   /* filename for input redirection, or NULL */
    char *outfile;  /* filename for output redirection, or NULL */
    int append;     /* not used but present for extension */
} command;

/* Global tracking of foreground process group and foreground children count */
volatile sig_atomic_t fg_children = 0;
pid_t fg_pgid = 0;

/* Forward declarations */
int Lire_commande(char *cmdline, command cmds[], int *ncmds, int *background);
int handle_builtin(command *c);
void sigint_handler(int signo);
void sigchld_handler(int signo);

int main(void) {
    char line[MAXLINE];
    command cmds[MAX_CMDS];
    int ncmds = 0;
    int background = 0;
    struct sigaction sa_int, sa_chld;

    /* Setup SIGINT handler: forward to foreground process group */
    sa_int.sa_handler = sigint_handler;
    sigemptyset(&sa_int.sa_mask);
    sa_int.sa_flags = SA_RESTART;
    if (sigaction(SIGINT, &sa_int, NULL) < 0) {
        perror("sigaction SIGINT");
        exit(1);
    }

    /* Setup SIGCHLD handler: reap children */
    sa_chld.sa_handler = sigchld_handler;
    sigemptyset(&sa_chld.sa_mask);
    sa_chld.sa_flags = SA_RESTART | SA_NOCLDSTOP;
    if (sigaction(SIGCHLD, &sa_chld, NULL) < 0) {
        perror("sigaction SIGCHLD");
        exit(1);
    }

    while (1) {
        printf("minishell$ ");
        fflush(stdout);

        if (!fgets(line, sizeof(line), stdin)) {
            /* EOF (Ctrl-D) */
            putchar('\n');
            break;
        }

        /* remove trailing newline */
        line[strcspn(line, "\n")] = '\0';
        if (line[0] == '\0') continue;

        ncmds = 0;
        background = 0;
        if (Lire_commande(line, cmds, &ncmds, &background) < 0) {
            fprintf(stderr, "Erreur d'analyse de la commande\n");
            continue;
        }

        if (ncmds == 0) continue;

        /* If single built-in and not in a pipeline, handle directly */
        if (ncmds == 1 && handle_builtin(&cmds[0]) == 0) {
            /* builtin handled (or exit executed) */
            continue;
        }

        /* Prepare pipes for (ncmds - 1) connections */
        int pipes[MAX_CMDS-1][2];
        for (int i = 0; i < ncmds-1; ++i) {
            if (pipe(pipes[i]) < 0) {
                perror("pipe");
                break;
            }
        }

        fg_children = 0;
        fg_pgid = 0;

        for (int i = 0; i < ncmds; ++i) {
            pid_t pid = fork();
            if (pid < 0) {
                perror("fork");
                break;
            }
            if (pid == 0) {
                /* Child */
                /* Set process group: first child creates pgid */
                if (i == 0) {
                    if (setpgid(0, 0) < 0) perror("setpgid");
                } else {
                    if (setpgid(0, fg_pgid) < 0) perror("setpgid");
                }

                /* If running in background, children should ignore SIGINT */
                if (background) {
                    signal(SIGINT, SIG_IGN);
                }

                /* Setup input */
                if (cmds[i].infile) {
                    int fd = open(cmds[i].infile, O_RDONLY);
                    if (fd < 0) { perror("open infile"); exit(1); }
                    dup2(fd, STDIN_FILENO);
                    close(fd);
                } else if (i > 0) {
                    /* read end of previous pipe */
                    dup2(pipes[i-1][0], STDIN_FILENO);
                }

                /* Setup output */
                if (cmds[i].outfile) {
                    int fd = open(cmds[i].outfile, O_WRONLY | O_CREAT | O_TRUNC, 0644);
                    if (fd < 0) { perror("open outfile"); exit(1); }
                    dup2(fd, STDOUT_FILENO);
                    close(fd);
                } else if (i < ncmds-1) {
                    /* write end of this pipe */
                    dup2(pipes[i][1], STDOUT_FILENO);
                }

                /* Close all pipe fds in child */
                for (int j = 0; j < ncmds-1; ++j) {
                    close(pipes[j][0]);
                    close(pipes[j][1]);
                }

                /* Execute */
                execvp(cmds[i].argv[0], cmds[i].argv);
                perror("execvp");
                exit(1);
            } else {
                /* Parent */
                /* Set/remember pgid */
                if (i == 0) {
                    fg_pgid = pid;
                    if (setpgid(pid, pid) < 0) perror("setpgid parent");
                } else {
                    if (setpgid(pid, fg_pgid) < 0) perror("setpgid parent2");
                }

                if (!background) fg_children++;
            }
        }

        /* Close pipes in parent */
        for (int i = 0; i < ncmds-1; ++i) {
            close(pipes[i][0]);
            close(pipes[i][1]);
        }

        /* If foreground, wait until fg_children == 0 (reaped by SIGCHLD handler) */
        if (!background) {
            while (fg_children > 0) {
                pause(); /* wait for signals */
            }
        } else {
            printf("[background pid %d]\n", fg_pgid);
        }
    }

    return 0;
}

/* Parse the command line into cmds array. Returns 0 on success, -1 on parse error. */
int Lire_commande(char *cmdline, command cmds[], int *ncmds, int *background) {
    /* initialize */
    for (int i = 0; i < MAX_CMDS; ++i) {
        cmds[i].infile = cmds[i].outfile = NULL;
        cmds[i].append = 0;
        for (int j = 0; j < MAX_TOKENS; ++j) cmds[i].argv[j] = NULL;
    }

    char *saveptr = NULL;
    char *token = NULL;
    int cur = 0; /* current command index */
    int argi = 0;

    token = strtok_r(cmdline, " ", &saveptr);
    while (token) {
        if (strcmp(token, "|") == 0) {
            /* finish current command */
            if (argi == 0) return -1; /* pipe without command */
            cmds[cur].argv[argi] = NULL;
            cur++;
            if (cur >= MAX_CMDS) return -1;
            argi = 0;
        } else if (strcmp(token, "<") == 0) {
            token = strtok_r(NULL, " ", &saveptr);
            if (!token) return -1;
            cmds[cur].infile = strdup(token);
        } else if (strcmp(token, ">") == 0) {
            token = strtok_r(NULL, " ", &saveptr);
            if (!token) return -1;
            cmds[cur].outfile = strdup(token);
        } else if (strcmp(token, "&") == 0) {
            *background = 1;
        } else {
            cmds[cur].argv[argi++] = strdup(token);
            if (argi >= MAX_TOKENS-1) return -1;
        }
        token = strtok_r(NULL, " ", &saveptr);
    }

    /* finalize last command */
    if (argi > 0) {
        cmds[cur].argv[argi] = NULL;
        cur++;
    }

    *ncmds = cur;
    return 0;
}

/* Return 0 if builtin handled (no fork needed), 1 if not builtin */
int handle_builtin(command *c) {
    if (!c->argv[0]) return 1;
    if (strcmp(c->argv[0], "cd") == 0) {
        if (!c->argv[1]) {
            /* go to HOME */
            char *home = getenv("HOME");
            if (!home) home = "/";
            if (chdir(home) < 0) perror("cd");
        } else {
            if (chdir(c->argv[1]) < 0) perror("cd");
        }
        return 0;
    }
    if (strcmp(c->argv[0], "getenv") == 0) {
        if (!c->argv[1]) {
            fprintf(stderr, "Usage: getenv NAME\n");
        } else {
            char *v = getenv(c->argv[1]);
            if (v) printf("%s\n", v);
        }
        return 0;
    }
    if (strcmp(c->argv[0], "setenv") == 0) {
        if (!c->argv[1]) {
            /* print all env vars */
            extern char **environ;
            for (char **e = environ; *e; ++e) puts(*e);
        } else if (!c->argv[2]) {
            fprintf(stderr, "Usage: setenv NAME VALUE\n");
        } else {
            if (setenv(c->argv[1], c->argv[2], 1) < 0) perror("setenv");
        }
        return 0;
    }
    if (strcmp(c->argv[0], "exit") == 0) {
        exit(0);
    }
    return 1;
}

void sigint_handler(int signo) {
    /* Forward SIGINT to foreground process group */
    if (fg_pgid != 0) {
        kill(-fg_pgid, SIGINT);
        /* optional message */
        write(STDOUT_FILENO, "\n^C received, forwarded to foreground\n", 36);
    }
}

void sigchld_handler(int signo) {
    int saved_errno = errno;
    pid_t pid;
    int status;
    while ((pid = waitpid(-1, &status, WNOHANG)) > 0) {
        /* decrement fg_children if it was a foreground child */
        /* This is a simplification: we assume all children in fg_pgid were foreground unless background was set */
        if (fg_children > 0) fg_children--;
        /* Optionally print termination info */
        // if (WIFEXITED(status)) fprintf(stderr, "child %d exited %d\n", pid, WEXITSTATUS(status));
    }
    errno = saved_errno;
}
