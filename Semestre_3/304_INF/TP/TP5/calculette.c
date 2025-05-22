#include <stdio.h>
#include <stdlib.h>
#include "type_pile_erreurs.h"  // Inclure le fichier d'en-tête pour la pile
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

    erreur_pile err;
    int a, b, res3;
    commande command;
    
    while (!fin_commandes(fichier)) {
        command = commande_suivante(fichier);
        print_commandes(command); // Affiche la commande lue

        switch (command.cmd) {
            case VIDER_PILE:
                if ((err = vider(&pile)) != OK) {
                    printf("Erreur lors du vidage de la pile : %d\n", err);
                }
                break;

            case DEPILER_SOMMET:
                if (!est_vide(&pile)) {
                    if ((err = depiler(&pile, &res3)) == OK) {
                        printf("Dépilé : %d\n", res3);
                    } else {
                        printf("Erreur lors du dépilement : %d\n", err);
                    }
                } else {
                    printf("Erreur : la pile est vide, impossible de dépiler.\n");
                }
                break;

            case EMPILER_VALEUR:
                if ((err = empiler(&pile, command.arg)) != OK) {
                    printf("Erreur lors de l'empilement : %d\n", err);
                }
                break;

            case EFFECTUER_ADDITION:
                if (taille(&pile) < 2) {
                    printf("Erreur : pas assez d'éléments pour addition.\n");
                } else {
                    if ((err = depiler(&pile, &a)) == OK && (err = depiler(&pile, &b)) == OK) {
                        int result = a + b;
                        if ((err = empiler(&pile, result)) == OK) {
                            printf("Résultat de %d + %d = %d\n", a, b, result);
                        } else {
                            printf("Erreur lors de l'empilement : %d\n", err);
                        }
                    } else {
                        printf("Erreur lors du dépilement : %d\n", err);
                    }
                }
                break;

            case EFFECTUER_SOUSTRACTION:
                if (taille(&pile) < 2) {
                    printf("Erreur : pas assez d'éléments pour soustraction.\n");
                } else {
                    if ((err = depiler(&pile, &a)) == OK && (err = depiler(&pile, &b)) == OK) {
                        int result = a - b;
                        if ((err = empiler(&pile, result)) == OK) {
                            printf("Résultat de %d - %d = %d\n", a, b, result);
                        } else {
                            printf("Erreur lors de l'empilement : %d\n", err);
                        }
                    } else {
                        printf("Erreur lors du dépilement : %d\n", err);
                    }
                }
                break;

            case EFFECTUER_MULTIPLICATION:
                if (taille(&pile) < 2) {
                    printf("Erreur : pas assez d'éléments pour multiplication.\n");
                } else {
                    if ((err = depiler(&pile, &a)) == OK && (err = depiler(&pile, &b)) == OK) {
                        int result = a * b;
                        if ((err = empiler(&pile, result)) == OK) {
                            printf("Résultat de %d * %d = %d\n", a, b, result);
                        } else {
                            printf("Erreur lors de l'empilement : %d\n", err);
                        }
                    } else {
                        printf("Erreur lors du dépilement : %d\n", err);
                    }
                }
                break;

            case EFFECTUER_DIVISION:
                if (taille(&pile) < 2) {
                    printf("Erreur : pas assez d'éléments pour division.\n");
                } else {
                    if ((err = depiler(&pile, &b)) == OK) {
                        if (b == 0) {
                            printf("Erreur : division par zéro.\n");
                            empiler(&pile, b); // Remettre b dans la pile
                        } else {
                            if ((err = depiler(&pile, &a)) == OK) {
                                int result = a / b;
                                if ((err = empiler(&pile, result)) == OK) {
                                    printf("Résultat de %d / %d = %d\n", a, b, result);
                                } else {
                                    printf("Erreur lors de l'empilement : %d\n", err);
                                }
                            } else {
                                printf("Erreur lors du dépilement : %d\n", err);
                            }
                        }
                    } else {
                        printf("Erreur lors du dépilement : %d\n", err);
                    }
                }
                break;

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
