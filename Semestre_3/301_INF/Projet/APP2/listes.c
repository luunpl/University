#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <assert.h>
#include <string.h>
#include <ctype.h>
#ifdef NCURSES
#include <ncurses.h>
#endif
#include "listes.h"

bool silent_mode = false;

cellule_t* nouvelleCellule (void){
    cellule_t *c;
    c = (cellule_t *)malloc(sizeof(cellule_t));
    return c;
}

void detruire_cellule(cellule_t* cel) {
    free(cel);
}

cellule_t* creer_cellule(char commande) {
    cellule_t* c = nouvelleCellule();
    c->command = commande;
    return c;
}

void ajout_queue(sequence_t *l, char comm) {
    cellule_t *c, *v;
    c = malloc(sizeof(struct cellule));
    if (c == NULL) {
        fprintf(stderr, "Erreur d'allocation de mémoire pour la cellule.\n");
        exit(EXIT_FAILURE);
    }
    c->command = comm;
    c->suivant = NULL;
    v = l->tete;
    if (v != NULL) {
        while (v->suivant != NULL) {
            v = v->suivant;
        }
        v->suivant = c;
    } else {
        l->tete = c;
        c->suivant = NULL;
    }
}

void conversion(char *texte, sequence_t *seq) {
    seq->tete = NULL;
    for (int i = 0; i < (int)strlen(texte); i++) {
        char cr = texte[i];
        ajout_queue(seq, cr);
    }
}

void afficher(sequence_t *seq) {
    assert(seq); // Vérifie que seq n'est pas NULL

    cellule_t *current = seq->tete;
    while (current != NULL) {
        printf("%c", current->command);
        current = current->suivant;
    }
}
