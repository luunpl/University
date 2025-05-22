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
    char TXT[MAXREP];
    char rep[] = "Patria o muerte";

    // Affiche les échanges avec le serveur (false pour désactiver)
    show_messages(true);

    // Connexion au serveur AppoLab
    connexion("im2ag-appolab.u-ga.fr");

    // Remplacez <identifiant> et <mot de passe> ci dessous.
    envoyer("login 12214604 \"LUU\"");
    envoyer("load BayOfPigs");

    // Stocker le message depart
    envoyer_recevoir("depart", reponse);

    // Convertir et envoyer
    BayOfPigs(reponse, ENC);
    crypteMove(rep, TXT);

    envoyer_recevoir(TXT, reponse); // Envoyer le message encrypte avec crypteMove au server
    BayOfPigs(reponse, ENC);        // Lire le dernier message
    printf("Réponse du serveur: %s", ENC);

    return 0;
}
