#include "commandes_pile.h"

FILE *ouvrir_commandes(char *nom_fichier) { return fopen(nom_fichier, "r"); }

int fin_commandes(FILE *fichier) {
  if (fichier == NULL)
    return 1;
  return feof(fichier);
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
    command.cmd = COMMANDE_INCORRECTE;

  if (lgt > 10)
    command.cmd = COMMANDE_INCORRECTE;

  c = str[0]; //-- identifier la commande str
  switch (c) {
  case 'p':
    if (strlen(str) > 1) {
      command.cmd = COMMANDE_INCORRECTE;
    }
    command.cmd = AFFICHER_PILE;
    break;
  case 's':
    if (strlen(str) > 1) {
      command.cmd = COMMANDE_INCORRECTE;
    }
    command.cmd = AFFICHER_SOMMET;
    break;
  case 'd':
    if (strlen(str) > 1) {
      command.cmd = COMMANDE_INCORRECTE;
    }
    command.cmd = DEPILER_SOMMET;
    break;
  case 'v':
    if (strlen(str) > 1) {
      command.cmd = COMMANDE_INCORRECTE;
    }
    command.cmd = AFFICHER_PILE_VIDE;
    break;
  case 't':
    if (strlen(str) > 1) {
      command.cmd = COMMANDE_INCORRECTE;
    }
    command.cmd = AFFICHER_TAILLE_PILE;
    break;
  case 'r':
    if (strlen(str) > 1) {
      command.cmd = COMMANDE_INCORRECTE;
    }
    command.cmd = VIDER_PILE;
    break;
  default:                   // -- recuperer la valeur correspondant à t
    command.arg = atoi(str); //-- valeur entière correcte
    command.cmd = EMPILER_VALEUR;
    break;
  }
  return command;
}

commande commande_suivante(FILE *fichier) {
  int lgt = 1000; // 11;
  char str[lgt];

  memset(str, 0, lgt);
  if (fgets(str, lgt, fichier) != NULL) {
    // lire une séquence d'espaces : notamment les lignes vides
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
  case AFFICHER_PILE:
    printf("AFFICHER_PILE\n");
    break;
  case AFFICHER_SOMMET:
    printf("AFFICHER_SOMMET \n");
    break;
  case AFFICHER_PILE_VIDE:
    printf("AFFICHER_PILE_VIDE \n");
    break;
  case AFFICHER_TAILLE_PILE:
    printf("AFFICHER_TAILLE_PILE \n");
    break;
  case COMMANDE_INCORRECTE:
    printf("COMMANDE_INCORRECTE \n");
    break;
  }
}
