#include <stdio.h>
#include <stdbool.h>
#include <assert.h>
#include <stdlib.h>
#include <string.h>
#ifdef NCURSES
#include <ncurses.h>
#endif
#include "listes.h"
#include "curiosity.h"

#define TAILLE_PILE 50

// Structure pile
typedef struct {
    char* tab[TAILLE_PILE];
    int nb_elem;
} pile;

// Fonction empiler
void empiler(pile *p, char *x) {
    if (p->nb_elem < TAILLE_PILE) {
        p->tab[p->nb_elem++] = x;
    } else {
        fprintf(stderr, "Débordement de pile !\n");
        exit(EXIT_FAILURE);
    }
}

// Fonction dépiler 
char *depiler(pile *p) {
    if (p->nb_elem > 0) {
        return p->tab[--p->nb_elem];
    } else {
        fprintf(stderr, "Dépassement de pile !\n");
        exit(EXIT_FAILURE);
    }
}

// Fonction pour afficher le contenu de la pile
void afficher_pile(const pile *p) {
    if (p->nb_elem == 0) {
        printf("La pile est vide !\n");
    } else {
        printf("Contenu de la pile: ");
        for (int i = p->nb_elem - 1; i >= 0; i--) {
            printf("%s ", p->tab[i]);
        }
        printf("\n");
    }
}

// Fonction pour arrêter le programme jusqu'à ce qu'une touche soit enfoncée
void stop(void) {
    printf("Appuyez sur Entrée pour continuer...\n");
    while (getchar() != '\n');
}

// Fonction pour convertir un entier en chaîne de caractères
char* convertirEntierEnChaine(int nombre) {
    char* chaine = malloc(20 * sizeof(char));  
    if (chaine == NULL) {
        fprintf(stderr, "Erreur d'allocation mémoire\n");
        exit(EXIT_FAILURE);
    }
    sprintf(chaine, "%d", nombre);
    return chaine;
}

