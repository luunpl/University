#include "client.h"
#include <stdio.h>
#include <ctype.h>
#include <stdbool.h>
#include <string.h>

#include <stdio.h>
#include <ctype.h>

// Fonction pour convertir un message en majuscules
void convertirEnMajuscules(char *message)
{
    int i = 0;

    // Parcourir chaque caractère du message
    while (message[i] != '\0')
    {
        // Convertir le caractère en majuscule
        message[i] = toupper(message[i]);
        i++;
    }
}

int main()
{
    char reponse[MAXREP];

    // Affiche les échanges avec le serveur (false pour désactiver)
    show_messages(true);

    // Connexion au serveur AppoLab
    connexion("im2ag-appolab.u-ga.fr");

    // Remplacez <identifiant> et <mot de passe> ci dessous.
    envoyer("login 12214604 \"LUU\"");
    envoyer("load tutorielFORT");
    envoyer_recevoir("start", reponse);

    envoyer_recevoir("OK", reponse);

    envoyer_recevoir("OUI", reponse);
    convertirEnMajuscules(reponse);

    envoyer_recevoir(reponse, reponse);
    convertirEnMajuscules(reponse);

    envoyer_recevoir(reponse, reponse);
    convertirEnMajuscules(reponse);

    envoyer_recevoir(reponse, reponse);
    convertirEnMajuscules(reponse);

    envoyer_recevoir(reponse, reponse);
    convertirEnMajuscules(reponse);

    envoyer_recevoir(reponse, reponse);
    convertirEnMajuscules(reponse);

    envoyer_recevoir(reponse, reponse);
    convertirEnMajuscules(reponse);
    return 0;
}
