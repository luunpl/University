#ifndef _TYPE_PILE_ERREURS_H_
#define _TYPE_PILE_ERREURS_H_

typedef enum {
  OK, // Pas d'erreur
  PILE_VIDE,
  PILE_PLEINE,
  POINTEUR_NUL
} erreur_pile;

#define TAILLE_MAX 100

typedef struct {
  int n;
  int tab[TAILLE_MAX];
} PileEntiers;

/* Constructeurs */

/* Créer une pile vide
   Précondition : p != NULL
   Résultat : p est une pile vide
   Retourne :
     - OK si la fonction s'est déroulée correctement
     - POINTEUR_NUL si p == NULL
 */
erreur_pile creer_pile(PileEntiers *p);

/* Opérations d'accès */

/* Retourne vrai ssi p est vide */
int est_vide(PileEntiers *p);

/* Renvoie l'entier en haut de la pile
   Précondition : p non vide
   Résultat : res contient l'entier en haut de la pile
   Retourne :
     - OK si la précondition est valide
     - PILE_VIDE si p est vide. Dans ce cas, la valeur de res n'est
       pas définie
 */
erreur_pile sommet(PileEntiers *p, int *res);

/* Renvoie le nombre d'éléments dans la pile */
int taille(PileEntiers *p);

/* Afficher les éléments de la pile */
void print(PileEntiers *p);

/* Opérations de modification */

/* Vider la pile p
   Précondition : p != NULL
   Résultat : p est une pile vide
   Retourne :
     - OK si la fonction s'est déroulée correctement
     - POINTEUR_NUL si p == NULL
*/
erreur_pile vider(PileEntiers *p);

/* Empiler un entier x
   Précondition : p != NULL et taille(p) < TAILLE_MAX
   Résultat : l'entier x est placé en haut de la pile
   Retourne :
     - OK si la fonction s'est déroulée correctement
     - POINTEUR_NUL si p == NULL
     - PILE_PLEINE si la structure est pleine, et l'entier ne peut
       être empilé. Dans ce cas la pile p n'est pas modifiée
*/
erreur_pile empiler(PileEntiers *p, int x);

/* Supprimer et renvoyer l'entier en haut de la pile
   Précondition : p != NULL et p non vide
   Résultat :
     - l'entier en haut de la pile est enlevé de la pile
     - l'entier resultat contient l'entier dépilé
   Retourne :
     - OK si la précondition est valide
     - POINTEUR_NUL si p == NULL
     - PILE_VIDE si p est vide. Dans ce cas, la pile n'est pas
       modifiée
*/
erreur_pile depiler(PileEntiers *p, int *resultat);

#endif
