#include "es_tableau.h"
#include <stdio.h>

void lire_tableau(char *nomFichier, tableau_entiers *t) {
  /* Descripteur du fichier d'entrée */
  FILE *fichier;
  int i;

  /* Ouverture du fichier en lecture */
  fichier = fopen(nomFichier, "r");

  /* Lecture de la taille du tableau */
  fscanf(fichier, "%d", &(t->taille));

  /* Lecture des valeurs du tableau */
  for (i = 0; i < t->taille; i++) {
    fscanf(fichier, "%d", &(t->tab[i]));
  }
  fclose(fichier);
}

void ecrire_tableau(char *nomFichier, tableau_entiers *t) {
  /* Descripteur du fichier de sortie */
  FILE *fichier;
  int i;

  /* Créer et ouvrir le fichier en écriture */
  fichier = fopen(nomFichier, "w");

  /* Écrire la taille du tableau dans le fichier */
  fprintf(fichier, "%d\n", t->taille);

  /* Écrire les valeurs du tableau */
  for (i = 0; i < t->taille; i++) {
    fprintf(fichier, "%d\n", t->tab[i]);
  }
  /* Fermeture du fichier */
  fclose(fichier);
}
