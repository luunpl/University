#include <stdio.h>

/*2.Programmation en langage C (7 pts)
Le but de cet exercice est d'appliquer différentes opérations de mise en forme d'un titre pour l'affcher à l'écran.
Il vous est demandé d'écrire vous-mêmes tous les traitements demandés; en particulier, il est interdit
pour cet exercice d'utiliser les fonctions de la bibliothèque string.h.*/

// 'A' - 'a' = 32
void min2maj(char chaine[]) {
    int i = 0;
    while (chaine[i] != '\0'){
        if (chaine[i] > 'a' && chaine[i] < 'z') i -= 32;
        i++;                                                                                                                        
    }
}                                                          

void encarde(char chaine[]){
    // Chercher le len du chaine
    int len = 0;
    while (chaine[len] != '\0')
        len++;
    // 1er ligne d'etoile
    for (int i = 0; i < len + 3; i++)
        printf("*");
    // Le contenu
    printf("\n* %s *\n", chaine);
    // 2e ligne
    for (int i = 0; i < len + 3; i++)
        printf("*");
    printf("\n");
}

int main() {
    char titre[80] = "Vive mon prof d'INF203!!";
    min2maj(titre);
    encarde(titre);
    return 0;

}