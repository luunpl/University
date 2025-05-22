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
    FILE *A_copier = fopen(argv[2], "w");
    if (A_copier == NULL)
    {
        printf("Erreur, fichier null");
        return 1;
    }
    // Lire et copier le fichier caractere par caractere
    char chr;
    fscanf(A_lire, "%c", &chr);
    while (!feof(A_lire))
    {
        fprintf(A_copier, "%c", chr);
        fscanf(A_lire, "%c", &chr);
    }
    
    fclose(A_lire);
    fclose(A_copier);

    printf("Succes\n");
    return 0;
}