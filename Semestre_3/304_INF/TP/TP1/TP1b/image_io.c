
#include "image_io.h"

#define TAILLE_BUFFER 256

/* lire l'image contenue dans le fichier PGM Texte nommé nom_fichier
   et placer le résultat dans im */
void lecture_fichier(char *nom_fichier, Image *im) {
  FILE *f;
  int l, h, m;
  Pixel p;
  /* Tampon (buffer) pour lecture de lignes complètes */
  char buffer[TAILLE_BUFFER];
  int i, j;

  f = fopen(nom_fichier, "r");

  /* Passer les 2 premières lignes */
  fgets(buffer, TAILLE_BUFFER, f); /* Nombre magique "P2" */
  fgets(buffer, TAILLE_BUFFER, f); /* Commentaire */
  /* Lecture de la largeur */
  fscanf(f, "%d", &l);
  /* Lecture de la hauteur */
  fscanf(f, "%d", &h);
  /* Lecture de la valeur maximum */
  fscanf(f, "%d", &m);

  /* Créer une image de dimensions (l,h) et de valeur maximum m */
  init_image(l, h, m, im);

  /* Lecture des valeurs de chacun des pixels */
  for (j = 0; j < h; j++) {
    for (i = 0; i < l; i++) {
      fscanf(f, "%d", &p);
      affecter_pixel(im, i, j, p);
    }
  }

  /* fermeture du fichier */
  fclose(f);
}

/* Écrire l'image im dans le fichier nommé nom_fichier au format PGM
   Texte */
void ecriture_fichier(char *nom_fichier, Image *im) {
  FILE *f;
  int l = largeur(im);
  int h = hauteur(im);
  int i, j;

  /* Ouvrir/créer le fichier en écriture */
  f = fopen(nom_fichier, "w");

  /* Écrire les deux premières lignes */
  fprintf(f, "P2\n");
  fprintf(f, "# Fichier cree par transformation_image\n");

  /* Écrire les dimensions de l'image */
  fprintf(f, "%d %d\n", largeur(im), hauteur(im));

  /* Écrire la valeur maximum */
  fprintf(f, "%d\n", maxval(im));

  /* Écrire les valeurs des pixels */
  for (j = 0; j < h; j++) {
    for (i = 0; i < l; i++) {
      fprintf(f, "%d ", lepixel(im, i, j));
    }
    /* Fin d'une ligne de pixels : retour à la ligne dans le fichier */
    fprintf(f, "\n");
  }

  /* Fermeture du fichier */
  fclose(f);
}
