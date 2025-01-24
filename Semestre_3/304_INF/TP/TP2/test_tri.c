#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

#include "es_tableau.h"
#include "tri.h"
#include "time.h"

bool oracle_tri(tableau_entiers *t_origine, tableau_entiers *t_trie)
{

    if (t_origine->taille != t_trie->taille)
    {
        return false;
    }

    int compteur[TAILLE_MAX] = {0};
    for (int i = 0; i < t_origine->taille; i++)
    {
        compteur[t_origine->tab[i]]++;
    }

    for (int i = 0; i < t_trie->taille; i++)
    {
        compteur[t_trie->tab[i]]--;
    }

    for (int i = 0; i < TAILLE_MAX; i++)
    {
        if (compteur[i] != 0)
        {
            return false;
        }
    }

    for (int i = 0; i < t_trie->taille - 1; i++)
    {
        if (t_trie->tab[i] > t_trie->tab[i + 1])
        {
            return false;
        }
    }

    return true;
}

void test_tri_insertion(int argc, char **argv)
{ /* À compléter */

    if (argc < 2)
    {
        printf("Usage : %s <fichier d'entrée1> <fichier d'entrée2>\n", argv[0]);
        return;
    }

    for (int i = 1; i < argc; i++)
    {
        tableau_entiers t;

        lire_tableau(argv[i], &t);

        tri_insertion(&t);

        char fichier_sortie[256];
        strcpy(fichier_sortie, argv[i]);
        strcat(fichier_sortie, ".out");

        ecrire_tableau(fichier_sortie, &t);

        printf("Résultat du tri écrit dans %s\n", fichier_sortie);
    }

    for (int i = 1; i < argc; i++)
    {
        tableau_entiers t;
        lire_tableau(argv[i], &t);

        tableau_entiers t_copie;
        copie_tableau(&t, &t_copie);

        tri_insertion(&t);

        if (oracle_tri(&t_copie, &t))
        {
            printf("Test réussi pour le fichier : %s\n", argv[i]);
        }
        else
        {
            printf("Test échoué pour le fichier : %s\n", argv[i]);
        }
    }
}

void initialiser_tableau_aleatoire(tableau_entiers *t, int taille, int min, int max)
{
    t->taille = taille;
    for (int i = 0; i < taille; i++)
    {
        t->tab[i] = rand() % (max - min + 1) + min;
    }
}

void test_tri_insertion_alea(int argc, char **argv)
{ /* À compléter */
    tableau_entiers t;
    tableau_entiers t_copie;

    int taille = 10;
    int min = 0;
    int max = 100;

    srand(time(NULL));

    initialiser_tableau_aleatoire(&t, taille, min, max);

    copie_tableau(&t, &t_copie);

    tri_insertion(&t);

    if (oracle_tri(&t_copie, &t))
    {
        printf("Test aléatoire réussi : taille = %d\n", taille);
    }
    else
    {
        printf("Test aléatoire échoué : taille = %d\n", taille);
    }
    for (int i = 1; i < argc; i++)
    {
        tableau_entiers t;
        lire_tableau(argv[i], &t);

        tableau_entiers t_copie;
        copie_tableau(&t, &t_copie);

        tri_insertion(&t);

        if (oracle_tri(&t_copie, &t))
        {
            printf("Test réussi pour le fichier : %s\n", argv[i]);
        }
        else
        {
            printf("Test échoué pour le fichier : %s\n", argv[i]);
        }
    }
}