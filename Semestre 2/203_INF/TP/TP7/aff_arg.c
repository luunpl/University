#include<stdio.h>

int main (int argc, char *argv[]) {
  int i ;

  printf("\nargc : %d\n\n",argc);

  for (i=0 ; i<argc ; i++)
    printf("l’argument numero %d est %s\n",i, argv[i]) ;

  printf("\n");
  return 0;
}
