#include <stdio.h>

int main(){
    // 1er exemple
    int x;
    printf("Saisissez un entier : ");
    scanf("%d", &x);
    printf("Entier saisi : %d\n", x);
    // 2e exemple
    int nb;
    int Tab[10];
    scanf(" %d", &nb);
    for (int i = 0; i < nb; i++){
        scanf(" %d", &Tab[i]);
        printf("J'ai lu %d\n", Tab[i]);
    }
    return 0;
}