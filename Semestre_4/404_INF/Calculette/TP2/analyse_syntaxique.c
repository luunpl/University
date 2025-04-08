#include <stdio.h>
#include <stdlib.h>
#include "analyse_syntaxique.h"
#include "analyse_lexicale.h"

void erreur_syntaxique(char *message) {
    fprintf(stderr, "Erreur syntaxique: %s\n", message);
    exit(EXIT_FAILURE);
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
                printf("Division par zero\n");
                exit(1);
            }
            return vald / valg;
        default:
            exit(0);
    }
}

void Rec_op(char *op){
    switch (lexeme_courant().nature){
        case PLUS:
            *op = '+';
            printf("%s\n", lexeme_courant().chaine);
            avancer();
            break;
        case MOINS:
            *op = '-';
            printf("%s\n", lexeme_courant().chaine);
            avancer();
            break;
        case MUL:
            *op = '*';
            printf("%s\n", lexeme_courant().chaine);
            avancer();
            break;
        case DIV:
            *op = '/';
            printf("%s\n", lexeme_courant().chaine);
            avancer();
            break;

        default:
            erreur_syntaxique("Un operateur est attendu");
            exit(0);
    }
}

void Rec_eaep(int *sous_resultat) {
    int valg, vald;
    char op;

    switch (lexeme_courant().nature) {
        case ENTIER:
            printf("%s\n", lexeme_courant().chaine);
            *sous_resultat = lexeme_courant().valeur;
            avancer();
            break;

        case PARO:
            printf("%s\n", lexeme_courant().chaine);
            avancer();
            Rec_eaep(&valg);
            Rec_op(&op);
            Rec_eaep(&vald);
            printf("valg = %d, op = %c, vald = %d\n", valg, op, vald);
            *sous_resultat = Evaluer(valg, op, vald);

            if (lexeme_courant().nature == PARF){
                printf("%s\n", lexeme_courant().chaine);
                avancer();
            } else {
                erreur_syntaxique("Parenthese fermante attendue");
                exit(0);
            }
            break;

        default:
            erreur_syntaxique("Expression attendue");
            exit(0);
    }
}

void analyser(char *fichier, int *resultat){
    demarrer(fichier);
    while (!fin_de_sequence())
    {
        Rec_eaep(resultat);
    }
    arreter();
}
