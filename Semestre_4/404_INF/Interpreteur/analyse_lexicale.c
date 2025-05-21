/* ------------------------------------------------------------------------
-- paquetage analyse_lexicale
--
-- analyse lexicale d'une expression arithmetique
--
-- J-P. Peyrin, G. Serasset (version initiale) : janvier 1999
-- P.Habraken - 18/01/2010
--
-- 10 juin 2006 - PH :
-- remplacement record a champs variants par record "plat"
-- remplacement traitement iteratif par automate
--
-- Aout 2016 - LM : version C
------------------------------------------------------------------------ */

#include <string.h>
#include <stdlib.h>
#include <stdio.h>

#include "lecture_caracteres.h"
#include "analyse_lexicale.h"

/* Les variables et fonctions locales au module */

Lexeme lexeme_en_cours; /* le lexeme courant */

void ajouter_caractere(char *s, char c);
Nature_Caractere nature_caractere(char c);
int est_separateur(char c);
int est_chiffre(char c);
int est_symbole(char c);
int est_lettre(char c);
void reconnaitre_lexeme();

/* --------------------------------------------------------------------- */

void demarrer(char *nom_fichier) {
   demarrer_car(nom_fichier);
   avancer();
}

/* --------------------------------------------------------------------- */

void avancer() {
   reconnaitre_lexeme();
}

/* --------------------------------------------------------------------- */

Lexeme lexeme_courant() {
   return lexeme_en_cours;
}

/* --------------------------------------------------------------------- */

int fin_de_sequence() {
   return lexeme_en_cours.nature == FIN_SEQUENCE;
}

/* --------------------------------------------------------------------- */

void arreter() {
   arreter_car();
}

/* --------------------------------------------------------------------- */

char motCle[9][20] = {"lire", "ecrire", "si", "alors", "sinon", "fsi", "tanque", "faire", "fait"};

