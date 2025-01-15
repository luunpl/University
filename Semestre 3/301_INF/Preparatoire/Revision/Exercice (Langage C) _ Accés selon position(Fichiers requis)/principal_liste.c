#include <stdio.h>
#include "sequences.h"

/* A Faire (dans le fichier sequences.c) : 
  - implémenter l'acces à une liste à une position donnée
      sur la structure de données définie dans sequences.h (liste chainée)
  - tester (ajout éventuel de cas de test dans le fichier usr_evaluate.cases), 
                                                     */


/*             A priori : ne rien changer ci-dessous 
            (ou changer les jeux de test en conséquence)                      */


/* Programme principal (de test) */
int main() {
int n,p;
liste_t res;
liste_t l;
l.tete = NULL;
res.tete = NULL;


printf("Donner une sequence d'entiers positifs\n\n");
saisir(&l,0);
printf("Donner la position à atteindre \n\n");
scanf("%d",&p);
res.tete=acces_position(l,p);
printf("Résultat : ");
afficher(res);
return 0;}
