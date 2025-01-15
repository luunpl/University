#include <stdio.h>
#include <stdlib.h>
#include "type_pile_erreurs.h"  // Assuming this file defines erreur_pile, OK, PILE_VIDE, PILE_PLEINE, POINTEUR_NUL

#define TAILLE_MAX 100  // Assuming a maximum size for the stack

erreur_pile creer_pile(PileEntiers *p) {
    if (p != NULL) {
        p->n = 0;
        return OK;
    } else {
        return POINTEUR_NUL;
    }
}

/* Return true if the stack is empty */
int est_vide(PileEntiers *p) { 
    return (p != NULL && p->n == 0);
}

/* Return true if the stack is full */
int est_pleine(PileEntiers *p) { 
    return (p != NULL && p->n == TAILLE_MAX);
}

erreur_pile sommet(PileEntiers *p, int *res) {
    if (p == NULL) return POINTEUR_NUL;
    if (!est_vide(p)) {
        *res = p->tab[p->n - 1];
        return OK;
    } else {
        return PILE_VIDE;
    }
}

/* Return the number of elements in the stack */
int taille(PileEntiers *p) {
    return p != NULL ? p->n : 0;
}

/* Print the elements of the stack */
void print(PileEntiers *p) {
    if (p != NULL) {
        printf("Éléments de la pile : ");
        for (int i = 0; i < p->n; i++) {
            printf("%d ", p->tab[i]);
        }
        printf("\n");
    } else {
        printf("Pile non initialisée\n");
    }
}

erreur_pile vider(PileEntiers *p) {
    if (p != NULL) {
        p->n = 0;
        return OK;
    } else {
        return POINTEUR_NUL;
    }
}

erreur_pile empiler(PileEntiers *p, int x) {
    if (p == NULL) return POINTEUR_NUL;
    if (!est_pleine(p)) {
        p->tab[p->n] = x;
        p->n++;
        return OK;
    } else {
        return PILE_PLEINE;  // Stack is full
    }
}

erreur_pile depiler(PileEntiers *p, int *resultat) {
    if (p == NULL) return POINTEUR_NUL;
    if (!est_vide(p)) {
        p->n--;
        *resultat = p->tab[p->n];
        return OK;
    } else {
        return PILE_VIDE;  // Stack is empty
    }
}