void reconnaitre_lexeme() {
   typedef enum { E_INIT, E_AFF, E_IDF, E_ENTIER, E_FIN, E_COMP_EGAL, E_COMP_SUP, E_COMP_INF } Etat_Automate;
   Etat_Automate etat = E_INIT;

   while (est_separateur(caractere_courant())) {
      avancer_car();
   };
   lexeme_en_cours.chaine[0] = '\0';

   while (etat != E_FIN) {
      switch (etat) {
         case E_INIT:
            switch (nature_caractere(caractere_courant())) {
               case C_FIN_SEQUENCE:
                  lexeme_en_cours.nature = FIN_SEQUENCE;
                  etat = E_FIN;
                  break;
               case CHIFFRE:
                  lexeme_en_cours.nature = ENTIER;
                  lexeme_en_cours.ligne = numero_ligne();
                  lexeme_en_cours.colonne = numero_colonne();
                  ajouter_caractere(lexeme_en_cours.chaine, caractere_courant());
                  lexeme_en_cours.valeur = caractere_courant() - '0';
                  etat = E_ENTIER;
                  avancer_car();
                  break;
               case SYMBOLE:
                  lexeme_en_cours.ligne = numero_ligne();
                  lexeme_en_cours.colonne = numero_colonne();
                  switch (caractere_courant()) {
                     case '+':
                        lexeme_en_cours.nature = PLUS;
                        etat = E_FIN;
                        ajouter_caractere(lexeme_en_cours.chaine, caractere_courant());
                        break;
                     case '-':
                        lexeme_en_cours.nature = MOINS;
                        etat = E_FIN;
                        ajouter_caractere(lexeme_en_cours.chaine, caractere_courant());
                        break;
                     case '*':
                        lexeme_en_cours.nature = MUL;
                        etat = E_FIN;
                        ajouter_caractere(lexeme_en_cours.chaine, caractere_courant());
                        break;
                     case '/':
                        lexeme_en_cours.nature = DIV;
                        etat = E_FIN;
                        ajouter_caractere(lexeme_en_cours.chaine, caractere_courant());
                        break;
                     case '(':
                        lexeme_en_cours.nature = PARO;
                        etat = E_FIN;
                        ajouter_caractere(lexeme_en_cours.chaine, caractere_courant());
                        break;
                     case ')':
                        lexeme_en_cours.nature = PARF;
                        etat = E_FIN;
                        ajouter_caractere(lexeme_en_cours.chaine, caractere_courant());
                        break;
                     case ':':
                        lexeme_en_cours.nature = AFF;
                        etat = E_AFF;
                        ajouter_caractere(lexeme_en_cours.chaine, caractere_courant());
                        break;
                     case ';':
                        lexeme_en_cours.nature = SEPAFF;
                        etat = E_FIN;
                        ajouter_caractere(lexeme_en_cours.chaine, caractere_courant());
                        break;
                     case '>':
                        lexeme_en_cours.nature = OPCOMP;
                        etat = E_COMP_SUP;
                        ajouter_caractere(lexeme_en_cours.chaine, caractere_courant());
                        break;
                     case '<':
                        lexeme_en_cours.nature = OPCOMP;
                        etat = E_COMP_INF;
                        ajouter_caractere(lexeme_en_cours.chaine, caractere_courant());
                        break;
                     case '=':
                     case '!':
                        lexeme_en_cours.nature = OPCOMP;
                        etat = E_COMP_EGAL;
                        ajouter_caractere(lexeme_en_cours.chaine, caractere_courant());
                        break;
                     default:
                        printf("Erreur_Lexicale\n");
                        exit(0);
                        break;
                  }
                  avancer_car();
                  break;
               case LETTRE:
                  lexeme_en_cours.ligne = numero_ligne();
                  lexeme_en_cours.colonne = numero_colonne();
                  ajouter_caractere(lexeme_en_cours.chaine, caractere_courant());
                  lexeme_en_cours.nature = IDF;
                  etat = E_IDF;
                  avancer_car();
                  break;
               default:
                  printf("erreur\n");
                  exit(0);
                  break;
            };
            break;

         case E_AFF:
            if (nature_caractere(caractere_courant()) == SYMBOLE) {
               switch (caractere_courant()) {
                  case '=':
                     ajouter_caractere(lexeme_en_cours.chaine, caractere_courant());
                     lexeme_en_cours.nature = AFF;
                     etat = E_FIN;
                     avancer_car();
                     break;
                  default:
                     printf("erreur lexicale concernant AFF\n");
                     exit(0);
                     break;
               }
            } else {
               printf("erreur lexicale concernant AFF\n");
               exit(0);
            }
            break;

         case E_ENTIER:
            switch (nature_caractere(caractere_courant())) {
               case CHIFFRE:
                  ajouter_caractere(lexeme_en_cours.chaine, caractere_courant());
                  lexeme_en_cours.valeur = lexeme_en_cours.valeur * 10 + caractere_courant() - '0';
                  etat = E_ENTIER;
                  avancer_car();
                  break;
               case LETTRE:
                  printf("IDF peut pas commencer par un chiffre\n");
                  exit(0);
                  break;
               default:
                  etat = E_FIN;
                  break;
            };
            break;

         case E_IDF:
            switch (nature_caractere(caractere_courant())) {
               case CHIFFRE:
               case LETTRE:
                  ajouter_caractere(lexeme_en_cours.chaine, caractere_courant());
                  lexeme_en_cours.nature = IDF;
                  etat = E_IDF;
                  avancer_car();
                  break;
               default:
                  for (int i = 0; i < NB_MOTCLE; i++) {
                     if (strcmp(lexeme_en_cours.chaine, motCle[i]) == 0) {
                        switch (i) {
                           case 0:
                              lexeme_en_cours.nature = LIRE;
                              break;
                           case 1:
                              lexeme_en_cours.nature = ECRIRE;
                              break;
                           case 2:
                              lexeme_en_cours.nature = SI;
                              break;
                           case 3:
                              lexeme_en_cours.nature = ALORS;
                              break;
                           case 4:
                              lexeme_en_cours.nature = SINON;
                              break;
                           case 5:
                              lexeme_en_cours.nature = FSI;
                              break;
                           case 6:
                              lexeme_en_cours.nature = TANQUE;
                              break;
                           case 7:
                              lexeme_en_cours.nature = FAIRE;
                              break;
                           case 8:
                              lexeme_en_cours.nature = FAIT;
                              break;
                        }
                     }
                  }
                  etat = E_FIN;
                  break;
            }
            break;

         case E_COMP_EGAL:
            if (nature_caractere(caractere_courant()) == SYMBOLE) {
               if (caractere_courant() == '=') {
                  ajouter_caractere(lexeme_en_cours.chaine, caractere_courant());
                  lexeme_en_cours.nature = OPCOMP;
                  etat = E_FIN;
                  avancer_car();
               } else {
                  printf("erreur lexicale concernant COMP = !\n");
                  exit(0);
               }
            } else {
               printf("erreur lexicale concernant COMP = !\n");
               exit(0);
            }
            break;

         case E_COMP_SUP:
            if (nature_caractere(caractere_courant()) == SYMBOLE) {
               if (caractere_courant() == '=' || caractere_courant() == '>') {
                  ajouter_caractere(lexeme_en_cours.chaine, caractere_courant());
                  lexeme_en_cours.nature = OPCOMP;
                  etat = E_FIN;
                  avancer_car();
               } else {
                  printf("erreur lexicale concernant COMP >\n");
                  exit(0);
               }
            } else {
               printf("erreur lexicale concernant COMP >\n");
               exit(0);
            }
            break;

         case E_COMP_INF:
            if (nature_caractere(caractere_courant()) == SYMBOLE) {
               if (caractere_courant() == '=' || caractere_courant() == '<') {
                  ajouter_caractere(lexeme_en_cours.chaine, caractere_courant());
                  lexeme_en_cours.nature = OPCOMP;
                  etat = E_FIN;
                  avancer_car();
               } else {
                  printf("erreur lexical concernant COMP <\n");
                  exit(0);
               }
            } else {
               printf("erreur lexical concernant COMP <\n");
               exit(0);
            }
            break;

         case E_FIN:
            break;
      };
   };
}

