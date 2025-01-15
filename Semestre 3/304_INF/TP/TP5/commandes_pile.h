#ifndef _COMMANDES_PILE_H_

#define _COMMANDES_PILE_H_

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef enum {
  VIDER_PILE,
  DEPILER_SOMMET,
  EMPILER_VALEUR,
  AFFICHER_PILE,
  AFFICHER_SOMMET,
  AFFICHER_PILE_VIDE,
  AFFICHER_TAILLE_PILE,
  COMMANDE_INCORRECTE
} nature_commande;

typedef struct {
  nature_commande cmd;
  int arg; //-- valeur dans le cas cmd = EMPILER
} commande;

// le fichier dont le nom est donné en paramètre est ouvert en lecture
// la prochaine commande est prête à être lue.
FILE *ouvrir_commandes(char *nom_fichier);

//-- renvoie vrai si la fin du fichier de commandes est atteinte.
int fin_commandes(FILE *fichier);

// renvoie la commande correspondant à la chaine de caracteres str
commande commande_texte(char str[]);

// lit et renvoie la prochaine commande du fichier.
commande commande_suivante(FILE *fichier);

// le fichier de commande n'est plus accessible
// en lecture.
void fermer_commandes(FILE *fichier);

// affiche la commande
void print_commandes(commande command);

#endif
