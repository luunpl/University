#include <string.h>
#include <stdio.h>
#include "joueurs.h"

void init_joueurs(joueurs *ens) {
}

int ajouter_joueur(joueurs *ens, char *nom, int billes) {
  return -1;
}

int nombre_joueurs(joueurs *ens) {
  return 0;
}

char *nom_joueur(joueurs *ens, int i) {
    return NULL;
}

int billes_joueur(joueurs *ens, int i) {
  return 0;
}

int trouver_joueur(joueurs *ens, char *nom) {
    return -1;
}

void modifier_billes(joueurs *ens, int i, int cpt) {
}

void afficher_ensemble_joueurs(joueurs *ens) {
    int i ;
    for (i=0 ; i<ens->nb ; i++) 
      printf("%s %d\n", ens->T[i].pseudo, ens->T[i].nb_billes) ;
}
