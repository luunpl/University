#include "client.h"
#include "fonction.h"
#include <stdio.h>
#include <ctype.h>
#include <stdbool.h>
#include <string.h>

#define ONE_MILLION 1000000

void repetition(char TXT[], int rep){
    int len = strlen(TXT);
    for (int i = 0; i < rep; i++) {
        strcpy(TXT + i * len, TXT);
    }
}
int main()
{
    char reponse[ONE_MILLION];
    char clef[ONE_MILLION];
    char TXT[ONE_MILLION];
    char TXT2[ONE_MILLION];

    // Affiche les échanges avec le serveur (false pour désactiver)
    show_messages(true);

    // Connexion au serveur AppoLab
    connexion("im2ag-appolab.u-ga.fr");

    // Remplacez <identifiant> et <mot de passe> ci dessous.
    envoyer("login 12214604 \"LUU\"");

    // Traduire le 1er message
    envoyer_recevoir("load OneMillion", reponse);
    BayOfPigs(reponse, TXT);
    printf("Réponse du serveur: %s", TXT);

    // Debut et envoyer 9999 copies
    envoyer_recevoir("aide", reponse);
    repetition(reponse, 9999);
    printf("%s", reponse);
    
    // Clef
    envoyer_recevoir("depart", clef);
    BayOfPigs(clef, TXT2);
    repetition(TXT2, 100);

    strcat(reponse, clef);
    envoyer_recevoir(reponse, reponse);    
    return 0;
}
