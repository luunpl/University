#include <stdio.h>

extern int x;
extern int y;
extern int f91(int);

void affichageImmediat_C() {
    setbuf(stdout, NULL);
    return;}

void saisie_C(void) {
  printf("(C) Donner un nombre :\n");
  scanf("%d",&x);
  return;}

void appel_C(void) {
  printf("(C) Appel de la fonction\n");  
  y=f91(x);
  return;}

void affichage_C(void) {
  printf("(C) Resultat :\n%d\n",y);
  return ;}

int f91_C(int n) {
    int loc;
    printf("(C) Code de la fonction\n");  
    if (n>100) loc = n-10;
    else { 
        loc = f91_C(n+11);
        loc = f91_C(loc);}
    return loc;}
  