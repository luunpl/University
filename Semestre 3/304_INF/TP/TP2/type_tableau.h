#ifndef _TYPE_TABLEAU_H_
#define _TYPE_TABLEAU_H_

#define TAILLE_MAX 10000

/* Définition du type vecteur_entiers : tableau d'entiers de taille TAILLE_MAX
 */
typedef int vecteur_entiers[TAILLE_MAX];

/* Structure contenant un tableau (de taille TAILLE_MAX) et un entier
   taille : le nombre d'entiers du tableau */
typedef struct {
  int taille;
  vecteur_entiers tab;
} tableau_entiers;

/* Copie le tableau t1 dans t2.
   Précondition : t1 et t2 sont alloués
 */
void copie_tableau(tableau_entiers *t1, tableau_entiers *t2);

#endif /* _TYPE_TABLEAU_H_ */
