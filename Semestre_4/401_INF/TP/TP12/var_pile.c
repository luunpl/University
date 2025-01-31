#include "stdio.h"

#define N 100

short int Compare2Chaines (char *s1, char *s2) {
char *p1, *p2 ;

   p1 = s1 ; p2 = s2 ;
   while ( *p1 && *p2 && (*p1 == *p2) ) {
      p1++ ; p2++ ;
   }
   return (*p1 == 0) && (*p2 == 0) ;
}

int main () {

short int      r ;
char    chaine1 [N], chaine2[N] ;

   printf("Chaine 1, de moins de 99 caracteres : \n");
   fgets (chaine1, N, stdin);
   printf("Chaine 2, de moins de 99 caracteres : \n");
   fgets (chaine2, N, stdin);

   r = Compare2Chaines (chaine1,chaine2);

   printf("Sont-elles egales ? %s !\n", (r ? "oui" : "non"));
}
