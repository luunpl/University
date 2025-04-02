#include <string.h>
#include <stdlib.h> 
#include <stdio.h> 

#include "table_symbole.h"
	

int initTS() {
    return 0;
}

extern void afficheTS(Couple TS[], int NbSymb) {
    for (int i = 0; i < NbSymb; i++) {
        printf("%s = %d\n", TS[i].nom, TS[i].valeur);
    }
}

extern int estPresentTS(char *idf, int *v, Couple TS[], int NbSymb) {
    for (int i = 0; i < NbSymb; i++) {
        if (strcmp(TS[i].nom, idf) == 0) {
            *v = TS[i].valeur;
            return 1;
        }
    }
    return 0;
}


extern int estPresentTS2(char *idf,Couple TS[], int NbSymb){
    for (int i = 0; i < NbSymb; i++) {
        if (strcmp(TS[i].nom, idf) == 0) {
            return 1;
        }
    }
    return 0;
}

extern void insererTS(char *idf, int v, Couple TS[], int *NbSymb) {
    int t = 0;
    for (int i = 0; i < *NbSymb; i++) {
        if (strcmp(TS[i].nom, idf) == 0) {
            TS[i].valeur = v;
            t = 1;
        }
    }
    if (t == 0) {
        strcpy(TS[*NbSymb].nom, idf);
        TS[*NbSymb].valeur = v;
        (*NbSymb)++;
    }
}