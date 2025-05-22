#include "client.h"
#include "fonction.h"
#include <stdio.h>
#include <ctype.h>
#include <stdbool.h>
#include <string.h>

int main()
{
    char reponse[MAXREP];
    char ENC[MAXREP];

    // Affiche les échanges avec le serveur (false pour désactiver)
    show_messages(true);

    // Connexion au serveur AppoLab
    connexion("im2ag-appolab.u-ga.fr");

    // Remplacez <identifiant> et <mot de passe> ci dessous.
    envoyer("login 12214604 \"LUU\"");
    envoyer("load crypteMove");

    // Stocker le message aide
    envoyer_recevoir("aide", reponse);

    envoyer("depart");

    // Convertir et envoyer
    crypteMove(reponse, ENC);
    envoyer_recevoir(ENC, reponse);
    printf("Réponse du serveur: %s", reponse);

    return 0;
}
