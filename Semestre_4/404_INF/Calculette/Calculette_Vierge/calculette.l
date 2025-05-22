
  /* Spécification de l'analyse lexicale de la V1 de la calculette
         pour l'outil flex */

%{

  /* types et variables utlisés par l'analyseur */

#include <stdio.h>
#include <stdlib.h>
#include "analyse_lexicale.h"

   unsigned int numcol=1 ; // numero de colonne courant

   Lexeme LC ;  // lexeme_courant

   /* fonction d'initialisation du lexème courant */
   void initLC () {
		strcpy(LC.chaine, yytext);
		LC.ligne=yylineno;
		LC.colonne=numcol;
		numcol=numcol+yyleng;
	      } ;
%}

%option yylineno
%option noyywrap

 /* expressions régulières définissant les catégories lexicales */

CHIFFRE [0-9]

ENTIER    {CHIFFRE}.{CHIFFRE}*
OPERATEUR     [-+*/]
PARO	  "("
PARF	  ")"

%%

  /* actions effectuées par l'analyseur lors de la reconnaissance d'un lexème */

 /* Pour les séparateurs on met juste à jour la valeur de numcol */
[ ]    {numcol = numcol + 1;}
[\t]   {numcol = numcol + 4;}
[\n]   {numcol = 1;}


 /* lexeme de type ENTIER */
{ENTIER}       {
		initLC() ;
		LC.nature = ENTIER; 
		LC.valeur=atoi(yytext);
		return 0 ;
		}

 /* lexeme de type OPERATEUR */
{OPERATEUR} 	{
		initLC() ;
		switch (yytext[0]) {
			case '+' : LC.nature = PLUS; break ;
			case '-' : LC.nature = MOINS; break ;
			case '*' : LC.nature = MUL; break ;
			case '/' : LC.nature = DIV; break ;
		} ;
		return 0 ;
		}

 /* lexeme de type PARO */
{PARO} 	{
		initLC() ;
		LC.nature = PARO; 
		return 0 ;
		}

 /* lexeme de type PARF */
{PARF} 	{
		initLC() ;
		LC.nature = PARF; 
		return 0 ;
		}

 /* lexeme de type FIN_DE_SEQUENCE  */
<<EOF>>     {
		initLC() ;	
		LC.nature=FIN_SEQUENCE ; 
		return 0 ;
            }
        


 /* Tous les autres cas  sont des erreurs lexicales  ...  */

.               {
		initLC() ;	
		LC.nature=ERREUR ;
		return 0 ;
	        }

%%

	/* fonctions auxilliaires fournies/utilisées par l'analyseur */

// renvoie la chaine de caracteres correspondant a la nature du lexeme
char *Nature_vers_Chaine (Nature_Lexeme nature) {
        switch (nature) {
                case ENTIER: return "ENTIER" ;
                case PLUS: return "PLUS" ;
                case MOINS: return "MOINS" ;
                case MUL: return "MUL" ;
                case DIV: return "DIV" ;
                case PARO: return "PARO" ;
                case PARF: return "PARF" ;
                case FIN_SEQUENCE: return "FIN_SEQUENCE" ;
                default: return "ERREUR" ;
        } ;
   }

// affichage d'un lexème 
void afficher(Lexeme l) {

      switch (l.nature) {
         case FIN_SEQUENCE:
            break;
         default:
            printf("ligne: %d, ", l.ligne);
            printf("colonne: %d, ", l.colonne);
            printf("[") ;
            printf("nature = %s", Nature_vers_Chaine(l.nature)) ;
            printf(", chaine = %s, ", l.chaine) ;
            switch(l.nature) {
                 case ENTIER:
                      printf("valeur = %d", l.valeur); break;
                 default:
                      break;
            } ;
            printf("]\n") ;
        } ;
   }


// lecture du lexeme suivant
void avancer() {
  yylex() ;  // fonction générée automatiquement !
} 

// valeur du lexeme courant
Lexeme lexeme_courant() {
  return LC ;
}

// fin de sequence de lexemes
int fin_de_sequence() {
      return lexeme_courant().nature == FIN_SEQUENCE;
}


// ouverture du fichier d'entrée (s'il existe)
void demarrer(char *nom_fichier) {
  if (strlen(nom_fichier) != 0) {
	yyin = fopen(nom_fichier, "r") ;
	if (!yyin) {
          printf("erreur ouverture fichier %s\n", nom_fichier) ;
	   exit(0) ;
       } 
  } ;
  avancer() ; // lecture du 1er lexeme
}

// fermeture du fichier d'entrée (s'il existe)
void arreter() {
	if (yyin != stdin) fclose(yyin) ;
}

