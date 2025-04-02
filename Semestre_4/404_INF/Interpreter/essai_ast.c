#include <stdio.h> 
#include "table_symbole.h"
#include "ast_construction.h"
#include "ast_parcours.h"

int main() {

 Ast ast1, ast2, ast3, ast4, ast5, ast6,  ast ;

 ast1  = creer_valeur(2) ;
 ast2  = creer_valeur(3) ;
 ast3 = creer_operation(N_PLUS, ast1, ast2) ;
 ast4  = creer_valeur(5) ;
 ast5 = creer_valeur(2);
 ast6 = creer_operation(N_MOINS, ast4, ast5) ;
 ast = creer_operation(N_MUL, ast3, ast6);


 printf("Arbre abstrait de l'expression\n") ;
 afficher_ast(ast) ; 
 printf("\n\nValeur de l'expression : %d\n", evaluation(ast)) ;
 return 0 ;

}
