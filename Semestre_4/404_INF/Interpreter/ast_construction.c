#include <stdlib.h>
#include <stdio.h> 
#include <string.h>

#include "type_ast.h"
#include "ast_construction.h"

Ast creer_operation(TypeOperateur opr , Ast opde_gauche , Ast opde_droit) 
{
      Ast expr ;
      expr = (Ast) malloc (sizeof(NoeudAst));
      expr->nature = OPERATION;
      expr->operateur = opr;
      if (opde_gauche == NULL || opde_droit == NULL) {
         printf("ERREUR_EXPRESSION\n") ;
	 exit(1) ;
      } else {
         expr->gauche = opde_gauche;
         expr->droite = opde_droit;
      } ;
      return expr ;
}

Ast creer_valeur(int val,char* idf) { 
      Ast expr ;
      expr = (Ast) malloc (sizeof(NoeudAst));
      expr->nature = VALEUR;
      strcpy(expr->ident, idf);
      expr->valeur = val;
      return expr ;
}

Ast creer_op_unaire(TypeOperateur op,Ast a){
      Ast expr;
      expr = (Ast) malloc (sizeof(NoeudAst));
      expr->nature = OPERATION;
      expr ->operateur = op;
      if(a==NULL){
            printf("erreur \n");
            exit(1);      }
      else{
      expr->gauche = a;
      expr->droite = NULL;}

      return expr;
}

Ast creer_seqinst(Ast a1, Ast a2){
      Ast expr;
      expr = (Ast) malloc (sizeof(NoeudAst));
      expr->nature = N_SEPINST;
      expr->gauche = a1;
      expr->droite = a2;
      return expr;
}

Ast creer_idf(char *idf){
      Ast expr;
      expr = (Ast) malloc (sizeof(NoeudAst));
      expr->nature = N_IDF ;//
      strcpy(expr->ident, idf);
      expr->gauche = NULL;
      expr->droite = NULL;
      return expr;
}


Ast creer_aff(Ast a1, Ast a2){
      Ast expr;
      expr = (Ast) malloc (sizeof(NoeudAst));
      expr->nature = N_AFF;
      expr->gauche = a1;
      expr->droite = a2;
      return expr;
}

Ast creer_lire(Ast a){
      Ast expr;
      expr = (Ast) malloc (sizeof(NoeudAst));
      expr->nature = N_LIRE;
      expr->gauche = a;
      return expr;
}

Ast creer_ecrire(Ast a){
      Ast expr;
      expr = (Ast) malloc (sizeof(NoeudAst));
      expr->nature = N_ECRIRE;
      expr->gauche = a;
      return expr;
}

Ast creer_if(Ast a, Ast b, Ast c){
      Ast expr;
      expr = (Ast) malloc (sizeof(NoeudAst));
      expr->nature = N_IF;
      expr->gauche = a;
      expr->milieu = b;
      expr->droite = c;
      return expr;
}

Ast creer_cond(TypeCond c,Ast ag,Ast ad){
      Ast expr;
      expr = (Ast) malloc (sizeof(NoeudAst));
      expr->nature = N_COND;
      expr->cond = c ;      
      expr->gauche = ag;
      expr->droite = ad;
      return expr;
}

Ast creer_while(Ast ag, Ast ad){
      Ast expr;
      expr = (Ast) malloc (sizeof(NoeudAst));
      expr->nature = N_WHILE;
      expr->gauche = ag;
      expr->droite = ad;
      return expr;
}