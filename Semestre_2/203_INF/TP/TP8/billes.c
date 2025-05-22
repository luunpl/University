#include <stdio.h>
#include <string.h>
#include "generer_entier.h"
#include "joueurs.h"

void afficher_joueur(joueur* pj) {
	printf("%s a %d billes\n", pj->pseudo, pj->nb_billes) ;
	}

void lire_joueur(joueur* pj) {
  printf("Son nom ? ");
  scanf("%s", pj->pseudo);
  printf("Combien de billes ? ");
  scanf("%d", &pj->nb_billes);  
}


int main(int argc, char *argv[]) {
    int i;
    joueurs ens_joueurs;
    char nom[TAILLE_MAX_NOM] = "";

    if (argc < 2) {
        fprintf(stderr, "Ce programme requiert au moins 1 argument\n");
        exit(1);
    }

    init_joueurs(&ens_joueurs);
    printf("Copie successive des arguments dans l'ensemble :\n");
    for (i=1; i<argc; i++) {
        printf(" %s -", argv[i]);
        ajouter_joueur(&ens_joueurs, argv[i], generer_entier(500));
    }
    printf("\n") ;

    printf("Ensemble de joueurs dans lequel la recherche est faite :\n");
    /************* ou appel de la fct afficher_ensemble_joueurs **************/
    printf("{ ");
    for (i=0; i<nombre_joueurs(&ens_joueurs); i++) {
      printf("%s %d ", nom_joueur(&ens_joueurs, i),
	     billes_joueur(&ens_joueurs, i));
    }
    printf("}\n");

    printf("Qui voulez-vous ? ");
    scanf("%s", nom);
    while ( strcmp(nom, "q") != 0) {
      i = trouver_joueur(&ens_joueurs, nom);
      if (i == -1) {
        printf("-- Joueur absent de l'ensemble\n");
      } else {
        printf("%d\n", billes_joueur(&ens_joueurs, i));
      }
      printf("Qui voulez-vous ? ");
      scanf("%s", nom);
    }
    
    return 0;
}
