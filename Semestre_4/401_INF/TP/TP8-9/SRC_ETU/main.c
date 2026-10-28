#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

#include "commun.h"
#include "image_bits_include.h"
#include "image_bits_content.c"

FILE *fich_res;

unsigned char result_bits [BYTES];

int afficher_chaine (char *format, char *chaine) {
  return fprintf (fich_res,format,chaine);
}

int afficher_entier (char *format, unsigned int entier) {
  return fprintf (fich_res,format,entier);
}

void usage () {
  fprintf (stderr,
"Transformation d'une image bitmap\n"
"A chaque changement d'image :\n"
"  1) /bin/rm image_test.bm; ln -s votre_image.bm image_test.bm\n"
"  2) Recompiler : make \n"
"  3) Execution : ./transformer option\n"
"       ./transformer n : negatif\n" 
"       ./transformer h : symetrie horizontale\n"
"       ./transformer v : symetrie verticale\n"
"       ./transformer nv : negatif + symetrie verticale\n"
"       ./transformer hv : rotation = double symetrie\n"
"                      etc\n"
  );
  exit(EXIT_FAILURE);
}


int main(int argc, char *argv[]) {
  char *options;

  bool neg = false;
  bool sym_v = false;
  bool sym_h = false;
 
  if (argc != 2) usage();
  options = argv[1];

   // copy image
   memcpy(result_bits, bits, BYTES);

   while (*options != 0) {
     switch (*options++) {
        case 'n' : neg = true; break;
        case 'h' : sym_h = true; break;
        case 'v' : sym_v = true; break;
        default : usage ();
     }
   }

   if (neg)   { neg_image(result_bits); }
   if (sym_v) { symetrie_axe_v (result_bits); }
   if (sym_h) { symetrie_axe_h (result_bits);}

   printf ("Production du fichier resultat.bm\n");
   if ( (fich_res = fopen("resultat.bm", "w")) == NULL ) {
       printf ("%s : impossible d'ouvrir le fichier %s\n",
               argv[0], "resultat.bm");
      exit(1);
   }


   afficher_contenu (result_bits);

   fclose (fich_res);

  return 0;
}
