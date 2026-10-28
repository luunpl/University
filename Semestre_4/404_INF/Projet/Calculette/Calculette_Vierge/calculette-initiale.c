
#include <stdlib.h> 
#include <stdio.h> 

#include "type_ast.h"
#include "analyse_syntaxique.h"
#include "ast_parcours.h"

 
int main (int argc, char *argv[]) {
   int syntaxeCorrecte ;
   Ast A ;	
   switch (argc) {
   	case 1: 
   		syntaxeCorrecte = analyser("", &A);
		break ;
   	case 2: 
   		syntaxeCorrecte = analyser(argv[1], &A);
		break ;
	default:
		printf("nombre d'arguments incorrects !\n");
		exit(1) ;
   } ;	
   if (syntaxeCorrecte) {
	printf(" \n RESULTAT = %d \n", evaluation(A));
   } ;
}
		
	
		
		
		
		

