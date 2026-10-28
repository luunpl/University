#include "client.h"
#include "fonction.h"
#include <stdio.h>
#include <ctype.h>
#include <stdbool.h>
#include <string.h>

int main()
{
    char reponse[MAXREP];
    char TXT[MAXREP];
    char TXT2[MAXREP];
    //char TXT3[MAXREP];
    char SEQ[MAXREP];
    char ENC[MAXREP];

    // Affiche les échanges avec le serveur (false pour désactiver)
    show_messages(true);

    // Connexion au serveur AppoLab
    connexion("im2ag-appolab.u-ga.fr");

    // Remplacez <identifiant> et <mot de passe> ci dessous.
    envoyer("login 12214604 \"LUU\"");

    // Traduire le 1er message
    envoyer_recevoir("load crypteSeq", reponse);
    BayOfPigs(reponse, TXT);
    printf("Réponse du serveur: %s", TXT);

    // Traduire le 2e message
    envoyer_recevoir("depart", reponse);
    BayOfPigs(reponse, TXT2);
    printf("Réponse du serveur: %s", TXT2);

    // Traduire le 3e message et envoyer au serveur
    crypteSeq(TXT2, SEQ, ENC); // message a traduire est stocke au TXT2 au lieu de reponse
    envoyer_recevoir(ENC, reponse);    
    // Traduire le dernier message afin de trouver le mot de pass pour Northwoods
    
    printf("Réponse du serveur: %s", reponse);

    return 0;
}
