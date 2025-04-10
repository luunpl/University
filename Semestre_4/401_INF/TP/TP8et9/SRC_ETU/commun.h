// Auteur : Philippe WAILLE   UGA

#ifndef _COMMUN_H_
#define _COMMUN_H_

#include "image_bits_include.h"   // definit WIDTH, HEIGHT, BYTES, BYTES_PER_LINE

typedef unsigned char ligne_t [BYTES_PER_LINE];

#ifdef SYMTAB
extern const unsigned char tabsym_octet [256];
#endif

extern unsigned char result_bits [BYTES];

typedef unsigned char octet_fonc_t(unsigned char,unsigned char);

unsigned char ou    (unsigned char x, unsigned char y);
unsigned char etnot (unsigned char x, unsigned char y);
unsigned char ouex  (unsigned char x, unsigned char y);

int afficher_chaine (char *format, char *chaine);
int afficher_entier (char *format, unsigned int entier);

void afficher_contenu (unsigned char *content);


// Fonctions auxiliaires ...
unsigned char neg_octet (unsigned char octet);
void symetrie_octet (unsigned char *adresse);
void permuter_cols (unsigned char *tab, unsigned int col);
void permuter_lignes (ligne_t *tab, unsigned int li);

// ... utilisées par ces fonctions :
void neg_image (unsigned char *image);
void symetrie_axe_v (unsigned char *image);
void symetrie_axe_h (unsigned char *image);

void rectangle (unsigned int xhg, unsigned int yhg, 
                unsigned int xbd, unsigned int ybd,
                octet_fonc_t f, unsigned char *image);
void traiter_point (unsigned char *image, unsigned int x, unsigned int y, 
                    octet_fonc_t *f);

#endif
