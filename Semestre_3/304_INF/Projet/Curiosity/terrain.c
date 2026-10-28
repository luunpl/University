
#include "terrain.h"
#include "robot.h"
#include <stdio.h>
#include <string.h>

erreur_terrain lire_terrain(FILE *f, Terrain *t, int *x, int *y) {
  int l, h;          // Dimensions du terrain
  int rx, ry;        // Coordonnées initiales du robot
  int pos_robot = 0; // Booléen : vrai si la position du robot a été lue
  int n;             // Nombre de valeurs lues
  char *res;         // Résultat de la lecture d'une ligne
  int lgligne;       // Longueur de la ligne lue
  int i, j;
  char ligne[DIM_MAX];
  Case c;

  if (f == NULL) {
    return ERREUR_FICHIER;
  }

  // Lecture de la largeur
  n = fscanf(f, "%d", &l);
  if (n == 0) {
    return ERREUR_LECTURE_LARGEUR;
  } else if ((l < 0) || (l > DIM_MAX)) {
    return ERREUR_LARGEUR_INCORRECTE;
  }
  t->largeur = l;
  // Lecture de la hauteur
  n = fscanf(f, "%d", &h);
  if (n == 0) {
    return ERREUR_LECTURE_HAUTEUR;
  } else if ((h < 0) || (h > DIM_MAX)) {
    return ERREUR_HAUTEUR_INCORRECTE;
  }
  t->hauteur = h;
  // Lecture du terrain
  // Lecture du caractère de retour à la ligne précédant la première ligne
  fscanf(f, "\n");
  for (j = 0; j < h; j++) {
    // Lecture d'une ligne dans le fichier
    res = fgets(ligne, DIM_MAX, f);
    if (res == NULL) {
      return ERREUR_LIGNES_MANQUANTES;
    }
    lgligne =
        strlen(ligne) - 1; // Tenir compte du caractère de retour à la ligne
    if (lgligne < l) {
      return ERREUR_LIGNE_TROP_COURTE;
    } else if (lgligne > l) {
      return ERREUR_LIGNE_TROP_LONGUE;
    }
    // Parcours de la ligne
    for (i = 0; i < l; i++) {
      // Initialisation d'une case
      switch (ligne[i]) {
      case '.':
        c = LIBRE;
        break;
      case '#':
        c = ROCHER;
        break;
      case '~':
        c = EAU;
        break;
      case 'C':
        c = LIBRE;
        rx = i;
        ry = j;
        pos_robot = 1;
        break;
      default:
        return ERREUR_CARACTERE_INCORRECT;
      }
      t->tab[i][j] = c;
    }
  }
  if (!pos_robot) {
    return ERREUR_POSITION_ROBOT_MANQUANTE;
  }
  // Initialisation de la position du robot
  *x = rx;
  *y = ry;

  return OK;
}

int largeur(Terrain *t) { return t->largeur; }

int hauteur(Terrain *t) { return t->hauteur; }

int est_case_libre(Terrain *t, int x, int y) {
  if ((x >= 0) && (x < t->largeur) && (y >= 0) && (y < t->hauteur)) {
    return t->tab[x][y] == LIBRE;
  } else {
    return 0; // false
  }
}

void afficher_terrain(Terrain *t) {
  int i, j;
  char c;

  for (j = 0; j < t->hauteur; j++) {
    for (i = 0; i < t->largeur; i++) {
      switch (t->tab[i][j]) {
      case LIBRE:
        c = '.';
        break;
      case ROCHER:
        c = '#';
        break;
      case EAU:
        c = '~';
        break;
      }
      printf("%c", c);
    }
    printf("\n");
  }
}

void ecrire_terrain(FILE *f, Terrain *T, int x, int y) {
  int i, j;
  char c;

  fprintf(f, "%d\n", T->largeur);
  fprintf(f, "%d\n", T->hauteur);
  for (j = 0; j < T->hauteur; j++) {
    for (i = 0; i < T->largeur; i++) {
      switch (T->tab[i][j]) {
      case LIBRE:
        c = '.';
        break;
      case ROCHER:
        c = '#';
        break;
      case EAU:
        c = '~';
        break;
      }
      if (i == x && j == y)
        c = 'C';
      fprintf(f, "%c", c);
    }
    fprintf(f, "\n");
  }
  fprintf(f, "\n");
}
