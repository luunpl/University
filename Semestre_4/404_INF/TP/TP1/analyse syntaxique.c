#include <stdio.h>
#include <stdlib.h>
#include "analyse_lexicale.h"

typedef enum {Q0, Q1, Q2} Etat;
Lexeme lexeme_courant;

void erreur_syntaxique(char *message){
    fprintf(stderr, "Erreur syntaxique : %s\n", message);
    exit(1);
}

void analyser (char *fichier){

}