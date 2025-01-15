
#include <stdio.h>
#include "generer_entier.c"

int main() {
    long x = generer_entier(100);
    printf("J'ai genere l'entier %ld\n", x);
    return 0;
}
