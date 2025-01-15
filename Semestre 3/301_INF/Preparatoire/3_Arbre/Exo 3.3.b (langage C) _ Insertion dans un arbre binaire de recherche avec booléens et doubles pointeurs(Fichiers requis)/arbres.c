#include <stdlib.h>
#include <stdio.h>
#include <assert.h>
#include "arbres.h"

/* Bibliothèque pour les arbres binaires d'entiers */


void inf301_racine(int t[],int d,int f,int *r) {
    int i,n;
    n=f-d+1;
    (*r)=(d+f)/2;
    for(i=d;i<=f;i++) {
        if (t[i]%n==0) {
            (*r)=i;
            break;
        }
    }
    return;
}


void inf301_remplir(arbre *a,int t[],int d,int f) {
    int i;
    if (d>f) {
        (*a)=NULL;
    }
    else if (d==f) {
        (*a)=(arbre)malloc(sizeof(noeud));
        (*a)->valeur=t[d];
        (*a)->gauche=NULL;
        (*a)->droit=NULL;
    }
    else {
        inf301_racine(t,d,f,&i);
        (*a)=(arbre)malloc(sizeof(noeud));
        (*a)->valeur=t[i];
        (*a)->gauche=NULL;
        (*a)->droit=NULL;
        inf301_remplir(&((*a)->gauche),t,d,i-1);
        inf301_remplir(&((*a)->droit),t,i+1,f);
    }
    return;
}

/* nombre maximal de valeurs dans l'arbre */
#define MAXVAL 100

void initialiser(arbre *a) {
    int n;
    int i;
    int tmp[MAXVAL];

    printf("Donner une suite d'entiers positifs.\n\n");
    printf("Donner un entier (-1 pour finir)\n");
    scanf("%d",&n);
    for(i=0;(n!=-1);i++) {
        assert (i<MAXVAL);
        tmp[i]=n;
        printf("Donner un entier (-1 pour finir)\n");
        scanf("%d",&n);
    }
    inf301_remplir(a,tmp,0,i-1);
    return;
}

void afficherParenthese(arbre a) {
    if (a==NULL) { return; }
    if (a->gauche!=NULL) {
        printf("(");
        afficherParenthese(a->gauche);
        printf(")");
    }
    printf(" %d ",a->valeur);
    if (a->droit!=NULL) {
        printf("(");
        afficherParenthese(a->droit);
        printf(")");
    }
}

void indent(int n) {
    int i;
    for(i=0;i<n;i++) {
        printf("   ");
    }
    return;
}

void afficher2D(arbre a,int d) {
    if (a==NULL) { return; }

    afficher2D(a->droit,d+1);

    if (a->droit!=NULL) {
        indent(d+1);
        printf("/\n");
    }
    indent(d);
    printf(" %d ",a->valeur);
    printf("\n");
    if (a->gauche!=NULL) {
        indent(d+1);
        printf("\\\n");
    }

    afficher2D(a->gauche,d+1);
}

void afficher(arbre a) {
    if (a==NULL) { return; }
    afficher(a->gauche);
    printf(" %d ",a->valeur);
    afficher(a->droit);
}


/* Insertion dans un arbre binaire de recherche.
 * Cette fois, la valeur de retour est utilisé pour signifier si
 * l'insertion a pu se faire (valeur : Vrai) ou si la valeur est déjà présente 
 * ou dans l'arbre (valeur : Faux).
 * Il va donc falloir trouver un autre moyen pour que les modifications
 * dans l'arbre ne soient pas perdues.
 * Note : il est possible de le faire en un seul parcours d'arbre et sans
 * fonction auxiliaire, notamment avec l'utiltisation de doubles pointeurs sur
 * les nœuds (donc des pointeurs sur des "arbres" (ou sous-arbres...)).
 * */

bool inserer_abr(arbre *a_p, int n) {
    /* à compléter */
    return false;
}

