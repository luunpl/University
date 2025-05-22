#include "client.h"
#include "fonction.h"
#include <stdio.h>

void genererMessages(char baseMessage[])
{
    char message[MAXREP]; // Tableau pour stocker chaque message
    int decalage;

    for (decalage = -15; decalage <= 15; decalage++)
    {
        // Copier le message de base dans le tableau temporaire
        snprintf(message, sizeof(message), "%s", baseMessage);

        // Appeler la fonction César
        Cesar(message, decalage);

        // Afficher le message chiffré
        printf("Message avec décalage %d : %s\n", decalage, message);
    }
}

// Autre version de Cesar
int checkShift(char original, char shifted)
{
    
    if ((original >= 'A' && original <= 'Z') || (original >= 'a' && original <= 'z'))
    {
        int shift;

       
        if (original >= 'A' && original <= 'Z')
        {
            shift = (shifted - original + 26) % 26;
        }

        else
        {
            shift = (shifted - original + 26) % 26;
        }

        return shift; 
    }

    return -1; }

int main()
{
    char reponse[MAXREP];
    char rep[MAXREP] = "hasta la revolucion";
    char original = 'C'; // Char debut de message

    // char ENC[MAXREP];

    // Affiche les échanges avec le serveur (false pour désactiver)
    show_messages(true);

    // Connexion au serveur AppoLab
    connexion("im2ag-appolab.u-ga.fr");

    // Remplacez <identifiant> et <mot de passe> ci dessous.
    envoyer("login 12214604 \"LUU\"");
    envoyer("load planB");

    envoyer_recevoir("aide", reponse);
    genererMessages(reponse);

    char shifted = reponse[0]; 

    int shiftCount = checkShift(original, shifted);
    Cesar(rep, - shiftCount);

    envoyer("start");
    envoyer_recevoir(rep, reponse);

    Cesar(reponse, -shiftCount);
    printf("Réponse du serveur: %s", reponse);

    return 0;
}
