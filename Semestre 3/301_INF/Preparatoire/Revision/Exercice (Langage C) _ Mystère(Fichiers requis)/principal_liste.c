#include <stdio.h>
#include "sequences.h"

/* A Faire (dans le fichier sequences.c) : 
  - implémenter mystere
      sur la structure de données définie dans sequences.h (liste chainée)
  - tester (ajout éventuel de cas de test dans le fichier usr_evaluate.cases), 
                                                     */


/*             A priori : ne rien changer ci-dessous 
            (ou changer les jeux de test en conséquence)                      */


/* Programme principal (de test) */
int main() {
int n;
liste_t a,b,c;
a.tete = NULL;
b.tete = NULL;
c.tete = NULL;


printf("Donner une première sequence d'entiers positifs\n\n");
saisir(&a,0);
printf("Donner une seconde sequence d'entiers positifs\n\n");
saisir(&b,0);
c.tete =mystere(a.tete, b.tete);
printf("Résultat : ", n);
afficher(c);
return 0;}
