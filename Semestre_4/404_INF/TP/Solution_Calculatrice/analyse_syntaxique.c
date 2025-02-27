/* ------------------------------------------------------------------------
-- module analyse_syntaxique
--
-- analyse lexicale d'une expression arithmetique
--
-- J-P. Peyrin, G. Serasset (version initiale) : janvier 1999
-- P.Habraken - 18/01/2010
--
-- 10 juin 2006 - PH :
-- remplacement record a champs variants par record "plat"
-- remplacement traitement iteratif par automate
--
-- Aout 2016 - LM : version C
------------------------------------------------------------------------ */

#include <string.h>
#include <stdlib.h> 
#include <stdio.h> 

#include "type_ast.h"
#include "ast_construction.h"
#include "ast_parcours.h"
#include "analyse_lexicale.h"

	void rec_eag(Ast *A1);
	void seq_terme(Ast *A2);
 	void suite_seq_terme(Ast A1 , Ast *A2);
	void terme(Ast *A1);
	void seq_facteur(Ast *A2);
	void suite_seq_facteur(Ast A1 , Ast *A2);
	void facteur(Ast *A1);
	int op1(TypeOperateur *Op);
	int op2(TypeOperateur *Op);
	TypeOperateur Operateur(Nature_Lexeme nature);
 
   
 	 void rec_eag(Ast *A1)
 	 {
 		seq_terme(A1);
 	 }
 	 
 	 void seq_terme(Ast *A2)
 	 {
		Ast A1;
 		terme(&A1);
 		suite_seq_terme(A1,A2);
 	 }

 	void suite_seq_terme(Ast A1 , Ast *A2)
	{
		Ast A3,A4;
		TypeOperateur op;
			
		if(op1(&op))
		{
		terme(&A3);
		A4 = creer_operation(op,A1,A3);
		suite_seq_terme(A4,A2);		
		}	
		else
		{
			*A2=A1;		
		}
	}
	
	void terme(Ast *A1)
	{
		seq_facteur(A1);
	}
	
	void seq_facteur(Ast *A2)
	{
		Ast A1;
		facteur(&A1);
		suite_seq_facteur(A1,A2);
	}
	
	void suite_seq_facteur(Ast A1 , Ast *A2)
	{
		Ast A3,A4;
		TypeOperateur op;
		int r = op2(&op);
		if(r!=0)
		{
		facteur(&A3);
		A4 = creer_operation(op,A1,A3);
		suite_seq_facteur(A4,A2);
		}
		else
		{
			*A2=A1;		
		}
		
		
	}
	
	void facteur(Ast *A1)
	{
		switch(lexeme_courant().nature){
			case ENTIER:
				*A1 = creer_valeur(lexeme_courant().valeur);
				avancer();
				break;
			case PARO:
				avancer();
				rec_eag(A1);
				if(lexeme_courant().nature == PARF)
		  		{
		  			avancer();
		  		}
		  		else
		  		{
		  			printf("ERREUR : parenthese fermante attendue (ligne %u, colonne %u)\n",
                                                    lexeme_courant().ligne, lexeme_courant().colonne);
		  			exit(1);
		  		}
		  		break;
		  	default:
		  			printf("ERREUR : entier ou parenthese ouvrante attendu (ligne %u, colonne %u)\n",
                                                    lexeme_courant().ligne, lexeme_courant().colonne);
		  			exit(0);

		  }
	}
	
	int op1(TypeOperateur *Op)
	{
		switch(lexeme_courant().nature){
			case PLUS:
			case MOINS:
				*Op = Operateur(lexeme_courant().nature);
				avancer(); 
				return 1;
			default:
				return 0;
		}
	}
	
	int op2(TypeOperateur *Op)
	{ 
		switch(lexeme_courant().nature){
			case MUL: 
			case DIV: 
				*Op = Operateur(lexeme_courant().nature);
				avancer();
				return 1;
			default: 
				return 0;
		}
	}
		 
 	 	TypeOperateur Operateur(Nature_Lexeme nature)
{
		switch(nature)
		{
			case PLUS : return N_PLUS;
			case MOINS : return N_MOINS;
			case MUL: return N_MUL;
			case DIV : return N_DIV;
			default: printf("Erreur operateur"); exit(1) ; 
		}
}
	
/* ----------------------------------------------------------------------- */
int analyser(char* nomFichier, Ast *A)
{
	demarrer(nomFichier) ;
   	rec_eag(A);
		
	if ((lexeme_courant().nature == FIN_SEQUENCE)) {
		/* syntaxe correcte */
		printf("\nSyntaxe correcte\n"); 
		afficherA (*A);  // on affiche l'AST
		printf("\n");
   		return 1 ;	
   	} else {
		printf("Erreur lors de l'analyse syntaxique ...\n"); 
		return 0 ;
        } ;
}	 
 	 
