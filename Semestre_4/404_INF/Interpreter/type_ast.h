
#ifndef __TYPE_AST__
#define __TYPE_AST__ 

typedef enum {OPERATION, VALEUR,N_AFF, N_SEPINST, N_LIRE, N_ECRIRE,N_IDF, N_IF,N_COND,N_WHILE} TypeAst ;
typedef enum {N_PLUS, N_MUL, N_MOINS,N_DIV, U_MOINS} TypeOperateur ;
typedef enum {N_SUP, N_INF, N_SUPEGAL, N_INFEGAL, N_EGAL, N_DIFF} TypeCond ;

typedef struct noeud { 
	TypeAst nature ;
	TypeOperateur operateur ;
	TypeCond cond;
	char ident[100] ;
	struct noeud *gauche, *droite, *milieu ;
	int valeur ;
} NoeudAst ;

typedef NoeudAst *Ast ;

#endif  
