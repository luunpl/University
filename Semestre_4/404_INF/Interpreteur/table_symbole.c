#include <string.h>
#include <stdlib.h>
#include <stdio.h>

#include "table_symbole.h"

int initTS() {
    return 0;
}

void afficheTS(Couple TS[], int NbSymb) {
    for (int i = 0; i < NbSymb; i++) {
        printf("%s = %d\n", TS[i].nom, TS[i].valeur);
    }
}

int estPresentTS(char *idf, int *v, Couple TS[], int NbSymb) {
    for (int i = 0; i < NbSymb; i++) {
        if (strcmp(TS[i].nom, idf) == 0) {
            *v = TS[i].valeur;
            return 1;
        }
    }
    return 0;
}

int estPresentTS2(char *idf, Couple TS[], int NbSymb) {
    for (int i = 0; i < NbSymb; i++) {
        if (strcmp(TS[i].nom, idf) == 0) {
            return 1;
        }
    }
    return 0;
}

void insererTS(char *idf, int v, Couple TS[], int *NbSymb) {
    for (int i = 0; i < *NbSymb; i++) {
        if (strcmp(TS[i].nom, idf) == 0) {
            TS[i].valeur = v;
            return;
        }
    }
    // Si l'identifiant n'est pas présent, on l'ajoute
    strcpy(TS[*NbSymb].nom, idf);
    TS[*NbSymb].valeur = v;
    (*NbSymb)++;
}
