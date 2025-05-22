/************************************************************/
/*  bibliothèque pour les sequences d'entiers (ordonnées)   */
/************************************************************/

/*        a priori : ne rien changer ici                    */

#define LMAX 1000

struct sequence_tab {
    int longueur;
    int tab[LMAX];
};
typedef struct sequence_tab seqtab_t;

struct cellule {
    int valeur;
    struct cellule *suivant;};
typedef struct cellule cellule_t;

struct liste {
    cellule_t *tete;};
typedef struct liste liste_t;

/* lecture d'une sequence d'entiers.
  Format d'entrée : un espace entre deux entiers, -1 pour finir  */
void saisir(seqtab_t *S, int valeurMin) ;

/* Affichage d'une sequence d'entiers sous forme de liste chainée.
  Format de sortie : un espace entre deux entiers */
void afficher(liste_t l);

/* pain_au_chocolat */
liste_t pain_au_chocolat(seqtab_t *S);