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

int Evaluer(int vald, char op, int valg) {
    switch (op) {
        case '+':
            return vald + valg;
        case '-':
            return vald - valg;
        case '*':
            return vald * valg;
        case '/':
            if (valg == 0) {
                erreur_syntaxique("Division par zero");
            }
            return vald / valg;

        default:
            erreur_syntaxique("Operateur inconnu");
            return 0; 
    }
}

void Rec_op(char *op){
    lc = lexeme_courant();
    switch (lc.nature){
        case PLUS:
            *op = '+';
            printf("%s\n", lc.chaine);
            avancer();
            break;
        case MOINS:
            *op = '-';
            printf("%s\n", lc.chaine);
            avancer();
            break;
        case MUL:
            *op = '*';
            printf("%s\n", lc.chaine);
            avancer();
            break;
        case DIV:
            *op = '/';
            printf("%s\n", lc.chaine);
            avancer();
            break;

        default:
            erreur_syntaxique("Un operateur est attendu");
            break;
    }
}

void Rec_eaep(int *sous_resultat) {
    lc = lexeme_courant();
    int valg, vald;
    char op;

    switch (lc.nature) {
        case ENTIER:
            printf("%s\n", lc.chaine);
            *sous_resultat = lc.valeur;
            avancer();
            break;

        case PARO:
            printf("%s\n", lc.chaine);
            avancer();
            Rec_eaep(&valg);
            Rec_op(&op);
            Rec_eaep(&vald);
            *sous_resultat = Evaluer(valg, op, vald);

            if (lc.nature == PARF){
                printf("%s\n", lc.chaine);
                avancer();
            } else {
                erreur_syntaxique("Parenthese fermante attendue");
            }
            break;

        default:
            erreur_syntaxique("Expression attendue");
            break;
    }
}

// TP3
void Rec_exp();
void Rec_eag();
void Rec_seq_terme();

// Fonction Analyser a modifier chaque TP
void analyser(char *fichier, int *resultat){
    demarrer(fichier);
    while (!fin_de_sequence())
    {
        Rec_eaep(resultat);
    }
    arreter();
}
