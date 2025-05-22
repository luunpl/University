#include "listes.h"
#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* fichier à compléter au besoin */

void init_liste_vide(liste_t *L)
{
    L->tete = NULL;
}

/*
 * Supprime toutes les cellules d'une liste L, sans faire de free sur
 * L elle-même.
 */
void liberer_liste(liste_t *L)
{
    cellule_t *current = L->tete;
    cellule_t *next;

    while (current != NULL) {
        next = current->suivant;
        free(current);
        current = next;
    }

    L->tete = NULL;
}


int ajouter_tete(liste_t *L, string c)
{   /* retourne 0 si OK, 1 sinon  */
    if (L == NULL) {
        return 1;
    }
    else {
        cellule_t *new_cell = malloc(sizeof(cellule_t));
        if (new_cell == NULL) {
            return 1;
        }
        new_cell->val = c;
        new_cell->suivant = L->tete;
        L->tete = new_cell;
        return 0;
    }
    return 1;
}
