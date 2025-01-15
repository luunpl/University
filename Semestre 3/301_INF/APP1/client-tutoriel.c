#include "client.h"
#include <stdio.h>
#include <ctype.h>
#include <stdbool.h>
#include <string.h>

int main() {
    // Affiche les échanges avec le serveur (false pour désactiver)
    show_messages(true);

    // Connexion au serveur AppoLab
    connexion("im2ag-appolab.u-ga.fr");

    // Remplacez <identifiant> et <mot de passe> ci dessous.
    envoyer("login 12214604 \"LUU\"");
    envoyer("load tutoriel");
    envoyer("start");
    envoyer("oui");
    envoyer("4");
    envoyer("blanc");
    envoyer("Pincemoi");
    envoyer("tutoriel");
    
    return 0;
}
