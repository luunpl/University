#include "stdio.h"

static long int Somme (long int a1, long int a2, long int a3, long int a4, long int a5,
                       long int a6, long int a7, long int a8, long int a9, long int a10) {
long int x1,x2,x3,x4,x5,x6,x7,x8,x9,x10;
long int y;

    x1=a1+1; x2=a2+1; x3=a3+1; x4=a4+1; x5=a5+1;
    x6=a6+1; x7=a7+1; x8=a8+1; x9=a9+1; x10=a10+1;
    y = x1+x2+x3+x4+x5+x6+x7+x8+x9+x10;
    return (y);
}

int main () {
long int z;
    
    z = Somme (1, 2, 3, 4, 5, 6, 7, 8, 9, 10);
    printf("La somme des entiers de 1 a 10 plus 10 vaut %d\n", z);
}
