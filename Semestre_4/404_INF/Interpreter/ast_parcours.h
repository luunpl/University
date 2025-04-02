#ifndef __AST_PARCOURS__
#define __AST_PARCOURS__
#include "type_ast.h"
void afficher_ast(Ast expr) ;
// affiche l'arbre abstrait de l'expression arithmetique expr

int evaluation(Ast expr) ;
// calcule la valeur de l'expression arithmetique exprs
// FONCTION A COMPLETER !

void interpreter(Ast A);
void interpreter_aff(Ast A);
void interpreter_lire(Ast A);
void interpreter_ecrire(Ast A);
void interpreter_si_alors_sinon(Ast A);
void interpreter_while(Ast A);

int valeur_booleenne(Ast A);
#endif

