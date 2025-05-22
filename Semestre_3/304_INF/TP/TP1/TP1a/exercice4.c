#include <stdio.h>

int main(int argc, char *argv[])
{ // Checker le nb d'argument
    if (argc != 2)
    {
        printf("Erreur, vous devez fournir 1 argument\n");
        return 1;
    }
    // Ouvrir le fichier a lire
    FILE *A_lire = fopen(argv[1], "r");
    if (A_lire == NULL)
    {
        printf("Erreur, fichier null");
        return 1;
    }



    printf("Succes\n");
    return 0;
}