#include <stdlib.h>
#include <stdio.h>
#include "sequences.h"

/* acces_position : à écrire */


/* lecture d'une sequence d'entiers.
  En entrée : des entiers (-1 pour finir)*/
void saisir(liste_t *l, int valeurMin) {
  int n=-1;
  cellule_t *c;
  printf("Donner un entier (un entier négatif pour finir) :\n");
  scanf("%d",&n);
  if (n>=valeurMin) {
    c = (cellule_t *) malloc(sizeof(cellule_t));  
    c->valeur = n;
    c->suivant = NULL;  
    l->tete = c;
    printf("Donner un entier (un entier négatif pour finir) :\n");
    scanf("%d",&n);
    while (n>=valeurMin) {
      c->suivant = (cellule_t *) malloc(sizeof(cellule_t));
      c = c->suivant;
      c->valeur = n;
      c->suivant = NULL;  
      printf("Donner un entier (un entier négatif pour finir) :\n");
      scanf("%d",&n);}}
  else {
    l->tete = NULL;}
return;}

/* Affichage d'une sequence d'entiers.
  En  sortie : un espace entre deux entiers */
void afficher(liste_t l) {
  cellule_t *c;
  if (l.tete==NULL) {
    printf("\n");}
  else {
    c = l.tete;
    while (c!=NULL) {
      printf(" %d",c->valeur);
      c = c->suivant;}
    printf("\n");}
return;}

/* accés dans une sequence à une position donnée 0:en tête, 1:juste après, etc. */
/* renvoie l'adresse de la cellule à la position donnée */
/* si la position ne peut être atteinte, renvoie NULL */

cellule_t * acces_position(liste_t l, int p) {
  /* votre code ici */
return NULL;}
