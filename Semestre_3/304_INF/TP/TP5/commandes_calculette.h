#ifndef _COMMNDES_CALCULETTE_H_

#define _COMMNDES_CALCULETTE_H_

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// paquetage de gestion de commandes d'opération sur une pile d'entiers
// pour la calculette.
// Le format d'un fichier est le suivant :
//   une commande par ligne
//   chaque ligne contient :
//     soit une valeur entière
//     soit un des caractères suivants :
//       'd' : pour supprimer la valeur au sommet de la pile
//       'r' : pour effacer le contenu de la pile de la calculette
//       '+' : pour effectuer une addition
//       '-' : pour effectuer une soustraction
//       '*' : pour effectuer une multiplication
//       '/' : pour effectuer une division
//
//       une valeur entiere correspond à une commande de nature EMPILER_VALEUR
//       'd' correspond à une commande de nature DEPILER_SOMMET
//       'r' correspond à une commande de nature VIDER_PILE
//       '+' correspond à une commande de nature EFFECTUER_ADDITION
//       '-' correspond à une commande de nature EFFECTUER_SOUSTRACTION
//       '*' correspond à une commande de nature EFFECTUER_MULTIPLICATION
//       '/' correspond à une commande de nature EFFECTUER_DIVISION
// Si un fichier ne respecte pas ce format,
// la valeur COMMANDE_INCORRECTE est retournée

// partie spécification

typedef enum {
  VIDER_PILE,
  DEPILER_SOMMET,
  EMPILER_VALEUR,
  EFFECTUER_ADDITION,
  EFFECTUER_SOUSTRACTION,
  EFFECTUER_MULTIPLICATION,
  EFFECTUER_DIVISION,
  COMMANDE_INCORRECTE
} nature_commande;

typedef struct {
  nature_commande cmd;
  int arg; // valeur dans le cas cmd = EMPILER_VALEUR
} commande;

// le fichier dont le nom est donné en paramètre est ouvert en lecture
// la prochaine commande est prête à être lue.
FILE *ouvrir_commandes(char *nom_fichier);

// renvoie vrai si la fin du fichier de commandes est atteinte.
int fin_commandes(FILE *fichier);

// renvoie la commande correspondant à la chaine de caracteres str
commande commande_texte(char str[]);

// lit et renvoie la prochaine commande du fichier
commande commande_suivante(FILE *fichier);

// le fichier de commande n'est plus accessible
// en lecture.
void fermer_commandes(FILE *fichier);

// affiche la commande
void print_commandes(commande command);

#endif