/* --------------------------------------------------------------------- */

void ajouter_caractere(char *s, char c) {
   int l;

   l = strlen(s);
   s[l] = c;
   s[l + 1] = '\0';
};

/* --------------------------------------------------------------------- */

Nature_Caractere nature_caractere(char c) {
   if (fin_de_sequence_car(c))
      return C_FIN_SEQUENCE;
   if (est_chiffre(c))
      return CHIFFRE;
   if (est_symbole(c))
      return SYMBOLE;
   if (est_lettre(c))
      return LETTRE;
   return ERREUR_CAR;
}

/* --------------------------------------------------------------------- */

int est_separateur(char c) {
   return c == ' ' || c == '\t' || c == '\n';
}

/* --------------------------------------------------------------------- */

int est_chiffre(char c) {
   return c >= '0' && c <= '9';
}

/* --------------------------------------------------------------------- */

int est_lettre(char c) {
   return (c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z');
}

/* --------------------------------------------------------------------- */

int est_symbole(char c) {
   switch (c) {
      case '+':
      case '-':
      case '*':
      case '/':
      case '(':
      case ')':
      case ':':
      case ';':
      case '=':
      case '!':
      case '>':
      case '<':
         return 1;
      default:
         return 0;
   }
}

/* --------------------------------------------------------------------- */

char *Nature_vers_Chaine(Nature_Lexeme nature) {
   switch (nature) {
      case ENTIER:
         return "ENTIER";
      case PLUS:
         return "PLUS";
      case MOINS:
         return "MOINS";
      case MUL:
         return "MUL";
      case DIV:
         return "DIV";
      case PARO:
         return "PARO";
      case PARF:
         return "PARF";
      case FIN_SEQUENCE:
         return "FIN_SEQUENCE";
      case IDF:
         return "IDF";
      case AFF:
         return "AFF";
      case SEPAFF:
         return "SEPAFF";
      case LIRE:
         return "LIRE";
      case ECRIRE:
         return "ECRIRE";
      case OPCOMP:
         return "OPCOMP";
      case SI:
         return "SI";
      case SINON:
         return "SINON";
      case ALORS:
         return "ALORS";
      case FSI:
         return "FSI";
      case TANQUE:
         return "TANQUE";
      case FAIRE:
         return "FAIRE";
      case FAIT:
         return "FAIT";
      default:
         return "ERREUR";
   };
}

/* --------------------------------------------------------------------- */

void afficher(Lexeme l) {
   switch (l.nature) {
      case FIN_SEQUENCE:
         break;
      default:
         printf("(ligne %d, ", l.ligne);
         printf("colonne %d) : ", l.colonne);
         printf("[");
         printf("nature = %s", Nature_vers_Chaine(l.nature));
         printf(", chaine = %s, ", l.chaine);
         switch (l.nature) {
            case ENTIER:
               printf("valeur = %d", l.valeur);
            default:
               break;
         };
         printf("]");
   };
}

/* --------------------------------------------------------------------- */
