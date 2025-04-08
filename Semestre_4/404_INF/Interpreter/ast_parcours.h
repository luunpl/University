#ifndef __AST_PARCOURS__
#define __AST_PARCOURS__

#include "type_ast.h"

// Affiche l'arbre abstrait de l'expression arithmétique expr
void afficher_ast(Ast expr);

// Calcule la valeur de l'expression arithmétique expr
int evaluation(Ast expr);

void interpreter(Ast A);
void interpreter_aff(Ast A);
void interpreter_lire(Ast A);
void interpreter_ecrire(Ast A);
void interpreter_si_alors_sinon(Ast A);
void interpreter_while(Ast A);

int valeur_booleenne(Ast A);

#endif
