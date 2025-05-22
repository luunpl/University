#include <stdio.h>

int main(void)
{
    int a,b,x,y;

    a = 27;
    b = 9;
    x = a;
    y = b;

    while (x != y)
    {
        if (x >y)
          x = x -y;
        else
          y = y -x;
    }
    printf("Le pgcd de %d et %d est %d\n",a,b,x);
    return 0;
}
