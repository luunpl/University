#include <stdio.h>

#define ZERO_ZERO 0
#define UN_ZERO 1
#define ZERO_UN 2
#define DEUX_ZERO 3
#define UN_UN 4
#define ZERO_DEUX 5
#define FINI 6

#define PILE 0
#define FACE 1

#define INITIAL ZERO_ZERO

int transition[7][2] = {
    { UN_ZERO,   ZERO_UN },
    { DEUX_ZERO, UN_UN },
    { UN_UN,     ZERO_DEUX },
    { FINI,      FINI },
    { FINI,      FINI },
    { FINI,      FINI },
    { FINI,      FINI }
};

void sortie(int etat, char entree) {
  if (etat == DEUX_ZERO || etat == UN_UN && entree == 'P')
    printf("A gagne\n");
  if (etat == ZERO_DEUX || etat == UN_UN && entree == 'F')
    printf("B gagne\n");
}

int main() {

    int etat_courant = INITIAL;
    char entree;

    while (etat_courant != FINI) {
        scanf(" %c", &entree);
	sortie(etat_courant, entree);
        if (entree == 'P')
            etat_courant = transition[etat_courant][PILE];
        else
            etat_courant = transition[etat_courant][FACE];
//        printf("Nouvel état : %d\n", etat_courant);
    }

    return 0;
}
