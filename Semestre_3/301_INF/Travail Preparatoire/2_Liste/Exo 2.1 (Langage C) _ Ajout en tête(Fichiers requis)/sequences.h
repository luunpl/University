/************************************************************/
/*     Bibliothèque pour les séquences d'entiers            */
/*        implémentées par une liste chaînée                */
/************************************************************/

/*        a priori : ne rien changer ici                    */

struct cellule {
    int valeur;
    struct cellule *suivant;
};
typedef struct cellule cellule_t;

struct liste {
    cellule_t *tete;
};
typedef struct liste liste_t;

/* lecture d'une sequence d'entiers.
  Format d'entrée : un espace entre deux entiers, -1 pour finir  */
void saisir(liste_t *l, int valeurMin);

/* Affichage d'une sequence d'entiers.
  Format de sortie : un espace entre deux entiers */
void afficher(liste_t *l);

/* Ajout en tete d'une sequence */
void ajout_en_tete(liste_t *l, int n);
