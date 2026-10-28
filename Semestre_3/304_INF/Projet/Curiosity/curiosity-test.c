#include <stdio.h>
#include <stdlib.h>

#include "robot.h"
#include "environnement.h"
#include "programme.h"
#include "interprete.h"
#include "type_pile.h"

#define LMAX 100 /* Longueur maximale d'une ligne */

void gestion_erreur_terrain(erreur_terrain e) {
  switch (e) {
  case OK:
    break;
  case ERREUR_FICHIER:
    printf("Erreur lecture du terrain : erreur d'ouverture du fichier\n");
    exit(1);
  case ERREUR_LECTURE_LARGEUR:
    printf("Erreur lecture du terrain : erreur de lecture de la largeur\n");
    exit(1);
  case ERREUR_LECTURE_HAUTEUR:
    printf("Erreur lecture du terrain : erreur de lecture de la hauteur\n");
    exit(1);
  case ERREUR_LARGEUR_INCORRECTE:
    printf("Erreur lecture du terrain : largeur incorrecte\n");
    exit(1);
  case ERREUR_HAUTEUR_INCORRECTE:
    printf("Erreur lecture du terrain : hauteur incorrecte\n");
    exit(1);
  case ERREUR_CARACTERE_INCORRECT:
    printf("Erreur lecture du terrain : caractère incorrect\n");
    exit(1);
  case ERREUR_LIGNE_TROP_LONGUE:
    printf("Erreur lecture du terrain : ligne trop longue\n");
    exit(1);
  case ERREUR_LIGNE_TROP_COURTE:
    printf("Erreur lecture du terrain : ligne trop courte\n");
    exit(1);
  case ERREUR_LIGNES_MANQUANTES:
    printf("Erreur lecture du terrain : lignes manquantes\n");
    exit(1);
  case ERREUR_POSITION_ROBOT_MANQUANTE:
    printf(
        "Erreur lecture du terrain : position initiale du robot manquante\n");
    exit(1);
  }
}

void affichage_position_programme(erreur_programme e) {
  int i;
  printf("Ligne %d, colonne %d :\n", e.num_ligne, e.num_colonne);
  printf("%s\n", e.ligne);
  /* Impression de e.num_colonne-1 espaces */
  for (i = 1; i < e.num_colonne; i++) {
    printf(" ");
  }
  /* Impression d'un curseur de position */
  printf("^\n");
}

void gestion_erreur_programme(erreur_programme e) {
  switch (e.type_err) {
  case OK_PROGRAMME:
    break;
  case ERREUR_FICHIER_PROGRAMME:
    printf("Erreur lecture du programme : erreur d'ouverture du fichier\n");
    exit(2);
  case ERREUR_BLOC_NON_FERME:
    printf("Erreur lecture du programme : bloc non fermé\n");
    exit(2);
  case ERREUR_FERMETURE_BLOC_EXCEDENTAIRE:
    printf("Erreur lecture du programme : fermeture de bloc excédentaire\n");
    affichage_position_programme(e);
    exit(2);
  case ERREUR_COMMANDE_INCORRECTE:
    printf("Erreur lecture du programme : commande incorrecte\n");
    affichage_position_programme(e);
    exit(2);
  }
}

int etat_attendu(Robot r, int ax, int ay, char ao) {
    int rx, ry;
    char ro;

    // Récupération des coordonnées du robot
    rx = abscisse(&r);
    ry = ordonnee(&r);

    // Récupération de l'orientation du robot
    switch (orient(&r)) {
        case Nord:  ro = 'N'; break;
        case Sud:   ro = 'S'; break;
        case Est:   ro = 'E'; break;
        case Ouest: ro = 'O'; break;
    }

    // Vérification de l'état attendu
    if (rx == ax && ry == ay && ro == ao) {
        printf("Ok.\n");
        return 0;
    } else {
        printf("Position attendue : (%d, %d), %c\n", ax, ay, ao);
        printf("Position obtenue : (%d, %d), %c\n", rx, ry, ro);
        printf("Test échoué.\n");
        return 1;
    }
}

int main(int argc, char **argv) {
    if (argc < 2) {
        printf("Usage: %s <fichier test>\n", argv[0]);
        return 1;
    }

    FILE *ftest = fopen(argv[1], "r");
    if (!ftest) {
        perror("Erreur d'ouverture du fichier");
        return 1;
    }

    char nom_fenvt[LMAX], nom_fprog[LMAX];
    Environnement envt;
    Programme prog;
    erreur_terrain errt;
    erreur_programme errp;
    int nbstepmax, ax, ay, nbstep;
    char cevent, ao;

    // Lecture des fichiers et paramètres
    fscanf(ftest, "%s\n", nom_fenvt);
    errt = initialise_environnement(&envt, nom_fenvt);
    gestion_erreur_terrain(errt);

    fscanf(ftest, "%s\n", nom_fprog);
    errp = lire_programme(&prog, nom_fprog);
    gestion_erreur_programme(errp);

    fscanf(ftest, "%d\n", &nbstepmax);
    fscanf(ftest, "%c\n", &cevent);

    if (cevent == 'N' || cevent == 'F') {
        fscanf(ftest, "%d %d\n", &ax, &ay);
        fscanf(ftest, " %c", &ao);
    }

    fclose(ftest);

    etat_inter etat;
    init_etat(&etat);
    resultat_inter res = OK_ROBOT;

    // Exécution du programme
    for (nbstep = 0; nbstep < nbstepmax && res == OK_ROBOT; nbstep++) {
        res = exec_pas(&prog, &envt, &etat);
    }

    // Gestion des résultats
    switch (res) {
        case OK_ROBOT:
            printf("Robot sur une case libre, programme non terminé\n");
            if (cevent == 'N') {
                return etat_attendu(envt.r, ax, ay, ao);
            } else {
                printf("Test échoué, état attendu = %c\n", cevent);
                return 1;
            }

        case SORTIE_ROBOT:
            printf("Le robot est sorti :-)\n");
            return (cevent == 'S') ? (printf("Ok.\n"), 0) : (printf("Test échoué, état attendu = %c\n", cevent), 1);

        case ARRET_ROBOT:
            printf("Robot sur une case libre, programme terminé :-/\n");
            return (cevent == 'F') ? etat_attendu(envt.r, ax, ay, ao) : (printf("Test échoué, état attendu = %c\n", cevent), 1);

        case PLOUF_ROBOT:
            printf("Le robot est tombé dans l’eau :-(\n");
            return (cevent == 'P') ? (printf("Ok.\n"), 0) : (printf("Test échoué, état attendu = %c\n", cevent), 1);

        case CRASH_ROBOT:
            printf("Le robot s’est écrasé sur un rocher X-(\n");
            return (cevent == 'O') ? (printf("Ok.\n"), 0) : (printf("Test échoué, état attendu = %c\n", cevent), 1);

        case ERREUR_PILE_VIDE:
            printf("ERREUR : pile vide\n");
            return 1;

        case ERREUR_ADRESSAGE:
            printf("ERREUR : erreur d’adressage\n");
            return 1;

        case ERREUR_DIVISION_PAR_ZERO:
            printf("ERREUR : division par 0\n");
            return 1;

        default:
            printf("ERREUR : état inconnu\n");
            return 1;
    }
}
