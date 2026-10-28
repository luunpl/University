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
    envoyer("load projetX");

    // Prendre 1er message
    envoyer_recevoir("aide", reponse);
    Cesar(reponse, -5);
    printf("Réponse du serveur: %s", reponse);

    // Transmettre au server la reponse
    envoyer("start");
    envoyer_recevoir("veni vidi vici", reponse);

    return 0;
}
