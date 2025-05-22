#include <stdio.h>

int main(int argc, char *argv[])
{ // Checker le nb d'argument
    if (argc != 3)
    {
        printf("Erreur, vous devez fournir 2 arguments\n");
        return 1;
    }
    // Ouvrir le fichier a lire
    FILE *A_lire = fopen(argv[1], "r");
    if (A_lire == NULL)
    {
        printf("Erreur, fichier null");
        return 1;
    }
    // Ouvrir le fichier de destination
    FILE *A_ecrire = fopen(argv[2], "w");
    if (A_ecrire == NULL)
    {
        printf("Erreur, fichier null");
        return 1;
    }
    // Lire la premiere ligne
    char chr;
    char lire[100000];
    fscanf(A_lire, "%c", &chr);
    while (!feof(A_lire))
    {
        fprintf(A_ecrire, "%c", chr);
        fscanf(A_lire, "%c", &chr);
        if (sizeof(lire))
            break;
    }
    // Fermer
    fclose(A_lire);
    fclose(A_ecrire);

    printf("Succes\n");
    return 0;
}