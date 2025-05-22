#include "type_image.h"

/* initialise une image im de dimensions l (largeur) et h (hauteur)
 avec max comme valeur maximale l'image est initialisée avec tous les
 pixels égaux à 0 */
void init_image(int l, int h, int max, Image *im) {
  int i, j;

  im->largeur = l;
  im->hauteur = h;
  im->maxval = max;
  for (i = 0; i < l; i++) {
    for (j = 0; j < h; j++) {
      im->pixels[i][j] = 0;
    }
  }
}

/* renvoie la largeur de l'image */
int largeur(Image *im) { return im->largeur; }

/* renvoie la hauteur de l'image */
int hauteur(Image *im) { return im->hauteur; }

/* renvoie la valeur maximale permise pour les pixels de l'image */
int maxval(Image *im) { return im->maxval; }

/* renvoie la valeur du pixel en position (i,j) */
Pixel lepixel(Image *im, int i, int j) { return im->pixels[i][j]; }

/* modifie la valeur du pixel en position (i,j) avec la valeur p */
void affecter_pixel(Image *im, int i, int j, Pixel p) { im->pixels[i][j] = p; }
