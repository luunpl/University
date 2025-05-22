#include <stdio.h>

typedef struct {
    char pseudo[20];
    int nb_billes;
} joueur;

joueur atchoum = { "Atchoum", 42 };
joueur dormeur = { "Dormeur", 25 };
joueur grincheux = { "Grincheux", 3 };
joueur joyeux = { "Joyeux", 100 };
joueur prof = { "Prof", 2 };
joueur simplet = { "Simplet", 0 };
joueur timide = { "Timide", 12 };

void afficher_joueur_V1(joueur j) {
    printf("%s a %d billes\n", j.pseudo, j.nb_billes);
}

int main() {
    afficher_joueur_V1(atchoum);
    return 0;
}
