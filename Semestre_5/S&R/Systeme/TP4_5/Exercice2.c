#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/wait.h>
#include <string.h>
#include <errno.h>

int (*tableau_tubes)[2] = NULL; // Variable globale

void creer_tubes(int n) {
    // Allouer le tableau de n tubes tableau_tubes
    tableau_tubes = malloc(sizeof(int[2]) * n);
    if (!tableau_tubes) {
        perror("malloc");
        exit(1);
    }
    // Créer le tableau de n tubes tableau_tubes
    for (int i = 0; i < n; i++) {
        if (pipe(tableau_tubes[i]) == -1) {
            perror("pipe");
            exit(1);
        }
    }
}

void fermer_tubes(int i, int n) {
    /* pour processus i:
       - on garde lecture sur tableau_tubes[(i-1+n)%n][0] (entrée)
       - on garde écriture sur tableau_tubes[i][1] (sortie)
       fermer tout le reste */
    int prev = (i - 1 + n) % n;
    for (int j = 0; j < n; j++) {
        if (j == prev) {
            /* keep read end open */
            close(tableau_tubes[j][1]);
        } else if (j == i) {
            /* keep write end open */
            close(tableau_tubes[j][0]);
        } else {
            /* close both ends */
            close(tableau_tubes[j][0]);
            close(tableau_tubes[j][1]);
        }
    }
}

void passer_jeton(int i, int n) {
    /* Le fils i lit un entier depuis la lecture du tube prev et l'écrit sur
       son tube i (sortie) */
    int prev = (i - 1 + n) % n;
    int K;
    ssize_t r = read(tableau_tubes[prev][0], &K, sizeof(K));
    if (r == -1) {
        perror("read in passer_jeton");
        _exit(1);
    } else if (r == 0) {
        /* EOF: parent/previous closed unexpectedly */
        _exit(0);
    } else if (r != sizeof(K)) {
        fprintf(stderr, "Partial read in child %d: %zd bytes\n", i, r);
        _exit(1);
    }

    printf("fils %d a recu K=%d\n", i, K);

    /* Optionally modify K here if desired; spec says just pass it on */

    ssize_t w = write(tableau_tubes[i][1], &K, sizeof(K));
    if (w == -1) {
        perror("write in passer_jeton");
        _exit(1);
    } else if (w != sizeof(K)) {
        fprintf(stderr, "Partial write in child %d: %zd bytes\n", i, w);
        _exit(1);
    }

    /* close remaining descriptors and exit */
    _exit(0);
}

void lancer_jeton(int n) {
    /* Parent sends K into tableau_tubes[0][1], then waits to read it back from last pipe read end */
    int K = 42; /* example token value; could be read from stdin or argv */

    /* Close unnecessary descriptors for parent: keep write end of pipe 0 and read end of pipe n-1 */
    for (int j = 0; j < n; j++) {
        if (j == 0) {
            close(tableau_tubes[j][0]); /* parent writes into pipe 0 */
        } else if (j == n-1) {
            close(tableau_tubes[j][1]); /* parent reads from pipe n-1 */
        } else {
            close(tableau_tubes[j][0]);
            close(tableau_tubes[j][1]);
        }
    }

    ssize_t w = write(tableau_tubes[0][1], &K, sizeof(K));
    if (w == -1) {
        perror("write in lancer_jeton");
        return;
    } else if (w != sizeof(K)) {
        fprintf(stderr, "Parent partial write: %zd bytes\n", w);
        return;
    }

    printf("pere a envoye K=%d\n", K);

    int K2;
    ssize_t r = read(tableau_tubes[n-1][0], &K2, sizeof(K2));
    if (r == -1) {
        perror("read in lancer_jeton");
        return;
    } else if (r == 0) {
        fprintf(stderr, "Parent: got EOF before token returned\n");
        return;
    } else if (r != sizeof(K2)) {
        fprintf(stderr, "Parent partial read: %zd bytes\n", r);
        return;
    }

    printf("pere a recu K=%d\n", K2);
}

int main(int argc, char *argv[]) {
    if (argc != 2) {
        fprintf(stderr, "Usage: %s NB\n", argv[0]);
        return 1;
    }
    char *endptr;
    long nb = strtol(argv[1], &endptr, 10);
    if (*endptr != '\0' || nb <= 0) {
        fprintf(stderr, "NB must be a positive integer\n");
        return 1;
    }
    int n = (int)nb;

    creer_tubes(n);

    /* fork n-1 children numbered 1..n-1 (father is 0) */
    for (int i = 1; i < n; i++) {
        pid_t pid = fork();
        if (pid == -1) {
            perror("fork");
            return 1;
        } else if (pid == 0) {
            /* child process i */
            fermer_tubes(i, n);
            passer_jeton(i, n);
            /* noter: passer_jeton termine avec _exit */
        }
        /* parent continues to create next child */
    }

    /* parent process behaves as process 0: keep necessary fds and launch token */
    lancer_jeton(n);

    /* parent waits for all children */
    for (int i = 1; i < n; i++) {
        int status;
        if (wait(&status) == -1) {
            perror("wait");
        }
    }

    /* close remaining parent descriptors */
    for (int j = 0; j < n; j++) {
        /* some may already be closed */
        close(tableau_tubes[j][0]);
        close(tableau_tubes[j][1]);
    }
    free(tableau_tubes);

    return 0;
}