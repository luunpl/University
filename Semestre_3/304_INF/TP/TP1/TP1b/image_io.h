#ifndef _IMAGE_IO_H_
#define _IMAGE_IO_H_

#include "type_image.h"
#include <stdio.h>

/* lire l'image contenue dans le fichier PGM Texte nommé nom_fichier
   et placer le résultat dans im */
void lecture_fichier(char *nom_fichier, Image *im);

/* Écrire l'image im dans le fichier nommé nom_fichier au format PGM
   Texte */
void ecriture_fichier(char *nom_fichier, Image *im);

#endif
