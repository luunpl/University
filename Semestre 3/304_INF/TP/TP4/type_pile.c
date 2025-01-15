#include "type_pile.h"
#include <stdio.h>

/* Créer une pile vide */
void creer_pile(PileEntiers *p){ 
    p->n = 0;}

/* Retourne vrai ssi p est vide */
int est_vide(PileEntiers *p){ 
    return (p->n == 0);}

/* Renvoie l'entier en haut de la pile */
/* p doit être non vide */
int sommet(PileEntiers *p){ 
    return p->tab[p->n - 1];}

/* Renvoie le nombre d'éléments dans la pile */
int taille(PileEntiers *p) {
    return p->n;}

/* Afficher les éléments de la pile */
void print(PileEntiers *p){
    for (int i = 0; i < p->n; i++){
        printf("%d\n", p->tab[i]);
    }
}

/* Opérations de modification */

/* Vider la pile p */
void vider(PileEntiers *p){ 
    p->n = 0;}

/* Empiler un entier x */
/* Précondition : taille(p) < TAILLE_MAX */
void empiler(PileEntiers *p, int x){
    p->tab[p->n] = x;
    p->n = p->n + 1;
}

/* Supprimer et renvoyer l'entier en haut de la pile */
/* Précondition : p non vide */
int depiler(PileEntiers *p){
    p->n = p->n - 1;
    return p->tab[p->n];
}


