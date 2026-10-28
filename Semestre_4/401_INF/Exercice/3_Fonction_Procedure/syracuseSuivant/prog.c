#include <stdio.h>

int syracuseSuivant(int);

int main() {
int x,n;

  printf("Votre nombre ? \n");
  scanf("%d",&x);
  for(n=0;x!=1;n++) {
    x=syracuseSuivant(x);}
  printf("Resultat : %d\n",n);
  return 0;
}