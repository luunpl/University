#include <stdio.h>
#include <stdlib.h>

// L'etat de sante
enum EtatSante
{
    BYEBYELIFE,
    LIFESUCKS,
    LIFEROCKS
};

// Variables globales pour le stock et le fitness
int stock = 5;
int fitness = 5;

// Fonction pour mettre à jour le stock de nourriture
int stock_update(int lunchfood)
{
    // Un effet aléatoire sur le stock (crop)
    int crop = rand() % 6 - 3; // Effet aléatoire entre -3 et 3

    // Mettre à jour le stock 
    stock = (stock - lunchfood) + crop;

    // S'assurer que le stock reste compris entre 0 et 10
    if (stock < 0)
        stock = 0;
    else if (stock > 10)
        stock = 10;

    return stock;
}

// Fonction pour le niveau de sante de la vache
int fitness_update(int lunchfood)
{
    // Effet aleatoire sur le niveau de sante (digestion)
    int digestion = rand() % 3;
    digestion *= -1; // Effet aléatoire entre 0 et -3

    // Mettre à jour le niveau de santé 
    fitness = (fitness + lunchfood) + digestion;

    // S'assurer que le niveau de santé reste compris entre 0 et 10
    if (fitness < 0)
        fitness = 0;
    else if (fitness > 10)
        fitness = 10;

    return fitness;
}

// Fonction pour afficher la vache en pleine forme
void affiche_vache_en_pleine_forme()
{
    printf(
"        ^--^\n\
        (00)\\-------\n\
        (__)\\       )\\/\\\n\
            ||-----w |\n\
            ||     || \n");
}

// Fonction pour afficher la vache qui ne se sent pas bien
void affiche_vache_pas_bien()
{
    printf(
"        ^--^\n\
        (--)\\-------\n\
        (__)\\       )\\/\\\n\
         ||  ||-----w |\n\
             ||     || \n");
}

// Fonction pour afficher la vache décédée
void affiche_vache_decédée()
{
    printf(
"        ^--^\n\
        (xx)\\-------\n\
        (__)\\       )\\/\\\n\
            ||-----W |\n\
            ||     || \n");
}

// Fonction pour afficher la vache en fonction de son état de santé
void affiche_vache(enum EtatSante etat)
{
    switch (etat)
    {
    case BYEBYELIFE:
        printf("La vache est décédée...\n");
        // Affichage visuel de la vache décédée
        affiche_vache_decédée();
        break;

    case LIFESUCKS:
        printf("La vache ne se sent pas bien...\n");
        // Affichage visuel de la vache qui ne se sent pas bien
        affiche_vache_pas_bien();
        break;

    case LIFEROCKS:
        printf("La vache est en pleine forme !\n");
        // Affichage visuel de la vache en pleine forme
        affiche_vache_en_pleine_forme();
        break;
    }
}

int main()
{
    // Initialisation de la vie de la vache
    int duree_de_vie = 0;

    // Boucle principale du jeu
    while (1)
    {
        // Incrémenter la durée de vie à chaque itération, c'est notre Point
        duree_de_vie++;

        // Afficher l'etat actuel de la vache
        // Déterminer l'etat de sante actuel de la vache
        if (fitness >= 4 && fitness <= 6)
        {
            affiche_vache(LIFEROCKS); // Affichage de la vache en pleine forme
        }
        else if ((fitness >= 1 && fitness <= 3) || (fitness >= 7 && fitness <= 9))
        {
            affiche_vache(LIFESUCKS); // Affichage de la vache qui ne se sent pas bien
        }
        else
        {
            affiche_vache(BYEBYELIFE); // Affichage de la vache mort
        }

        // Afficher l'état actuel du stock de nourriture
        printf("Stock de nourriture : %d\n", stock);

        // Demander à l'utilisateur de choisir une quantité de nourriture à feeder la vache
        int lunchfood;
        printf("Entrez la quantité de nourriture à donner à la vache (stock actuel : %d) : ", stock);
        scanf("%d", &lunchfood);

        // Vérifier si la quantité de nourriture entrée est valide
        if (lunchfood <= stock && lunchfood >= 0)
        {
            // Mettre à jour le stock de nourriture et le santé
            stock = stock_update(lunchfood);
            fitness = fitness_update(lunchfood);
        }
        else
        {
            printf("Quantité de nourriture invalide ! Veuillez réessayer.\n");
            continue;
        }
        
        // Vérifier si la vache est morte
        if (fitness == 0)
        {
            printf("La vache est décédée...de faim. Votre score est de %d.\n", duree_de_vie);
            affiche_vache_decédée();
            break;
        }

        if (fitness == 10)
        {
            printf("La vache est décédée...de surnourriture. Votre score est de %d.\n", duree_de_vie);
            affiche_vache_decédée();
            break;
        }
    }

    return 0;
}
