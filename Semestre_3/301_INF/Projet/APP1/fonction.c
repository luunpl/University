#include "fonction.h"
#include <stdio.h>
#include <string.h>

// ProjetX
void Cesar(char message[], int decalage)
{
    int i = 0;
    char lettre;

    decalage = decalage % 26; // S'assurer que le décalage est dans l'intervalle [-25, 25]

    while (message[i] != '\0')
    {
        lettre = message[i];

        // Cas majuscule
        if (lettre >= 'A' && lettre <= 'Z')
        {
            lettre = (lettre - 'A' + decalage + 26) % 26 + 'A'; // Decaler
        }
        // Cas minuscule
        else if (lettre >= 'a' && lettre <= 'z')
        {
            lettre = (lettre - 'a' + decalage + 26) % 26 + 'a'; // Appliquer le décalage
        }

        message[i] = lettre; // Mise à jour de la lettre dans le message
        i++;
    }
}

// crypteMove
void crypteMove(char TXT[], char ENC[])
{
    ENC[0] = '\0';
    int TXTlen = strlen(TXT);

    while (TXTlen > 0)
    {
        // Prendre 1er char et mettre a la fin de ENC
        char C = TXT[0];
        int ENClen = strlen(ENC);
        ENC[ENClen] = C;
        ENC[ENClen + 1] = '\0';

        // Nombre modulo de C
        int X = C % 8;

        // Supprimer C
        memmove(TXT, TXT + 1, TXTlen - 1);
        TXT[TXTlen - 1] = '\0';

        // Reduire la longueur du TXTlen
        TXTlen--;

        // Placer la reste vers la fin
        if (X > 0 && X < TXTlen)
        {
            char temp[100];        // Tableau temporaire
            strncpy(temp, TXT, X); // Copier les X premiers char
            temp[X] = '\0';        // Ajouter le caractère NULL à la fin

            // Placer
            memmove(TXT, TXT + X, TXTlen - X + 1); // +1 pour \0

            // Concatenation
            strcat(TXT, temp);
        }
    }
}

// BayOfPigs
void BayOfPigs(char ENC[], char TXT[])
{
    int ENC_len = strlen(ENC);
    int TXT_len = 0;

    // Traiter chaque caractère de ENC
    for (int i = ENC_len - 1; i >= 0; i--)
    {
        char C = ENC[i];
        int X = C % 8;

        // Déplacer les X derniers caractères de TXT au début
        if (X < TXT_len)
        {
            // Créer un buffer pour stocker les X derniers caractères
            char buffer[TXT_len];
            strncpy(buffer, TXT + (TXT_len - X), X);
            strncpy(TXT + X, TXT, TXT_len - X);
            strncpy(TXT, buffer, X);
        }

        // Déplacer C au début de TXT
        memmove(TXT + 1, TXT, TXT_len); // Décaler TXT d'un caractère vers la droite
        TXT[0] = C;                     // Placer C au début
        TXT_len++;                      // Augmenter la longueur de TXT
        TXT[TXT_len] = '\0';            // Ajouter le terminateur de chaîne
    }
}

// crypteSeq
// Fonction pour vérifier si le caractère est dans la séquence
int estDansSeq(char SEQ[], char caractere)
{
    int taille = strlen(SEQ);
    // Parcours du tableau et retourne 0 si le caractère est trouvé, 1 sinon
    for (int i = 0; i < taille; i++)
    {
        if (SEQ[i] == caractere)
            return 0;
    }
    return 1;
}


// Fonction pour trouver la position du caractère dans la séquence
int positionDansSEQ(char SEQ[], char caractere)
{
    int taille = strlen(SEQ);
    // Parcours du tableau et retourne la position du caractère s'il est trouvé
    for (int i = 0; i < taille; i++)
    {
        if (SEQ[i] == caractere)
            return i;
    }
    return -1; // Retourne -1 si le caractère n'est pas trouvé
}

// Fonction principale pour crypter le texte
void crypteSeq(char TXT[], char SEQ[], char ENC[])
{
    // Initialisation
    int TXT_len = strlen(TXT);
    int SEQ_len = 0;
    int ENC_len = 0;

    // Maintenir une séquence de tous les caractères déjà rencontrés, dans l'ordre
    for (int i = 0; i < TXT_len; i++)
    { // Parcourir chaque caractère du texte
        char C = TXT[i];

        if (estDansSeq(SEQ, C) == 1)
        { // Si le caractère n'est pas dans SEQ
            // Ajouter C à la fin de SEQ
            SEQ[SEQ_len++] = C;
            SEQ[SEQ_len] = '\0'; // Ajouter le caractère NULL à la fin
            ENC[ENC_len++] = C;  // Ajouter C à l'output
        }
        else
        {
            // Trouver la position de C dans SEQ pour en déduire D
            int position = positionDansSEQ(SEQ, C);
            char D;

            if (position == 0)
            {
                D = SEQ[SEQ_len - 1]; // Si C est le premier, D est le dernier
            }
            else
            {
                D = SEQ[position - 1]; // Sinon, D est le caractère précédent
            }

            ENC[ENC_len++] = D; // Remplacer C par D

            // Déplacer C à la fin de la séquence
            for (int j = position; j < SEQ_len - 1; j++)
            {
                SEQ[j] = SEQ[j + 1];
            }
            SEQ[SEQ_len - 1] = C; // Mettre C à la fin de SEQ
        }
    }
    ENC[ENC_len] = '\0'; // Ajouter le caractère NULL à la fin de l'output
}



