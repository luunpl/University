#include <stdbool.h>

/************************************************************************/
/*  bibliothèque pour les arbres binaires d'entiers  */
/************************************************************************/

/*        a priori : ne rien changer ici                    */

struct noeud_s;

typedef struct noeud_s noeud;

typedef noeud* arbre;

struct noeud_s {
    int valeur;
    arbre gauche;
    arbre droit;
};

void initialiser(arbre *a);
void afficher(arbre a);
void afficher2D(arbre a, int d);
void afficherParenthese(arbre a);
bool inserer_abr(arbre *a_p, int n);
