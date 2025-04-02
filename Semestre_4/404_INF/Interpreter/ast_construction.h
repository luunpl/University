
#ifndef __AST_CONSTRUCTION__
#define __AST_CONSTRUCTION__

#include "type_ast.h"

Ast creer_operation(TypeOperateur opr , Ast opde_gauche , Ast opde_droit) ;
// renvoie un arbre abstrait de nature OPERATEUR,  d'operateur opr 
// et ayant opde_gauche et opde_droit pour fils gauche et droit

Ast creer_valeur(int val,char* idf) ; 
// renvoie un arbre abstrait "feuille", de nature OPERATION  
// et de valeur val

Ast creer_op_unaire(TypeOperateur op, Ast a);
// renvoie un arbre abstrait de nature OPERATION, d'operateur op

Ast creer_seqinst(Ast a, Ast b);
// renvoie un arbre abstrait de nature N_SEPINST, ayant a et b pour fils

Ast creer_idf(char *idf);
// creer arbre gauche qui contient l'IDF

Ast creer_aff(Ast a, Ast b);
// creer un noeud N_AFF de fils Ag, Ad

Ast creer_lire(Ast a);
// creer un noeud N_LIRE de fils a

Ast creer_ecrire(Ast a);
// creer un noeud N_ECRIRE de fils a

Ast creer_if(Ast a, Ast b, Ast c);
// creer un noeud N_IF de fils a, b, c
Ast creer_cond(TypeCond c,Ast ag,Ast ad);

Ast creer_while(Ast ag, Ast ad);
#endif
