#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void affiche_vache(char *yeux)
{
    printf(
        "        ^--^\n\
        (%s)\\-------\n\
        (__)\\       )\\/\\\n\
            ||-----w |\n\
            ||     || \n",
        yeux

    );
}

int main(int argc, char *argv[])
{
    char eyes[80] = "00"; // Yeux normal s'il n'a pas chosi l'option -e
    int tail = 1;         // Nombre de vache(1 par defaut)

    // Parcourir les arguments de la ligne de commande
    for (int i = 1; i < argc; i++)
    {
        // Verification de l'option -e ou --eyes
        if (strcmp(argv[i], "-e") == 0 || strcmp(argv[i], "--eyes") == 0)
        {
            // Copier les yeux spécifiés dans la variable eyes
            strncpy(eyes, argv[i + 1], sizeof(eyes) - 1);
            i++; // Passer a l'argument suivant
        }

        //  Verification de l'option --tail
        else if (strcmp(argv[i], "--tail") == 0)
        {
            // Obtenir le nombre de vaches à afficher
            tail = atoi(argv[i + 1]);
            i++;
        }
    }

    // Afficher le troupe de vache
    for (int i = 0; i < tail; i++)
    {
        affiche_vache(eyes);
        printf("\n");
    }

    return 0;
}
