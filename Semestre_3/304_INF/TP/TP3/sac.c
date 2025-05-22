
#include "sac.h"
#include <stdio.h>
#include <stdlib.h>

/* Initialise une structure de sac s à partir du fichier de nom f_nom */
void initialiser_sac(sac *s, char *f_nom) {
  FILE *f;
  int n;
  int i, j;

  f = fopen(f_nom, "r");
  fscanf(f, "%d", &n);

  s->taille = n;

  for (i = 0; i < s->taille; i++) {
    for (j = 0; j < s->taille; j++) {
      fscanf(f, "%d", &(s->tab[i][j]));
    }
  }
}

/* Taille du sac (n) */
int taille_sac(sac *s) { return s->taille; }

/* Nombre de valeurs du sac (n*n) */
int nbvaleurs_sac(sac *s) { return (s->taille) * (s->taille); }

/* Affichage du sac s à l'écran */
void afficher_sac(sac *s) {
  int i, j;

  printf("Sac de dimension %d = %dx%d\n", nbvaleurs_sac(s), taille_sac(s),
         taille_sac(s));
  for (i = 0; i < s->taille; i++) {
    for (j = 0; j < s->taille; j++) {
      printf("%d ", s->tab[i][j]);
    }
    printf("\n");
  }
  printf("\n");
}
