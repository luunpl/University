#include "generation_terrains.h"
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int nb_cases_occupees(Terrain *T)
{
  int occupee = 0;
  int x, y;
  for (x = 0; x < largeur(T); x++)
  {
    for (y = 0; y < hauteur(T); y++)
    {
      if (T->tab[x][y] != LIBRE)
        occupee++;
    }
  }
  return occupee;
}

// Test de generation aléatoire de terrains
// Le programme génère n terrains de largeur et hauteur fixes
// avec largeur et hauteur impaires et inférieures a dimension_max de terrain.h
// avec densité d'obstacle dObst
// autre que la case centrale soit occupee
// l'appel du programme se fait avec 5 arguments :
// generation_terrains N largeur hauteur dObstacle fichier_res
// la sortie se fait dans le fichier resultat

int main(int argc, char **argv)
{
  int N, i, l, h;
  float dObst, densite_obtenue, densite_moyenne = 0;
  int valid_terrains = 0;
  FILE *resFile;
  Terrain T;

  if (argc < 6)
  {
    printf(
        "Usage: %s <N> <largeur> <hauteur> <densite_obstacle> <fichier_res> \n",
        argv[0]);
    return 1;
  }

  N = strtol(argv[1], NULL, 10);
  l = strtol(argv[2], NULL, 10);
  h = strtol(argv[3], NULL, 10);
  dObst = strtof(argv[4], NULL);

  // test de l et h
  if (l > DIM_MAX || l % 2 == 0)
  {
    printf("Largeur incorrecte : doit être impaire et <= %d\n", DIM_MAX);
    return 1;
  }
  if (h > DIM_MAX || h % 2 == 0)
  {
    printf("Hauteur incorrecte : doit être impaire et <= %d\n", DIM_MAX);
    return 1;
  }
  if ((dObst > 1) || (dObst < 0))
  {
    printf("Densité incorrecte : doit être comprise entre 0 et 1\n");
    return 1;
  }

  // Ouverture du fichier résultat
  resFile = fopen(argv[5], "w");
  // Écriture du nombre de terrains
  fprintf(resFile, "%d\n", N);

  // Initialisation de la fonction random
  srand(time(NULL));

  for (i = 0; i < N; i++)
  {
    // Génération aléatoire du terrain
    generation_aleatoire(&T, l, h, dObst);

    // Calcul de la densité obtenue
    densite_obtenue = (float)nb_cases_occupees(&T) / (l * h);
    densite_moyenne += densite_obtenue;

    // Vérification si le terrain est valide
    if (existe_chemin_vers_sortie(&T))
    {
      valid_terrains++;
    }

    // Écriture du terrain généré dans le fichier resFile
    for (int x = 0; x < l; x++)
    {
      for (int y = 0; y < h; y++)
      {
        if (T.tab[x][y] == LIBRE)
        {
          if (x == l / 2 && y == h / 2)
            fprintf(resFile, "C");
          else
            fprintf(resFile, ".");
        }
        else if (T.tab[x][y] == ROCHER)
        {
          fprintf(resFile, "#");
        }
        else if (T.tab[x][y] == EAU)
        {
          fprintf(resFile, "~");
        }
        else
        {
          fprintf(resFile, "%c", T.tab[x][y]);
        }
      }
      fprintf(resFile, "\n");
    }
    fprintf(resFile, "Densité obtenue: %.2f\n\n", densite_obtenue);

    // Affichage des statistiques
    printf("Terrain %d: %d cases occupées, Densité obtenue: %.2f\n", i + 1, nb_cases_occupees(&T), densite_obtenue);
  }

  // Calcul de la densité moyenne
  densite_moyenne /= N;

  // Écriture des statistiques finales
  printf("Densité moyenne: %.2f\n", densite_moyenne);
  printf("Densité donneé: %.2f\n", dObst);
  printf("Pourcentage de terrains valides: %.2f%%\n", (float)valid_terrains / N * 100);

  // Fermeture des fichiers
  fclose(resFile);
  return 0;
}