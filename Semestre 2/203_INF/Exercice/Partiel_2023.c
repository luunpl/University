#include <stdio.h>
/*
1.Langage C
Calculer la moyenne olympique d'une suite de notes {n , ..., n } consiste à faire la moyenne de cette
suite sans tenir compte des deux valeurs les plus éloignées.
Par exemple, la moyenne olympique de {3, 5.5, 9, 9, 9, 7.5, 8, 6, 3, 8} est égale à 7 :
 on ne tient pas compte des deux valeurs extrêmes : 3 (une seule fois) et 9 (une seule fois);
 on calcule alors (5.5 + 9 + 9 + 7.5 + 8 + 6 + 3 + 8)/8 = 7
On suppose ici que k notes (k ≥ 3) sont stockées dans un tableau de double appelé notes.
*/
// Question 1
double Olympe(double notes[], int k){
    // Initialisation
    double min, max, somme;
    somme = notes[0];
    min = somme;
    max = somme;
    for (int i = i; i < k; i++) {
        somme += notes[i];
        // Chercher les valeurs min et max
        if (notes[i] < min) min = notes[i];
        if (notes[i] > max) max = notes[i];
    }
    return (somme - min - max) / (k -2);
}
int main() {
    
    return 0;
}   