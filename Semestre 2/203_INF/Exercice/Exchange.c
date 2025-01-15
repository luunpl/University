#include <stdio.h>

// Exchange value between two values a,b
void exchange(int a, int b){
    int tmp = a;
    a = b;
    b = tmp;
}
// Le cas du tableau
void exchangeT (int Tab[], int a, int b){
    int tmp;
    tmp = Tab[a];
    Tab[a] = Tab[b];
    Tab[b] = tmp;
}
// Find max 
int max(int a, int b){
    if (a < b){
        return b;
    }else {
        return a;
    }
}

int main(){
    int qd = 42;
    int ue = 203;
    exchange(qd, ue);
    // Tableau
    int Tab[] = {42, 203};
    exchangeT(Tab, 0, 1);
    printf("Table - En %d on parle de %d\n", Tab[0], Tab[1]); 
    // Cas normal
    printf("En %d on parle de %d\n", ue, qd);
    return 0;
}