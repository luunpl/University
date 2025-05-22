#include <stdio.h>

int main(int argc, char *argv[])
{
    if (argc != 3)
    {
        printf("Erreur, vous devez fournir 2 arguments\n");
        return 1;
    }
    printf("Argument 1 : %s\n", argv[1]);
    printf("Argument 2 : %s\n", argv[2]);
    return 0;
}
