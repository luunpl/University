// Auteur : Philippe WAILLE   UGA

#include "commun.h"
#include "image_bits_include.h"

#define LINE_LENGTH 12

void afficher_contenu (unsigned char *address) {
   int i;
   int position;

   afficher_entier("\n#define width %d\n", WIDTH);
   afficher_entier("#define height %d\n\n", HEIGHT);
   afficher_chaine("static unsigned char bits[] = {\n","");
   
   i=0;
   position=LINE_LENGTH;
   while (i<BYTES) {
      position --;
      afficher_entier("0x%02x", *address);
      if (i != BYTES -1) afficher_chaine(", ","");
      if (position == 0) {
        afficher_chaine("\n","");
        position =LINE_LENGTH;
      }
      address++;
      i++;
   }

   afficher_chaine ("};\n","");
}


