#include <stdio.h> 

#include "ast_construction.h"
#include "ast_parcours.h"

int main() {

 Ast ast1, ast2, ast3, ast4, ast ;

 ast1  = creer_valeur(12) ;
 ast2  = creer_valeur(3) ;
 ast3 = creer_operation(PLUS, ast1, ast2) ;
 ast4  = creer_valeur(2) ;
 ast = creer_operation(MUL, ast3, ast4) ;


 printf("Arbre abstrait de l'expression\n") ;
 afficher(ast) ; 
 printf("\n\nValeur de l'expression : %d\n", evaluation(ast)) ;
 return 0 ;

}
