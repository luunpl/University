#include <stdio.h>
#include <stdlib.h>
#include "analyse_syntaxique.h"
#include "analyse_lexicale.h"

typedef enum {Q0, Q1, Q2} Etat;
Lexeme lc;

void erreur_syntaxique(char *message){
    fprintf(stderr, "Erreur syntaxique : %s\n", message);
    exit(1);
}

void Rec_op(){

    lc = lexeme_courant();
    switch (lc.nature){
        case PLUS:
        case MOINS:
        case MUL:
        case DIV:
            avancer();
            break;

        default:
            erreur_syntaxique("Un operateur est attendu");
            break;
    }
}

int Rec_eaep(int *sous_resultat){
    while(!fin_de_sequence()){
        lc = lexeme_courant();
        switch (lc.nature){
            case ENTIER:
                avancer();
                break;
            
            case PARO:
                avancer();
                Rec_eaep();
                Rec_op();
                Rec_eaep();
                if (lc.nature == PARF){
                    avancer();}
                else{
                    erreur_syntaxique("Parenthese fermante attendue");
                break;
            default:
                erreur_syntaxique("Un entier ou une parenthese ouvrante est attendu");
                break;

    }}
}
}

