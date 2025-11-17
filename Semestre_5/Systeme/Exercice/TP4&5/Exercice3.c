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

/* --- séparer les commandes par '|' --- */
int split_pipeline(char *line, char *cmds[]) {// cmds est un tableau pour stocker les lignes
    int n = 0; // compter le nombre de commands séparé par "|"
    char *tok = strtok(line, "|"); // Prend la première commande avant le "|"
    while (n < 10) {
        while (*tok == ' ') tok++; // passer à le tok suivant si rencontre espace
        cmds[n++] = tok; // n d'abord et après ++
        tok = strtok(NULL, "|"); // Passer à le commande suivant après le "|"
    }

    cmds[n] = NULL; // La dernière élément dans le table doit être null
}
/* --- exécuter le pipeline --- */
// Idee: Depuis l'exo 1 + exo 2 TP4
void execute_pipeline(char *cmds[], int ncmd, int background) {
    int pipes[9][2];
    pid_t pids[10];

    // ncmd: split pipeline
    for (int i = 0; i < ncmd - 1; i++)
        pipe(pipes[i]); // création de tubes dans chaque pipeline

    for (int i = 0; i < ncmd - 1; i++) {
        pid_t pid = fork(); // créer de nouveau fork à chaque iteration

        switch(fork()){
            case -1:
                perror("fork");
                exit(1);
                break;
            case 0:
                // Comportement du fils

                /*dup() et dup2() créent une copie du descripteur de fichier oldfd.
                dup() utilise le plus petit numéro inutilisé pour le nouveau descripteur.
                dup2() transforme newfd en une copie de oldfd, fermant auparavant newfd si besoin est, mais veuillez noter ceci :
                    -Si oldfd n'est pas un descripteur de fichier valide, l'appel échoue et newfd n'est pas fermé. 
                    -Si oldfd est un descripteur de fichier valide et si newfd a la même valeur que oldfd, dup2() ne fait rien et renvoie newfd. 
                */
                if (i > 0) dup2(pipes[i - 1][0], 0);
                if (i < ncmd - 1) dup2(pipes[i][1], 1);
                
                for (int k = 0; k < ncmd - 1; k++) {
                    close(pipes[k][0]);
                    close(pipes[k][1]);
                }
                
                // Lire les commandes et leurs arguments
                // Rappel : strtok modifie la chaîne originale 
                char *argv[128];
                int argc = 0;
                char *arg = strtok(cmds[i], " \n");

                while (arg != NULL && argc < 127) {
                    argv[argc++] = arg;
                    arg = strtok(NULL, " \n");
                }
                argv[argc] = NULL; // Le commande list doit suivi par un NULL

                execvp(argv[0], argv);
                perror("execvp");
                exit(1);
                break;
            default:
                // Comportement du père
                pids[i] = pid;
                if (i == 0) {
                    setpgid(pid, pid);
                }else{
                    setpgid(pid, pids[0]);
            }
        }
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

    while (1) {
        printf("myshell$ ");
        if (!fgets(line, sizeof(line), stdin))
            break; // trop long commande
        line[strcspn(line, "\n")] = '\0';
        if (!strcmp(line, "")) continue; // return 0 si deux string egal
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