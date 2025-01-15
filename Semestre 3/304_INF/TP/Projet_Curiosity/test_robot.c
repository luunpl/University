#include "robot.h"
#include <stdio.h>

#define TAILLE_TERRAIN 10

/* Affiche une orientation sur la sortie standard */
void afficher_orientation(Orientation o) {
  switch (o) {
  case Nord:
    printf("Nord\n");
    break;
  case Est:
    printf("Est\n");
    break;
  case Sud:
    printf("Sud\n");
    break;
  case Ouest:
    printf("Ouest\n");
    break;
  }
}

void afficher_infos_robot(Robot *r) {
  int x, y;
  int x1, y1;

  // Récupérer la position du robot
  position(r, &x, &y);
  // Récupérer la case devant le robot
  position_devant(r, &x1, &y1);
  // Afficher la position
  printf("Position : (%d, %d) - Orientation : ", x, y);
  afficher_orientation(orient(r));
  printf("\n");
}

int main(int argc, char **argv) {
  Robot r;
  char c;

  init_robot(&r, 0, 0, Est);

  afficher_infos_robot(&r);

  printf("Entrer une action ([a]vancer, [g]auche, [d]roite, [f]in : ");
  scanf(" %c", &c);
  while (c != 'f') {

    /* À compléter */

    printf("Entrer une action ([a]vancer, [g]auche, [d]roite, [f]in : ");
    scanf(" %c", &c);
  }
}
