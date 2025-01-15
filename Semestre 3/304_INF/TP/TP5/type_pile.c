#include "type_pile.h"
#include <stdio.h> 
#include <stdbool.h> 



void creer_pile(PileEntiers *p) {
    p->n = 0;
}
int est_vide(PileEntiers *p) {
    return p->n == 0;
}
int sommet(PileEntiers *p) {
    return p->tab[p->n - 1];
}
int taille(PileEntiers *p) {
    return p->n; 
}
void print(PileEntiers *p) {
    if (est_vide(p)) {
        printf("La pile est vide.\n");
        return;
    }
    printf("Éléments de la pile : ");
    for (int i = 0; i < p->n; i++) {
        printf("%d ", p->tab[i]);
    }
    printf("\n");
}


void vider(PileEntiers *p) {
    p->n = 0; 
}
void empiler(PileEntiers *p, int x) {
    if (p->n >= TAILLE_MAX) {
        printf("Erreur : La pile est pleine. Impossible d'empiler %d.\n", x);
        return; 
    }
    p->tab[p->n] = x; 
    p->n++; 
}   
int depiler(PileEntiers *p) {
    if (est_vide(p)) {
        printf("Erreur : La pile est vide. Impossible de dépiler.\n");
        return -1; 
    }
    p->n--; 
    return p->tab[p->n]; 
}