#include <stdio.h>

int main()
{
    int t[10];
    for (int i = 0; i < 10; i++)
    {
        t[i] = 1;
        for (int j = i - 1; j > 0; j--)
            t[j] = t[j] + t[j - 1];
        for (int j = 0; j <= i; j++)
            printf(" %d", t[j]);
        printf("\n");
    }
    return 0;
}
