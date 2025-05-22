#include <stdio.h>
#include <stdlib.h>

void joueurs_faibles(joueurs *e, int ens[]) {
  int i ;
  for (i=0 ; i < nombre_joueurs(e) ; i++) {
     if (billes_joueur(e, i) < 10)
        ens[i] = 1 ;
     else ens[i] = 0 ;
     }  
}

int main(int argc, char *argv[]) {
  int sous_ens_joueurs[NB_MAX_JOUEURS] ;
  joueurs e;

  if (argc != 3) {
         printf("syntaxe : %s fich_joueurs_entree fich_joueurs_sortie\n", argv[0]) ;
         exit(1) ;
  }
  lire_les_joueurs(&e, argv[1]) ;
  afficher_ensemble_joueurs(&e) ;

  /* calcul du sous-ensemble des joueurs faibles */
  joueurs_faibles(&e, sous_ens_joueurs) ;

  /* la fonction ecrire_les_elements(T_E,F) cree un fichier F qui contient
     la liste des joueurs qui font partie de l'ensemble E represente 
     par le tableau T_E : T_E[i] est vrai ssi le joueur i appartient a E.
     Le fichier F est au meme format que le fichier joueur en entree */
  ecrire_les_elements(&e, sous_ens_joueurs, argv[2]) ;
  return 0 ;
}
