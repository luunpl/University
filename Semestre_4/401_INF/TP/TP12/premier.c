#include "stdio.h"
#include "string.h"

#define N 10

int main () {
char chaine [N] ;
int i ;

    printf ("Donner une chaine de longueur inferieure a %d:\n", N);
    fgets (chaine, N, stdin);
    printf ("la chaine lue est : %s\n",chaine);
    i = strlen (chaine) ;
    printf ("la longueur de la chaine lue est : %d\n", i);
}

