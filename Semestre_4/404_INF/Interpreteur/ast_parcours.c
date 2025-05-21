#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "type_ast.h"
#include "table_symbole.h"
#include "ast_parcours.h"

void aff_operateur(TypeOperateur op) {
	switch (op) {
		case N_PLUS:
			printf("+");
			break;
		case N_MOINS:
		case U_MOINS:
			printf("-");
			break;
		case N_MUL:
			printf("*");
			break;
		case N_DIV:
			printf("/");
			break;
		default:
			printf("Opérateur inconnu\n");
			break;
	}
}

void afficher_ast(Ast expr) {
	if (expr == NULL) {
		printf("fin");
		return;
	}
	printf("idf: %s\n", expr->ident);
	printf("arbre nature: %d\n", expr->nature);
	switch (expr->nature) {
		case OPERATION:
			printf("(");
			afficher_ast(expr->gauche);
			aff_operateur(expr->operateur);
			afficher_ast(expr->droite);
			printf(")");
			break;
		case VALEUR:
			printf("%d", expr->valeur);
			break;
		case N_IDF:
			printf("%s", expr->ident);
			break;
		case N_AFF:
			afficher_ast(expr->gauche);
			printf(":=");
			afficher_ast(expr->droite);
			break;
		case N_SEPINST:
			afficher_ast(expr->gauche);
			printf(";\n");
			afficher_ast(expr->droite);
			break;
		case N_LIRE:
			printf("lire(%s)", expr->gauche->ident);
			break;
		case N_ECRIRE:
			printf("ecrire");
			afficher_ast(expr->gauche);
			break;
		default:
			printf("Nature inconnue\n");
			break;
	}
}

int evaluation(Ast expr) {
	int v = 0, Vg, Vd;
	switch (expr->nature) {
		case VALEUR:
			if (estPresentTS(expr->ident, &v, TS, NbSymb)) {
				return v;
			} else {
				return expr->valeur;
			}
		case OPERATION:
			Vg = evaluation(expr->gauche);
			Vd = evaluation(expr->droite);
			switch (expr->operateur) {
				case N_PLUS:
					return Vg + Vd;
				case N_MOINS:
					return Vg - Vd;
				case N_MUL:
					return Vg * Vd;
				case N_DIV:
					return Vg / Vd;
				default:
					printf("Opérateur inconnu\n");
					exit(1);
			}
		case N_AFF:
			if (estPresentTS(expr->gauche->ident, &v, TS, NbSymb)) {
				return v;
			} else {
				return evaluation(expr->droite);
			}
		default:
			//printf("Nature inconnue dans l'évaluation\n");
			exit(1);
	}
	return -1;
}

void interpreter(Ast A) {
	switch (A->nature) {
		case N_SEPINST:
			interpreter(A->gauche);
			interpreter(A->droite);
			break;
		case N_AFF:
			interpreter_aff(A);
			break;
		case N_LIRE:
			interpreter_lire(A);
			break;
		case N_ECRIRE:
			interpreter_ecrire(A);
			break;
		case N_IF:
			interpreter_si_alors_sinon(A);
			break;
		case N_WHILE:
			interpreter_while(A);
			break;
		default:
			//printf("Nature inconnue dans l'interprétation\n");
			break;
	}
}

void interpreter_aff(Ast A) {
	char idf[20];
	int v;
	strcpy(idf, A->gauche->ident);
	if (strlen(idf) == 0) {
		return;
	}
	v = evaluation(A->droite);
	insererTS(idf, v, TS, &NbSymb);
}

void interpreter_lire(Ast A) {
	int v;
	printf("Lecture entier %s: ", A->gauche->ident);
	scanf("%d", &v);
	insererTS(A->gauche->ident, v, TS, &NbSymb);
}

void interpreter_ecrire(Ast A) {
	int v = evaluation(A->gauche);
	printf("Écriture %s: %d\n", A->gauche->ident, v);
}

void interpreter_si_alors_sinon(Ast A) {
	int condition = valeur_booleenne(A->gauche);
	if (condition == 1) {
		interpreter(A->milieu);
	} else {
		interpreter(A->droite);
	}
}

void interpreter_while(Ast A) {
	while (valeur_booleenne(A->gauche)) {
		interpreter(A->droite);
	}
}

int valeur_booleenne(Ast A) {
	int valeurg = evaluation(A->gauche);
	int valeurd = evaluation(A->droite);
	switch (A->cond) {
		case N_SUP:
			return valeurg > valeurd;
		case N_SUPEGAL:
			return valeurg >= valeurd;
		case N_INF:
			return valeurg < valeurd;
		case N_INFEGAL:
			return valeurg <= valeurd;
		case N_EGAL:
			return valeurg == valeurd;
		case N_DIFF:
			return valeurg != valeurd;
		default:
			printf("Erreur concernant évaluation de la condition\n");
			exit(1);
	}
}
