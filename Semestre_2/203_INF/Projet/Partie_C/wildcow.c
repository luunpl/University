#include <stdio.h>
#include <unistd.h>

// Reimplementer les 2 fonctions donnees par l'enonce
void update()
{
    printf("\033[H\033[J"); // update() va mettre a jour le terminal en effacant l'ecran et cree un autre.
}

void gotoxy(int x, int y)
{
    printf("\033[%d;%dH", x, y); // Deplacer le pointeur vers position x,y. Alors, on peut controller la position suivante
                                 // de ce que l'ecran affiche.   
}

void affiche_vache() // On reprend la version plus simple du newcow.c
{
    printf(
"        ^--^\n\
        (00)\\-------\n\
        (__)\\       )\\/\\\n\
            ||-----w |\n\
            ||     || \n"
    );
}

int main() {
    for(int i = 0; i < 20; i++){
        affiche_vache();
        update();
        gotoxy(i, 0);       // La vache va bouger vers le bas
        sleep(1);
    }
    return 0;
}
