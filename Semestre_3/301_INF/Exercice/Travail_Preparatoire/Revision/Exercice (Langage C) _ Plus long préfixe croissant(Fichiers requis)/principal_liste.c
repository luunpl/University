#include <stdio.h>
#include "sequences.h"

/* A Faire (dans le fichier sequences.c) : 
  - implémenter le calcul de la longueur du plus grand prefixe croissant
      sur la structure de données définie dans sequences.h (liste chainée)
  - tester (ajout éventuel de cas de test dans le fichier usr_evaluate.cases), 
                                                     */


/*             A priori : ne rien changer ci-dessous 
            (ou changer les jeux de test en conséquence)                      */


/* Programme principal (de test) */
int main() {
int n;
liste_t l;
l.tete = NULL;


printf("Donner une sequence d'entiers positifs\n\n");
saisir(&l,0);
n=longueur_prefixe_croissant(l);
printf("Résultat : %d\n",n);
return 0;}
