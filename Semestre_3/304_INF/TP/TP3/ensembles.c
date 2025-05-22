
#include <stdio.h>
#include <stdlib.h>

#include "operations_ens.h"
#include "sac.h"
#include "type_ensemble.h"

int main(int argc, char **argv) {

  ensemble E1, E2, E3, E4, E5;
  sac s;
  int x;

  /* Le sac est lu dans le fichier dont le nom est fourni en argument
     de la ligne de commande */
  if (argc < 2) {
    printf("Usage: %s <fichier sac>\n", argv[0]);
    exit(1);
  }
  printf("Lecture du sac ...\n");
  initialiser_sac(&s, argv[1]);
  afficher_sac(&s);

  /* Saisie et affichage */
  printf("Entrée des éléments de l'ensemble E1\n");
  init_saisie(&E1, &s);
  printf("Entrée des éléments de l'ensemble E2\n");
  init_saisie(&E2, &s);
  printf("Entrée des éléments de l'ensemble E3\n");
  init_saisie(&E3, &s);
  printf("E1\n");
  afficher_ensemble(&E1);
  printf("\n");
  printf("E2\n");
  afficher_ensemble(&E2);
  printf("\n");
  printf("E3\n");
  afficher_ensemble(&E3);
  printf("\n");
  /* Test d'égalité */
  if (egal(&E2, &E3)) {
    printf("E2 et E3 sont égaux\n");
  } else {
    printf("E2 et E3 ne sont pas égaux\n");
  }
  printf("\n");
  if (egal(&E2, &E2)) {
    printf("E2 est toujours égal a lui-même\n");
  } else {
    printf("Étrange... E2 est différent de lui-même\n");
  }
  /* Test d'appartenance */
  printf("\nDonnez un entier : \n");
  scanf("%d", &x);
  if (appartient(x, &E2)) {
    printf("%d appartient à ", x);
  } else {
    printf("%d n'appartient pas à ", x);
  }
  afficher_ensemble(&E2);
  /* Intersection */
  printf("\n\n");
  intersection(&E2, &E3, &E4);
  afficher_ensemble(&E4);
  printf(" est l'intersection des deux ensembles suivants :\n");
  afficher_ensemble(&E2);
  afficher_ensemble(&E3);
  printf("\n");
  intersection(&E3, &E2, &E5);
  afficher_ensemble(&E5);
  printf("\nest l'intersection des deux mêmes ensembles\n");
  if (egal(&E5, &E4)) {
    printf("Ils sont egaux, evidemment\n");
  } else {
    printf("Bizarre, ils sont differents\n");
  }
  /* Union */
  printf("\n\nL'union des deux ensembles suivants \n");
  afficher_ensemble(&E4);
  afficher_ensemble(&E1);
  union_ens(&E4, &E1);
  printf("\nest l'ensemble \n");
  afficher_ensemble(&E4);

  printf("\nUn ensemble dû au hasard... \n");
  init_alea(&E1, &s);
  afficher_ensemble(&E1);
  printf("\n");
}
