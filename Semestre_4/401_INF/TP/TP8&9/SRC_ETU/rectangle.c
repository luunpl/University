// Auteur : Philippe WAILLE   UGA


#include "commun.h"
#include "image_bits_include.h"

unsigned char ou    (unsigned char x, unsigned char y) {return x | y;}
unsigned char etnot (unsigned char x, unsigned char y) {return x & ~y;}
unsigned char ouex  (unsigned char x, unsigned char y) {return x ^ y;}

unsigned int masque (unsigned int x) {
   return 1 << (x%8);
}

void traiter_point (unsigned char *image, unsigned int x, unsigned int y, octet_fonc_t *f) {
  unsigned char *octet;
  unsigned char m;
  unsigned char contenu;

  octet = image + y*octets_par_ligne_image + x/8;
  m = masque (x);
  contenu = *octet;
  contenu = (*f) (contenu,m);
  *octet = contenu;
}

void horizontale (unsigned char *image, unsigned int g, 
                  unsigned int y, unsigned int d, octet_fonc_t *f) {
  while (g < d) {
    traiter_point (image,g,y,f);
    g++;
  }
}

void verticale (unsigned char *image, unsigned int x, 
                unsigned int h, unsigned int b, octet_fonc_t *f) {
  while (h<b) {
    traiter_point (image,x,h,f);
    h++;
  }
}


void rectangle (unsigned int xhg,unsigned int yhg, unsigned int xbd, unsigned int ybd,
                octet_fonc_t f, unsigned char *image) {

  if (xhg > xbd) return;
  if (xhg > width) return;
  if (yhg > ybd) return;
  if (ybd > height) return;

  horizontale(image,xhg,yhg,xbd,f);
  if (ybd > yhg) horizontale(image,xhg,ybd,xbd,f);
  if (ybd > yhg+1) {
    verticale (image,xhg,yhg,ybd,f);
    verticale (image,xbd,yhg,ybd,f);
  }
}  

