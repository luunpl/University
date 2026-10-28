#include <stdio.h>
#include <stdlib.h>
#include "arbres.h"

/* A Faire (dans le fichier arbres.c) : 
  - implémenter la recherche d'une valeurs dans un arbre
      sur la structure de données définie dans arbres.h               */


/*             A priori : ne rien changer ci-dessous 
            (ou changer les jeux de test en conséquence)                      */



/* Programme principal (de test) */
int main() {
    arbre a;
    int n;

    initialiser(&a);
    afficher(a);
    printf("\n\n");
    printf("Version Parenthésée :");
    afficherParenthese(a);
    printf("\nVersion Ascii-Art horizontale :\n");
    afficher2D(a,0);
    printf("\n");
    printf("Donner une valeur pour la recherche\n");
    scanf("%d",&n);
    if (present(a,n)) {
        printf("Résultat : valeur présente\n");
    }
    else {
        printf("Résultat : valeur absente\n");
    }
    exit(0);
}
