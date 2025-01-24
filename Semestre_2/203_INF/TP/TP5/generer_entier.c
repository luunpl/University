#include <stdlib.h>
#include <unistd.h>

// Genere un entier entre 0 et borne-1
long generer_entier(long borne) {
    static int seme = 0;
    if (!seme) {
        srandom(getpid());
        seme = 1;
    }
    return random() % borne;
}
