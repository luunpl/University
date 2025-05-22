#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "joueurs_in.h"
#include "joueurs_out.h"
#include "operations.h"

int main (int argc, char *argv[]) {
  joueurs ens;
  char requete[9] ; char rqt ;
  int fini=0 ;
  if (argc != 3) {
         printf("syntaxe : %s fich_joueurs_entree fich_joueurs_sortie\n", argv[0]) ;
         exit(1) ;
  }
  lire_les_joueurs(&ens, argv[1]) ;
  afficher_ensemble_joueurs(&ens) ;
  while (!fini) {
     printf("\n Requête (G,P,T,Q) : ") ;
     scanf("%s", requete);
     rqt = requete[0] ;
     switch (rqt) {
        case 'G' : gain(&ens) ; break ;
        case 'P' : perte(&ens) ; break ;
        case 'T' : transfert(&ens) ; break ;
        case 'Q' : fini = 1 ;
        default : ;
     }
   }
  afficher_ensemble_joueurs(&ens) ;
  ecrire_les_joueurs(&ens, argv[2]) ;
  return 0 ;
 }