// Fonction principale pour interpréter une séquence d'instructions
int interprete(sequence_t* seq, bool debug) {
    pile p = {.nb_elem = 0}; // Initialiser la pile
    char commande;
    int x, y, ret, resultat, dir, arg1, nombreAcc, n;
    size_t index;
    char *F, *V, *a = NULL;
    char *Commande;
    if (debug) {
        printf("Programme :");
        afficher(seq);
        printf("\n");
        stop();
    }

    cellule_t* courant = seq->tete;
    int final_resultat = 0;

    while (courant) {
        commande = courant->command;
        ret = 0;

        switch (commande) {
            case ' ':
                break;
            case 'A':
                ret = avance();
                if (ret == VICTOIRE) return VICTOIRE;
                if (ret == RATE) return RATE;
                break;
            case 'G':
                gauche();
                break;
            case 'D':
                droite();
                break;
            case '0'...'9':
                empiler(&p, convertirEntierEnChaine(commande - '0'));
                break;
            case '+':
            case '-':
            case '*':
                if (p.nb_elem < 2) {
                    fprintf(stderr, "Pas assez d'opérandes sur la pile pour l'opération !\n");
                    exit(EXIT_FAILURE);
                }
                x = atoi(depiler(&p));
                y = atoi(depiler(&p));

                switch (commande) {
                    case '+':
                        resultat = y + x;
                        printf("Addition : %d + %d = %d\n", x, y, resultat);
                        break;
                    case '-':
                        resultat = y - x;
                        printf("Soustraction : %d - %d = %d\n", x, y, resultat);
                        break;
                    case '*':
                        resultat = y * x;
                        printf("Multiplication : %d * %d = %d\n", x, y, resultat);
                        break;
                    default:
                        fprintf(stderr, "Opérateur non pris en charge : '%c'\n", commande);
                        exit(EXIT_FAILURE);
                }

                empiler(&p, convertirEntierEnChaine(resultat));
                afficher_pile(&p);
                break;

            case 'P':
                arg1 = atoi(depiler(&p));
                pose(arg1);
                afficher_pile(&p);
                break;

            case 'M':
                dir = atoi(depiler(&p));
                resultat = mesure(dir);
                empiler(&p, convertirEntierEnChaine(resultat));
                printf("Mesure:%d\n", resultat);
                afficher_pile(&p);
                break;

            case '{':
                nombreAcc = 1;
                courant = courant->suivant;
                index = 0;
                char *tmp = malloc(TAILLE_PILE * sizeof(char));
                while (courant->suivant != NULL) {
                    if (courant->command == '{') {
                        nombreAcc++;
                    }
                    if (courant->command == '}') {
                        nombreAcc--;
                        if (nombreAcc == 0) {
                            break;
                        }
                    }
                    tmp[index++] = courant->command;
                    courant = courant->suivant;
                }
                empiler(&p, tmp);
                afficher_pile(&p);
                break;

            case '?':
                F = depiler(&p);
                V = depiler(&p);
                n = atoi(depiler(&p));
                Commande = (n == 0) ? F : V;
                sequence_t *nouvelleSeq = malloc(sizeof(sequence_t));
                conversion(Commande, nouvelleSeq);
                ret = interprete(nouvelleSeq, debug);
                printf("%d \n", ret);
                afficher_pile(&p);
                if (ret == VICTOIRE) return VICTOIRE;
                if (ret == RATE) return RATE;
                break;

            case 'Z': 
                if (p.nb_elem >= 3) {
                    char *c = depiler(&p);
                    char *b = depiler(&p);
                    char *a = depiler(&p);

                    // Inverser les chaînes a, b et c
                    for (int i = 0, len = strlen(a); i < len / 2; i++) {
                        char temp = a[i];
                        a[i] = a[len - i - 1];
                        a[len - i - 1] = temp;
                    }

                    for (int i = 0, len = strlen(b); i < len / 2; i++) {
                        char temp = b[i];
                        b[i] = b[len - i - 1];
                        b[len - i - 1] = temp;
                    }

                    for (int i = 0, len = strlen(c); i < len / 2; i++) {
                        char temp = c[i];
                        c[i] = c[len - i - 1];
                        c[len - i - 1] = temp;
                    }

                    // Empiler les chaînes inversées
                    empiler(&p, a);
                    empiler(&p, b);
                    empiler(&p, c);
                } else {
                    fprintf(stderr, "Pas assez d'éléments sur la pile pour la commande 'Z' !\n");
                    exit(EXIT_FAILURE);
                }
                break;

            case 'X':
                if (p.nb_elem >= 2) {
                    char *a = depiler(&p);
                    char *b = depiler(&p);
                    empiler(&p, a);
                    empiler(&p, b);
                } else {
                    fprintf(stderr, "Pas assez d'éléments sur la pile pour l'échange !\n");
                    printf("Taille de la pile : %d\n", p.nb_elem);
                    exit(EXIT_FAILURE);
                }
                break;

            case '!':
                if (p.nb_elem > 0) {
                    char *a = depiler(&p);
                    sequence_t *nouvelleSeq = malloc(sizeof(sequence_t));
                    conversion(a, nouvelleSeq);
                    int ret = interprete(nouvelleSeq, debug);
                    if (ret == VICTOIRE) return VICTOIRE;
                    if (ret == RATE) return RATE;
                } else {
                    fprintf(stderr, "La pile est vide, impossible d'exécuter une commande !\n");
                    exit(EXIT_FAILURE);
                }
                break;

            case 'B':
                if (p.nb_elem >= 2) {
                    int n = atoi(depiler(&p));
                    char *cmd = depiler(&p);
                    while (n > 0) {
                        sequence_t *nouvelleSeq = malloc(sizeof(sequence_t));
                        conversion(cmd, nouvelleSeq);
                        int ret = interprete(nouvelleSeq, debug);
                        if (ret == VICTOIRE) {
                            free(cmd);
                            return VICTOIRE;
                        }
                        if (ret == RATE) {
                            free(cmd);
                            return RATE; 
                        }
                        n--;
                        empiler(&p, cmd);
                        empiler(&p, convertirEntierEnChaine(n));
                    }
                    free(cmd);
                } else {
                    fprintf(stderr, "Pas assez d'éléments sur la pile pour la boucle !\n");
                    exit(EXIT_FAILURE);
                }
                break;

            case 'C':
                if (p.nb_elem > 0) {
                    a = depiler(&p);
                    char *copy_a = strdup(a);
                    if (copy_a == NULL) {
                        fprintf(stderr, "Erreur d'allocation mémoire\n");
                        exit(EXIT_FAILURE);
                    }
                    empiler(&p, a);
                    empiler(&p, copy_a);
                    afficher_pile(&p);
                } else {
                    fprintf(stderr, "La pile est vide, impossible de copier un élément !\n");
                    exit(EXIT_FAILURE);
                }
                break;
                
            case 'I':
                if (p.nb_elem > 0) {
                    depiler(&p);  
                } else {
                    fprintf(stderr, "La pile est vide, impossible d'ignorer un élément !\n");
                    exit(EXIT_FAILURE);
                }
                break;

            case 'R':
                if (p.nb_elem >= 3) {
                    int step = atoi(depiler(&p)); 
                    int count = atoi(depiler(&p)); 
                    int stackSize = p.nb_elem;
                    for (int iteration = 0; iteration < step; iteration++) {
                        char *temp = p.tab[stackSize - count];
                        for (int i = stackSize - count; i < stackSize - 1; i++) {
                            p.tab[i] = p.tab[i + 1];
                        }
                        p.tab[stackSize - 1] = temp;
                    }
                }
                break;

            default:
                fprintf(stderr, "Caractère inconnu : '%c'\n", commande);
                break;
        }

        // Affichage pour le débogage
        afficherCarte();
        printf("Programme :");
        afficher(seq);
        printf("\n");

        if (debug)
            stop();

        courant = courant->suivant;
    }
    // À la fin de la routine, le résultat souhaité est le dernier élément de la pile
    printf("calcul : %d\n", final_resultat);
    return CIBLERATEE;
}