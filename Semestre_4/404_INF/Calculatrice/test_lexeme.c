

/* Exemple d'utilisation de l'analyse lexicale : 
    Affichage d'une sequence de lexemes            */

#include <stdio.h>

#include "analyse_lexicale.h"

int main (int argc, char *argv[]) {
   if (argc >= 1) {
   	demarrer (argv[1]) ;
   } else {
	printf("Il faut donner un nom de fichier en argument !") ;
	return 1 ; 
   } ; 
   while (! fin_de_sequence()) { 
        afficher (lexeme_courant()) ;
	printf("\n") ;
	avancer() ;
   } ;
   return 0 ;
}
