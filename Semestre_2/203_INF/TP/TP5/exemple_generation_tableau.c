#include <stdio.h>
#include "generer_entier.c"


// affiche a l'écran T[0..nb-1]
void afficher(long T[], int nb) {
    int i;
    printf("[ ");
    for (i = 0; i < nb; i++) {
        printf("%ld ", T[i]);
    }
    printf("]\n");
}

int main() {
    int Taille = 20;
    long T[Taille];
    int i;
    long valeur ;

    for (i = 0; i < Taille; i++) {
	valeur = generer_entier(100) ;
        T[i] = valeur ;
    }
    afficher(T, Taille);
    return 0;
}
