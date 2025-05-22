#include "type_tableau.h"

/* Copie le tableau t1 dans t2
   Pré-condition : t1 et t2 sont alloués
 */
void copie_tableau(tableau_entiers *t1, tableau_entiers *t2) {
  int i;

  t2->taille = t1->taille;

  for (i = 0; i < t1->taille; i++) {
    t2->tab[i] = t1->tab[i];
  }
}
