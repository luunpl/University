#include <stdio.h>

// Tout variable possede une adresse, c'est l'emplacement memoire ou elle est stocke et on l'obtient par &
int main(){
    // 1er exemple
    int variable = 42;
    printf("Variable est un int contenant %d\n"
            "Stocke a l'adresse %p\n", variable, &variable);
    // 2e exemple
    int x = 10;
    int *pointeur; // type int

    pointeur = &x;
    *pointeur = 21; // dereferencement
    printf("L'entier x contient : %d\n", x);
    x = x * 2;
    printf("L'entier pointe contient : %d\n", *pointeur);
    return 0;
}