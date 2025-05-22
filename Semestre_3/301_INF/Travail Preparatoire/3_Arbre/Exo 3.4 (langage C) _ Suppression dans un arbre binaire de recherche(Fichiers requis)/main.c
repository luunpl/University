#include <stdio.h>
#include <stdlib.h>
#include "arbres.h"

/* A Faire (dans le fichier arbres.c) : 
  - implémenter l'insertion dans un Arbre Binaire de Recherche (ABR).
    Pour cette version, si la valeur est déjà présente, ne pas modifier l'arbre.  */

/*             A priori : ne rien changer ci-dessous 
            (ou changer les jeux de test en conséquence)                      */



/* Programme principal (de test) */
int main()
{
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
    printf("Donner un nombre à inserer :\n");
    scanf("%d",&n);

    if (supprimer_abr(&a, n)) {
        printf("Résultat :");
        afficher(a);
    } else {
        printf("Résultat : valeur absente\n");
    }
    printf("\n");
    exit(0);
}
