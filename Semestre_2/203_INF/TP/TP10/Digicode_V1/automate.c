#include <stdio.h>
#include <string.h>
#include "automate.h"

#define NB_ETATS 5
#define NB_ENTREES 10
#define LG_MAX_SORTIE 128

#define Q0 0
#define Q1 1
#define Q2 2
#define Q3 3
#define Q4 4

char essai[]="/*" /* un essai : " */;
typedef int etat ;

etat etat_initial() {
	return Q0 ;
}

int est_final(etat Q) {
	return Q == Q4 ;
	}

int lire_entree() {
char c ;
	scanf("\n%c", &c) ;
	while (((c < '0') || (c > '9')) && (c != '-')) {
		printf("entree invalide ! un chiffre entre 0 et 9 (- pour finir) ?\n") ;
		scanf("\n%c", &c) ;
		}
	if (c == '-') {
		return -1 ;
	}
	else {
		return c-'0' ;
	}
}

void simule_automate() {
int etat_courant, etat_suivant, entree ;
	entree = 0 ;
	etat_courant = etat_initial() ;
	while (entree != -1) {
		entree = lire_entree() ;
		switch (etat_courant) {
			case Q0 : /* A COMPLETER */
				  break ;
			case Q1 : switch (entree) {
					case 1 : etat_suivant = Q1 ; 
						 break ;
					case 2 : etat_suivant = Q2 ; 
						 break ;
					default : etat_suivant = Q0 ; 
						 break ;
				  }
				  break ;
			/* A COMPLETER */
			default : break ;
		}
		/* printf("%d - %d -> %d\n", etat_courant, entree, etat_suivant) ; */
		etat_courant = etat_suivant ;
	}
}
