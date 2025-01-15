#include "generation_terrains.h"
#include "environnement.h"
#include "interprete.h"
#include "programme.h"
#include "observateur.h"

#include <stdio.h>
#include <stdlib.h>
#include <time.h>

void gestion_erreur_terrain(erreur_terrain e)
{
    switch (e)
    {
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
        printf("Erreur lecture du terrain : position initiale du robot manquante\n");
        exit(1);
    }
}

void gestion_erreur_programme(erreur_programme e)
{
    switch (e.type_err)
    {
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
        exit(2);
    case ERREUR_COMMANDE_INCORRECTE:
        printf("Erreur lecture du programme : commande incorrecte\n");
        exit(2);
    }
}

int main(int argc, char **argv)
{
    Environnement envt;
    Programme prog;
    etat_inter etat;
    resultat_inter res;
    erreur_terrain errt;
    erreur_programme errp;
    Terrain T;

    // Verification nombre d'arguments
    if (argc < 9)
    {
        printf("Usage: %s <fichier_programme> <N> <L> <H> <d> <graine> <nb_step_max> <fichier_res>\n", argv[0]);
        return 1;
    }

    // Recuperation des arguments
    char *fichier_programme = argv[1];
    int N = strtol(argv[2], NULL, 10);
    int L = strtol(argv[3], NULL, 10);
    int H = strtol(argv[4], NULL, 10);
    float d = strtof(argv[5], NULL);
    int graine = strtol(argv[6], NULL, 10);
    int nb_step_max = strtol(argv[7], NULL, 10);
    FILE *fichier_res;

    // Verification des arguments
    if (L > DIM_MAX || L % 2 == 0)
    {
        printf("Largeur incorrecte : doit être impaire et <= %d\n", DIM_MAX);
        return 1;
    }
    if (H > DIM_MAX || H % 2 == 0)
    {
        printf("Hauteur incorrecte : doit être impaire et <= %d\n", DIM_MAX);
        return 1;
    }
    if (d < 0 || d > 1)
    {
        printf("Densité incorrecte : doit être comprise entre 0 et 1\n");
        return 1;
    }

    // Ouverture du fichier résultat
    fichier_res = fopen(argv[8], "w");
    if (fichier_res == NULL)
    {
        perror("Erreur d'ouverture du fichier résultat");
        return 1;
    }

    // Ecriture du nombre de terrains (1er ligne)
    fprintf(fichier_res, "%d\n", N);

    // Initialisation de la fonction random avec la graine
    srand(graine);

    // Statistiques
    int sorties = 0, bloques = 0, obstacles = 0;
    int total_steps = 0, terrains_testes = 0;

    // Boucle principale
    for (int i = 0; i < N; i++)
    {
        // Génération aléatoire du terrain
        generation_aleatoire(&T, L, H, d);
        // Ecriture du terrain dans un fichier temporaire
        FILE *fichier_terrain = fopen("terrain_temp.txt", "w");
        ecrire_terrain(fichier_terrain, &T, L / 2, H / 2);
        fclose(fichier_terrain);
        
        // Curiosity.c
        errt = initialise_environnement(&envt, "terrain_temp.txt");
        gestion_erreur_terrain(errt);

        errp = lire_programme(&prog, fichier_programme);
        gestion_erreur_programme(errp);

        init_etat(&etat);
        res = OK_ROBOT;
        int nbstep = 0;
        do
        {
            res = exec_pas(&prog, &envt, &etat);
            nbstep += 1;
        } while (res == OK_ROBOT && nb_step_max >= nbstep);

        int result;
        switch (res)
        {
        case SORTIE_ROBOT:
            result = nbstep;
            sorties++;
            total_steps += nbstep;
            break;
        case ARRET_ROBOT:
            result = -1;
            bloques++;
            break;
        case PLOUF_ROBOT:
            result = -2;
            obstacles++;
            break;
        case CRASH_ROBOT:
            result = -3;
            obstacles++;
            break;
        default:
            result = -1;
            bloques++;
            break;
        }

        fprintf(fichier_res, "%d\n", result);
        terrains_testes++;
    }

    fclose(fichier_res);

    // Affichage des statistiques
    printf("Nombre de terrains testés: %d\n", terrains_testes);
    printf("Nombre de sorties: %d (%.2f%%)\n", sorties, (float)sorties / terrains_testes * 100);
    printf("Nombre de terrains bloqués: %d (%.2f%%)\n", bloques, (float)bloques / terrains_testes * 100);
    printf("Nombre de collisions avec obstacles: %d (%.2f%%)\n", obstacles, (float)obstacles / terrains_testes * 100);

    if (sorties > 0)
    {
        printf("Nombre moyen de pas pour les sorties: %.2f\n", (float)total_steps / sorties);
    }

    // Resultat de l'observateur
    int resultat_observateur(Environnement * envt);
    if (resultat_observateur(&envt)){
        printf("Observateur : Propriete valide\n");
    } else {
        printf("Observateur : Propriete fausse\n");
    }
    return 0;
}