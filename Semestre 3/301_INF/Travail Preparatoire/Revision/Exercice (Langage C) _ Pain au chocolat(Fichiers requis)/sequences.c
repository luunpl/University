#include <stdlib.h>
#include <stdio.h>
#include "sequences.h"

/* Pain au chocolat  : à implementer */


/* lecture d'une sequence d'entiers.
  En entrée : des entiers (-1 pour finir)*/
void saisir(seqtab_t *S, int valeurMin) {
  int n=-1;
  int i = 0;
  do {
    printf("Donner un entier (un entier négatif pour finir) :\n");
    scanf("%d",&n);
    S->tab[i] = n;
    i++;
  }
  while (n >= valeurMin);
  S->longueur = i-1;   /* on ne compte pas le dernier élément (qui est < valMin) */
}

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


/* pain_au_chocolat */
liste_t pain_au_chocolat(seqtab_t *S)
{
  liste_t pain_au_chocolat;
  pain_au_chocolat.tete=NULL;
  /* votre code ici */
  return pain_au_chocolat;
}
