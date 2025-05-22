#include <stdio.h>
#include <string.h>
#include "automate.h"

void init_par_defaut(automate *A) {
	int i, j;
	A->nb_etats = NB_MAX_ETATS;
	A->etat_initial = 0;
	for (i = 0; i < NB_MAX_ETATS; i++)
		A->etats_finals[i] = 0;
	for (i = 0; i < NB_MAX_ETATS; i++)
		for (j = 0; j < NB_MAX_ENTREES; j++)
			A->transitions[i][j] = i;
	for (i = 0; i < NB_MAX_ETATS; i++)
		for (j = 0; j < NB_MAX_ENTREES; j++)
			strcpy(A->sortie[i][j], "entree_invalide");
}


void init_mon_automate(automate * A) {
	init_par_defaut(A);
	A->nb_etats = 2;
	A->transitions[0]['2'] = 1;
	A->transitions[0]['r'] = 0;
	A->transitions[0]['c'] = 0;
	A->transitions[1]['2'] = 1;
	A->transitions[1]['r'] = 0;
	A->transitions[1]['c'] = 0;

	strcpy(A->sortie[0]['2'], "credit:20c");
	strcpy(A->sortie[0]['r'], "");
	strcpy(A->sortie[0]['c'], "");
	strcpy(A->sortie[1]['2'], "CLING!-credit:20c");
	strcpy(A->sortie[1]['r'], "CLING!");
	strcpy(A->sortie[1]['c'], "Boisson_servie");
}



int lire_entree() {
	char c;
	scanf(" %c", &c);
	return c;
}

void ecrire_sortie(char *message) {
	printf("%s\n", message);
}

void simule_automate(automate * A) {
	int etat_courant, etat_suivant;
	int entree = ' ';

	etat_courant = A->etat_initial;
	while (1) {
	/**** A COMPLETER ****/
		/* lire une entree 
		   calculer l'état suivant
		   ecrire le message de sortie
		   mettre à jour l'état courant
		 */

	}
}
