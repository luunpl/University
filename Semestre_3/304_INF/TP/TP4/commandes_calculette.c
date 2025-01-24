#include "commandes_calculette.h"

FILE *ouvrir_commandes(char *nom_fichier) { return fopen(nom_fichier, "r"); }

int fin_commandes(FILE *fichier) {
  if (fichier == NULL)
    return 1;
  return feof(fichier);
}

void print_commande_erreur(char *str) {
  printf("ERREUR : commande \"%s\" incorrecte\n", str);
}

commande commande_texte(char str[]) {
  int lgt;
  char c;
  commande command;

  lgt = strlen(str);
  if (str[lgt - 1] == '\n') {
    str[lgt - 1] = '\0';
    lgt--;
  }

  if (lgt == 0)
    printf("ERREUR : commande vide\n");

  if (lgt > 10)
    printf("ERREUR : ligne trop grande\n");

  c = str[0]; // identifier la commande str
  switch (c) {
  case 'd':
    if (strlen(str) > 1) {
      print_commande_erreur(str);
      command.cmd = COMMANDE_INCORRECTE;
    }

    command.cmd = DEPILER_SOMMET;
    break;

  case 'r':
    if (strlen(str) > 1) {
      print_commande_erreur(str);
      command.cmd = COMMANDE_INCORRECTE;
    }

    command.cmd = VIDER_PILE;
    break;

  case '+':
    if (strlen(str) > 1) {
      print_commande_erreur(str);
      command.cmd = COMMANDE_INCORRECTE;
    }

    command.cmd = EFFECTUER_ADDITION;
    break;

  case '*':
    if (strlen(str) > 1) {
      print_commande_erreur(str);
      command.cmd = COMMANDE_INCORRECTE;
    }

    command.cmd = EFFECTUER_MULTIPLICATION;
    break;

  case '/':
    if (strlen(str) > 1) {
      print_commande_erreur(str);
      command.cmd = COMMANDE_INCORRECTE;
    }

    command.cmd = EFFECTUER_DIVISION;
    break;

  default:
    // cas de l'opération SOUSTRACTION
    if ((c == '-') && (lgt == 1)) {
      command.cmd = EFFECTUER_SOUSTRACTION;
    } else {
      // recuperer la valeur correspondant à t
      // valeur entière correcte
      command.cmd = EMPILER_VALEUR;
      command.arg = atoi(str);
    }
    break;
  }
  return command;
}

commande commande_suivante(FILE *fichier) {
  int lgt = 1000;
  char str[lgt];

  memset(str, 0, lgt);
  if (fgets(str, lgt, fichier) != NULL) {
    fscanf(fichier, " ");
    return commande_texte(str);
  }
  return (commande){COMMANDE_INCORRECTE, 0};
}

void fermer_commandes(FILE *fichier) {
  if (fichier != NULL)
    fclose(fichier);
}

void print_commandes(commande command) {
  switch (command.cmd) {
  case VIDER_PILE:
    printf("VIDER_PILE\n");
    break;
  case DEPILER_SOMMET:
    printf("DEPILER_SOMMET\n");
    break;
  case EMPILER_VALEUR:
    printf("EMPILER_VALEUR : %d \n", command.arg);
    break;
  case EFFECTUER_ADDITION:
    printf("EFFECTUER_ADDITION\n");
    break;
  case EFFECTUER_SOUSTRACTION:
    printf("EFFECTUER_SOUSTRACTION \n");
    break;
  case EFFECTUER_MULTIPLICATION:
    printf("EFFECTUER_MULTIPLICATION \n");
    break;
  case EFFECTUER_DIVISION:
    printf("EFFECTUER_DIVISION \n");
    break;
  case COMMANDE_INCORRECTE:
    printf("COMMANDE_INCORRECTE\n");
    break;
  }
}
