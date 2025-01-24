#ifndef __JOUEURS_OUT_H__
#define __JOUEURS_OUT_H__
#include <stdio.h>
#include "joueurs.h"

/*
  Enregistre l'ensemble de joueurs dans un fichier portant le nom choisi.
  Le contenu du fichier devra suivre rigoureusement le format :
  - sur la première ligne, le nombre de joueurs de l'ensemble
  - puis, sur chaque ligne, un nom de joueur, une espace et son nombre de billes
 */
void ecrire_les_joueurs(joueurs *ens, char *nom_fich);

/* Utilisé uniquement pour l'exercice complémentaire.
  Enregistre un sous-ensemble de joueurs dans un fichier portant le nom choisi.
  Le format du fichier est le même que pour les autres fichiers de
  joueurs lus ou écrits jusque là.
 */
void ecrire_les_elements(joueurs *e, int ens[], char *nom_fich);

#endif
