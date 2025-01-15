#include "commandes_pile.h"
#include "type_pile.h"
#include <stdio.h>

int main(int argc, char **argv) {
  FILE *fichier = NULL;
  if (argc != 2) {
    printf("mauvaise utilisation : donnez un nom de fichier en argument\n");
    return 0;
  }

  fichier = ouvrir_commandes(argv[1]);
  PileEntiers p;
  creer_pile(&p);

  commande command;

  int value;

  while (!fin_commandes(fichier)) {
    command = commande_suivante(fichier);
    print_commandes(command);
    switch (command.cmd) {
    case VIDER_PILE:
      vider(&p);
      break;
    case DEPILER_SOMMET:
      depiler(&p);
      break;
    case EMPILER_VALEUR:
      empiler(&p, command.arg);
      break;
    case AFFICHER_PILE:
      print(&p);
      break;
    case AFFICHER_SOMMET:
      value = sommet(&p);
      printf("Sommet de la pile : %d \n", value);
      break;
    case AFFICHER_PILE_VIDE:
      if (est_vide(&p)) {
        printf("La pile est vide\n");
      } else {
        printf("La pile n'est pas vide\n");
      }
      break;
    case AFFICHER_TAILLE_PILE:
      printf("Taille de la pile : %d \n", taille(&p));
      break;
    case COMMANDE_INCORRECTE:
      printf("Commande incorrecte !\n");
      break;
    }
    print(&p);
    printf("\n");
  }
  fermer_commandes(fichier);
  return 0;
}
