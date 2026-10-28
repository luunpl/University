#include <stdio.h>
#include <stdlib.h>
#include "arbres.h"

/* A Faire (dans le fichier arbres.c) : 
  - implémenter le calcul de la somme des valeurs de l'arbre 
      sur la structure de données définie dans arbBinDEntiers.h               */


/*             A priori : ne rien changer ci-dessous 
            (ou changer les jeux de test en conséquence)                      */



/* Programme principal (de test) */
int main() {
    arbre a;

    initialiser(&a);
    afficher(a);
    printf("\n\n");
    printf("Version Parenthésée :");
    afficherParenthese(a);
    printf("\nVersion Ascii-Art horizontale :\n");
    afficher2D(a,0);
    printf("\n");
    int s = somme_valeurs(a);
    printf("Résultat : %d\n",s);
    exit(0);
}
