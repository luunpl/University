/* Utiliser les fonctions d'entrées/sorties */
#include <stdio.h>

/* Procédure principale */
/* Paramètres de la fonction main :
   - argc : nombre d'arguments de la ligne de commande
   - argv : tableau de chaînes de caractères contenant les arguments
 */
int main(int argc, char *argv[]) {
  int i;

  /* Afficher le nom du programme */
  printf("Nom du programme : %s\n", argv[0]);

  /* Affichage des arguments de la ligne de commande */
  for (i = 1; i < argc; i++) {
    /* Afficher l'argument i */
    printf("Argument %d : %s\n", i, argv[i]);
  }
}
