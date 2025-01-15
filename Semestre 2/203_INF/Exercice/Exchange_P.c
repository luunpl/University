#include <stdio.h>

void echange(int *a, int *b){
    int tmp = *a;
    *a = *b;
    *b = tmp;
}

int main(){
    int qd = 42;
    int ue = 203;
    echange(&qd, &ue);
    printf("En %d on parle de %d\n", ue, qd);
    printf("qd est %d\n", qd);
    printf("ue est %d\n", ue);
    return 0;
}

