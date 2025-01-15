#ifndef _TYPE_IMAGE_H_
#define _TYPE_IMAGE_H_

#define LARGEUR_MAX 600
#define HAUTEUR_MAX 600

/* Un pixel est un entier (niveau de gris) */
typedef int Pixel;

/* Type Image : structure pour représenter une image en niveaux de gris */
typedef struct {
  /* Nombre de pixels en largeur */
  int largeur;
  /* Nombre de pixels en hauteur */
  int hauteur;
  /* Les pixels valent de 0 (noir) à maxval (blanc) ; maxval > 0 */
  int maxval;
  /* Le tableau de pixels */
  Pixel pixels[LARGEUR_MAX][HAUTEUR_MAX];
} Image;

/* initialise une image im de dimensions l (largeur) et h (hauteur)
 avec max comme valeur maximale l'image est initialisée avec tous les
 pixels égaux à 0 */
void init_image(int l, int h, int max, Image *im);

/* renvoie la largeur de l'image */
int largeur(Image *im);

/* renvoie la hauteur de l'image */
int hauteur(Image *im);

/* renvoie la valeur maximale permise pour les pixels de l'image */
int maxval(Image *im);

/* renvoie la valeur du pixel en position (i,j) */
Pixel lepixel(Image *im, int i, int j);

/* modifie la valeur du pixel en position (i,j) avec la valeur p */
void affecter_pixel(Image *im, int i, int j, Pixel p);

#endif /* _TYPE_IMAGE_H_ */
