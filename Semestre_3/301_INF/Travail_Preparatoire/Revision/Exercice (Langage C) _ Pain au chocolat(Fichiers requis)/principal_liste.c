#include <stdio.h>
#include "sequences.h"

/* A Faire (dans le fichier sequences.c) : 
  - implémenter pain_au_chocolat 
                                                     */


/*             A priori : ne rien changer ci-dessous 
            (ou changer les jeux de test en conséquence)                      */


/* Programme principal (de test) */
int main() {
liste_t l,res;
seqtab_t seq;
l.tete = NULL;
res.tete=NULL;

printf("Donner une liste d'entiers positifs (un entier négatif pour finir)\n\n");
saisir(&seq,0);
res=pain_au_chocolat(&seq);
printf("Résultat : ");
afficher(res);
return 0;}
