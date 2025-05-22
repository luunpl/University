#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>

void update()
{
    printf("\033[H\033[J"); // Reutiliser la fonction update vu dans wildcow.c
}

// Fonction pour afficher la vache, cette fois on utilise plusieurs lignes printf au lieu de 1 comme newcow.c
void affiche_vache(char *mouth, char *bubble)
{
    printf("_____\n");
    printf("< %s >\n", bubble);
    printf("-----\n");
    printf("  \\   ^__^\n");
    printf("   \\  (oo)\\_______\n");
    printf("      (__)       )\\/\\\n");
    printf("       %s ||----w||\n", mouth);
    printf("          ||     ||\n");
}

int main(int argc, char *argv[])
{
    FILE *file;
    char ch;
    char mouth[1000] = "";  // Initialiser la bouche de la vache
    char bubble[1000] = ""; // Initialiser la bulle de texte

    // Verifie si le ficher est passe dans l'argument
    if (argc == 1)
    {
        printf("Usage: %s <file>\n", argv[0]);
        exit(EXIT_FAILURE);
    }

    // Ouvrir le fichier
    file = fopen(argv[1], "r");
    if (file == NULL)
    {
        perror("Error opening file");
        exit(EXIT_FAILURE);
    }

    // Effacer l'ecran
    system("clear");

    // Lire le fichier caractère par caractère
    while ((ch = fgetc(file)) != EOF)
    {
        // Ajouter le caractère à la bouche de la vache
        char temp[1000] = {ch, '\0'};
        strcat(mouth, temp);

        // Effacer l'ecran
        system("clear");

        // Afficher la vache avec la bouche et la bulle de texte mises à jour
        affiche_vache(mouth, bubble);

        // Attendre une seconde
        sleep(1);

        // Mettre à jour la bulle de texte avec le contenu actuel de la bouche
        strcat(bubble, temp);

        // Effacer la bouche pour afficher le prochain char
        update();
        mouth[0] = '\0'; // Reinitialiser la bouche
    }

    // Fermer le fichier
    fclose(file);

    return 0;
}
