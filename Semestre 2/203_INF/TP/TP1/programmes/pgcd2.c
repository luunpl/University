#include <stdio.h>

int main(void)
{
  int a,b,x,y;

  printf("Ce programme calcule le pgcd de 2 nombres entiers\n");
  printf("Tapez le premier nombre au clavier suivi de la touche Entree : ");
  scanf("%d",&a);
  printf("Tapez le deuxieme nombre suivi de la touche Entree : ");
  scanf("%d",&b);
  x = a;
  y = b;
  while (x != y)
    if (x > y)
      x = x -y;
    else
      y = y -x;
  printf("Le pgcd de %d et %d est %d\n",a,b,x);
  return 0;
}

  
