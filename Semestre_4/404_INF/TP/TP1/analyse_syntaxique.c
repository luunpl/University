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

void analyser (char *fichier, int *resultat){
    Etat ec; // Etat courant
    ec = Q0; // Initialisation de l'etat courant
    int temp_result = 0;
    int operand = 0;
    char operator = 0;

    while(!fin_de_sequence()){
        lc = lexeme_courant();
        switch(ec){
            case Q0:
                switch (lc.nature)
                {
                case ENTIER:
                    operand = lc.valeur;
                    avancer();
                    ec = Q1;                                                                
                    break;
                
                default:
                    erreur_syntaxique("Un entier est attendu");
                    
                }
                break;

            case Q1:
                switch (lc.nature)
                {
                case PLUS:
                case MOINS:
                case MUL:
                case DIV:
                    operator = lc.nature;
                    avancer();
                    ec = Q2;
                    break;
                default:
                    erreur_syntaxique("Un operateur est attendu");
                    
                }  
                break;    
                                                                                                         \
            case Q2:
                switch (lc.nature)
                {
                case ENTIER:
                    switch (operator) {
                        case PLUS:
                            temp_result += operand;
                            operand = lc.valeur;
                            break;
                        case MOINS:
                            temp_result += operand;
                            operand = -lc.valeur;
                            break;
                        case MUL:
                            operand *= lc.valeur;
                            break;
                        case DIV:
                            if (lc.valeur == 0) {
                                erreur_syntaxique("Division par zero");
                            }
                            operand /= lc.valeur;
                            break;
                    }
                    avancer();
                    ec = Q1;                                                                
                    break;
                
                default:
                    erreur_syntaxique("Un entier est attendu");
                }
                break;
        }
    }

    if(ec == Q1){
        temp_result += operand;
        *resultat = temp_result;
        printf("Syntaxe Correcte\n");
        printf("Resultat : %d", *resultat);
    }else{
        erreur_syntaxique("Syntaxe Incorrecte");
    }
}