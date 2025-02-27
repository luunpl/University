#include <stdlib.h>
#include <stdio.h>
#include "type_ast.h"

void aff_operateur(TypeOperateur op){
	switch (op) {
		case N_PLUS:
			printf(" + ") ;
			break;
		case N_MOINS:
			printf(" - ") ;
			break;
		case N_MUL:
			printf(" * ") ;
			break;
		case N_DIV:
			printf(" / ") ;
			break;

	} 
}

void afficherA(Ast expr) {
	switch (expr->nature) {
               case OPERATION:
                        printf("(");
                        afficherA(expr->gauche);
                        aff_operateur(expr->operateur) ;
                        afficherA(expr->droite);
                        printf(")");
			break ;
               case VALEUR:
                  	printf("%d", expr->valeur);
			break ;
	}
}

int evaluation(Ast expr) {
    int denominateur ;
	switch(expr->nature)
	{
	  case OPERATION:
		switch (expr->operateur)
		{

			case N_MUL:
			  return evaluation(expr->gauche)*evaluation(expr->droite);
	
			case N_MOINS:
			  return evaluation(expr->gauche)-evaluation(expr->droite);

			case N_PLUS:
			  return evaluation(expr->gauche)+evaluation(expr->droite);

			case N_DIV:
			  denominateur = evaluation(expr->droite) ;
			  if (denominateur != 0)
			      return evaluation(expr->gauche)/evaluation(expr->droite);
                          else 
			      printf("ERREUR : division par 0 !\n");
			      exit(1);
			
			default:
			  exit(1);  // erreur operateur
		}

	   case VALEUR:
		return expr->valeur; 
		
	   default:
		exit(2); // erreur Ast 
	}

}
