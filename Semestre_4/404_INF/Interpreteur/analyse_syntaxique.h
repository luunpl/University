#ifndef __ANALYSE_SYNTAXIQUE__
#define __ANALYSE_SYNTAXIQUE__

#include "analyse_lexicale.h"
#include "lecture_caracteres.h"
#include "type_ast.h"
#include "ast_construction.h"
#include "ast_parcours.h"
#include "table_symbole.h"

void Rec_pgm(Ast *resultat);
void Rec_seq_inst(Ast *resultat);
void Rec_suite_seq_inst(Ast donnee, Ast *resultat);
void Rec_inst(Ast *resultat);

void Rec_eag(Ast *resultat);
void Rec_terme(Ast *resultat);
void Rec_seq_terme(Ast *resultat);
void Rec_suite_seq_terme(Ast donnee, Ast *resultat);

void Rec_facteur(Ast *resultat);
void Rec_seq_facteur(Ast *resultat);
void Rec_suite_seq_facteur(Ast donnee, Ast *resultat);

void Rec_op1(TypeOperateur *Op);
void Rec_op2(TypeOperateur *Op);
void Rec_aff(Ast *resultat);
void Rec_seq_aff(Ast *resultat);

void Rec_condition(Ast *resultat);
void type_cond(TypeCond *cond);

void analyser(char *nomFichier, Ast *arbre);

#endif