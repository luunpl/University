#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/wait.h>

void run_command(char **argv) {
    pid_t pid = fork();
    
    switch (pid) {
        case -1:
            perror("fork");
            exit(1);
            break;
        case 0:
            /* comportement du fils */
            execvp(argv[0], argv);
            perror("execvp");
            exit(1);
            break;
        default:
            /* comportement du père */
            int status;
            if (waitpid(pid, &status, 0) < 0) {
                perror("waitpid");
                exit(1);
            }
            break;
    }
}


int main(void) {
    // who
    char *who_cmd[] = {"who", NULL};
    printf("\nExecuter 'who' command:\n");
    run_command(who_cmd);

    // pwd
    char *pwd_cmd[] = {"pwd", NULL};
    printf("\nExecuter 'pwd' command:\n");
    run_command(pwd_cmd);
    
    // ls -l
    char *ls_cmd[] = {"ls", "-l", NULL};
    printf("\nExecuter 'ls -l' command:\n");
    run_command(ls_cmd);

    return 0;
}
