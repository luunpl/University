#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <signal.h>
#include <sys/wait.h>
#include <fcntl.h>

/*Idee: 
-Lorsque on tape pas exit, on lit la ligne de commande (Boucle principale)
-Utliser la fonction execvp() pour executer les commandes
-Traiter les redirections, separation des processus, CTRL + C
-Tuer les processus fils en fond lorsqu'ils se terminent
*/
pid_t fg_pgid = 0;  // groupe du processus avant-planls

// Voir le cours CM4 pour les explications kill et waitpid
/* --- Ctrl+C : envoie SIGINT au groupe avant-plan --- */

void sigint_handler(int sig) {
    if (fg_pgid > 0)
        kill(-fg_pgid, SIGINT);
    printf("\n");
    fflush(stdout);
}

/* --- Quand un fils se termine (processus en fond) --- */
void sigchld_handler(int sig) {
    int status;
    pid_t pid;
    while ((pid = waitpid(-1, &status, WNOHANG)) > 0) {
        printf("[bg] terminé : %d\n", pid);
        fflush(stdout);
    }
}

/* --- séparer les commandes par '|' --- */
int split_pipeline(char *line, char *cmds[]) {
    int n = 0;
    char *tok = strtok(line, "|");
    while (tok && n < 10) {
        while (*tok == ' ') tok++;
        cmds[n++] = tok;
        tok = strtok(NULL, "|");
    }
    cmds[n] = NULL;
    return n;
}

/* --- exécuter le pipeline --- */
// Idee: Depuis l'exo 1 + exo 2 TP4
void execute_pipeline(char *cmds[], int ncmd, int background) {
    int pipes[9][2];
    pid_t pids[10];

    for (int i = 0; i < ncmd - 1; i++)
        pipe(pipes[i]);

    for (int i = 0; i < ncmd; i++) {
        pid_t pid = fork();
        // Ici on utilise l'intruction if-else au lieu de switch-case
        // Comportement du fils
        
        if (pid == 0) {
            signal(SIGINT, SIG_DFL);

            if (i > 0) dup2(pipes[i - 1][0], 0);
            if (i < ncmd - 1) dup2(pipes[i][1], 1);
            
            for (int k = 0; k < ncmd - 1; k++) {
                close(pipes[k][0]);
                close(pipes[k][1]);
            }

            // Lire les commandes et leurs arguments
            // Rappel : strtok modifie la chaîne originale 
            char *argv[32];
            int argc = 0;
            char *arg = strtok(cmds[i], " \t\n");
            while (arg && argc < 31) {
                argv[argc++] = arg;
                arg = strtok(NULL, " \t\n");
            }
            argv[argc] = NULL;

            for (int j = 0; argv[j]; j++) {
                if (!strcmp(argv[j], "<") && argv[j+1]) {
                    int fd = open(argv[j+1], O_RDONLY);
                    dup2(fd, 0); close(fd);
                    argv[j] = NULL; break;
                } else if (!strcmp(argv[j], ">") && argv[j+1]) {
                    int fd = open(argv[j+1], O_WRONLY|O_CREAT|O_TRUNC, 0644);
                    dup2(fd, 1); close(fd);
                    argv[j] = NULL; break;
                }
            }
            // Executer la commande
            execvp(argv[0], argv);
            perror("execvp");
            exit(1);

        } else {
            // Comportement du père
            pids[i] = pid;
            if (i == 0) setpgid(pid, pid);
            else setpgid(pid, pids[0]);
        }
    }

    // Fonction fermer_tube() du TP4 Exo2
    for (int k = 0; k < ncmd - 1; k++) {
        close(pipes[k][0]);
        close(pipes[k][1]);
    }

    if (background) {
        printf("[bg] lancé : %d\n", pids[0]);
        return;
    }

    fg_pgid = pids[0];
    for (int i = 0; i < ncmd; i++)
        waitpid(pids[i], NULL, 0);
    fg_pgid = 0;
}

/* --- Boucle principale --- */
int main() {
    char line[256];
    char *cmds[10];

    signal(SIGINT, sigint_handler);
    signal(SIGCHLD, sigchld_handler);

    while (1) {
        printf("myshell$ ");
        // GPT sensei
        fflush(stdout);
        if (!fgets(line, sizeof(line), stdin))
            break;
        line[strcspn(line, "\n")] = '\0';
        if (!strcmp(line, "")) continue;
        if (!strcmp(line, "exit")) break;

        int background = 0;
        int len = strlen(line);
        if (len > 0 && line[len - 1] == '&') {
            background = 1;
            line[len - 1] = '\0';
        }

        int ncmd = split_pipeline(line, cmds);
        execute_pipeline(cmds, ncmd, background);
    }
    printf("Au revoir!\n");
    return 0;
}
