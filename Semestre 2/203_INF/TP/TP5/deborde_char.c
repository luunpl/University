#include <stdio.h>
#include <stdlib.h>

int main() {
    unsigned char courant = 0, prochain = 1;

    printf("taille du type unsigned char : %ld octet(s)\n", sizeof(unsigned char));

    while (prochain > courant) {
        courant = prochain;
        prochain = prochain + 1;
    }

    printf("%u + 1 = %u donc ...\n", courant, prochain);
    printf("valeur maximum d'une variable de type unsigned char : %u\n", courant);

    return 0;
}
