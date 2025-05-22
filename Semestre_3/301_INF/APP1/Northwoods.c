#include "client.h"
#include "fonction.h"
#include <stdio.h>
#include <ctype.h>
#include <stdbool.h>
#include <string.h>

int main()
{
    char reponse[MAXREP];

    // Affiche les échanges avec le serveur (false pour désactiver)
    show_messages(true);

    // Connexion au serveur AppoLab
    connexion("im2ag-appolab.u-ga.fr");

    // Remplacez <identifiant> et <mot de passe> ci dessous.
    envoyer("login 12214604 \"LUU\"");

    // Traduire le 1er message
    envoyer("load Northwoods");
    envoyer("depart");
    
    envoyer_recevoir("5402 2586 9910 4327", reponse);

    return 0;
}
