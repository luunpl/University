#include <stdio.h>
#include <stdlib.h>
#include "type_pile.h"  // Inclure le fichier d'en-tête pour la pile
#include "commandes_calculette.h"  // Inclure le fichier d'en-tête pour les commandes

int main(int argc, char **argv) {
    // Vérification des arguments en ligne de commande
    if (argc != 2) {
        printf("Usage : %s <nom_du_fichier_de_commandes>\n", argv[0]);
        return EXIT_FAILURE;
    }

    FILE *fichier = ouvrir_commandes(argv[1]);
    if (fichier == NULL) {
        perror("Erreur à l'ouverture du fichier");
        return EXIT_FAILURE;
    }

    PileEntiers pile;  // Créer une pile pour les opérations
    creer_pile(&pile);

    commande command;
    
    while (!fin_commandes(fichier)) {
        command = commande_suivante(fichier);
        print_commandes(command); // Affiche la commande lue

        switch (command.cmd) {
            case VIDER_PILE:
                vider(&pile);
                break;
            case DEPILER_SOMMET:
                if (!est_vide(&pile)) {
                    int depile = depiler(&pile);
                    printf("Dépilé : %d\n", depile);
                } else {
                    printf("Erreur : la pile est vide, impossible de dépiler.\n");
                }
                break;
            case EMPILER_VALEUR:
                empiler(&pile, command.arg);
                break;
            case EFFECTUER_ADDITION: {
                if (taille(&pile) < 2) {
                    printf("Erreur : pas assez d'éléments pour addition.\n");
                } else {
                    int b = depiler(&pile); // Dépile le deuxième opérande
                    int a = depiler(&pile); // Dépile le premier opérande
                    int result = a + b;
                    empiler(&pile, result);
                    printf("Résultat de %d + %d = %d\n", a, b, result);
                }
                break;
            }
            case EFFECTUER_SOUSTRACTION: {
                if (taille(&pile) < 2) {
                    printf("Erreur : pas assez d'éléments pour soustraction.\n");
                } else {
                    int b = depiler(&pile);
                    int a = depiler(&pile);
                    int result = a - b;
                    empiler(&pile, result);
                    printf("Résultat de %d - %d = %d\n", a, b, result);
                }
                break;
            }
            case EFFECTUER_MULTIPLICATION: {
                if (taille(&pile) < 2) {
                    printf("Erreur : pas assez d'éléments pour multiplication.\n");
                } else {
                    int b = depiler(&pile);
                    int a = depiler(&pile);
                    int result = a * b;
                    empiler(&pile, result);
                    printf("Résultat de %d * %d = %d\n", a, b, result);
                }
                break;
            }
            case EFFECTUER_DIVISION: {
                if (taille(&pile) < 2) {
                    printf("Erreur : pas assez d'éléments pour division.\n");
                } else {
                    int b = depiler(&pile);
                    if (b == 0) {
                        printf("Erreur : division par zéro.\n");
                        empiler(&pile, b); // Remettre b dans la pile
                    } else {
                        int a = depiler(&pile);
                        int result = a / b;
                        empiler(&pile, result);
                        printf("Résultat de %d / %d = %d\n", a, b, result);
                    }
                }
                break;
            }
            case COMMANDE_INCORRECTE:
                printf("Commande incorrecte!\n");
                break;
        }
        // Afficher l'état actuel de la pile
        print(&pile);
        printf("\n");
    }
    
    fermer_commandes(fichier);
    return EXIT_SUCCESS;
}