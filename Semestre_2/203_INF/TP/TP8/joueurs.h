#ifndef __JOUEURS_H__
#define __JOUEURS_H__

#define NB_MAX_JOUEURS 100
#define TAILLE_MAX_NOM 32

typedef struct {
	char pseudo[TAILLE_MAX_NOM] ;
	int nb_billes ;
	} joueur ;

/* type joueurs servant a stocker un ensemble de chaines indicees par un entier
 */
struct ensemble_joueurs {
	joueur T[NB_MAX_JOUEURS] ;
	int nb ;
	};

typedef struct ensemble_joueurs joueurs;

/* initialisation d'un ensemble de joueurs a l'ensemble vide */
void init_joueurs(joueurs *ens);

/* ajout d'un joueur dans un ensemble de joueurs s'il n'y est pas deja.
 * Dans tous les cas renvoie l'indice du joueur dans l'ensemble */
int ajouter_joueur(joueurs *ens, char *nom, int billes);

/* cardinal d'un ensemble de joueurs */
int nombre_joueurs(joueurs *ens);

/* joueur d'indice i (NULL si ce joueur n'existe pas dans l'ensemble) */
char *nom_joueur(joueurs *ens, int i);

/* nombre du billes du joueurs à l'indice i (0 si inexistant) */
int billes_joueur(joueurs *ens, int i);

/* recherche de l'indice d'un joueur dans un ensemble, -1 si joueur non
 * present dans l'ensemble */
int trouver_joueur(joueurs *ens, char *nom);

/* met à jour le nombre de billes du joueur d'indice i */
void modifier_billes(joueurs *ens, int i, int cpt);

/* pour aider a la mise au point des programmes - affichage des
 * joueurs d'un ensemble de joueurs */
void afficher_ensemble_joueurs(joueurs *ens);

#endif
