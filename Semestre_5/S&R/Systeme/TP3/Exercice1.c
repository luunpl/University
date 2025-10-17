#include <stdio.h>
#include <stdlib.h>

int main(void) {
    int k;
    k = 8;

    /* Pré-incrémentation: ++k */
    printf("Valeur de l'expression ++k : %d\n", ++k); 
    printf("Valeur de k après ++k : %d\n\n", k);

    /* Remettre k à 8 */
    k = 8;

    /* Post-incrémentation: k++ */
    printf("Valeur de l'expression k++ : %d\n", k++); 
    printf("Valeur de k après k++ : %d\n\n", k);

    /* Exemple pointeur */
    float tab[5] = {0.5f, 1.0f, 1.8f, 2.4f, 3.1f};
    float *p;
    p = tab;
    printf("Boucle avec *p++ (post-incrémentation du pointeur):\n");
    while (p < (tab + 5)) { /* tab + 5 pointe juste après le dernier élément */
        printf("element dans tab : %f\n", *p++); /* affiche *p puis p = p + 1 */
    }

    /* Réinitialiser p pour l'exemple *++p */
    p = tab;
    printf("\nBoucle avec *++p (pré-incrémentation du pointeur) :\n");
    /* ici on doit faire attention: *++p incrémente d'abord p, donc la première valeur affichée est tab[1] */
    while (p < (tab + 4)) { /* pour éviter d'aller au-delà lors de *++p */
        printf("element dans tab : %f\n", *++p);
    }

    return 0;
}
