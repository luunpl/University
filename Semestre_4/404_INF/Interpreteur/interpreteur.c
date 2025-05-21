#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "analyse_syntaxique.h"
#include "ast_parcours.h"
#include "table_symbole.h"

int main(int argc, char *argv[]) {
  if (argc != 2) { // Vérifie le nombre d'arguments
    printf("Erreur : Nombre d'arguments incorrect\n");
    return 1;
  }

  Ast arbre = NULL; // Initialisation de l'arbre
  analyser(argv[1], &arbre);

  if (arbre != NULL) {
    printf("Affichage des variables dans l'arbre syntaxique :\n");
    afficheTS(TS, NbSymb); // Affiche les variables à la fin de l'analyse
    printf("Analyse syntaxique réussie !\n");
  }

  return 0;
}
