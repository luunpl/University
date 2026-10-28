#ifndef __CLIENT_H__
#define __CLIENT_H__
#include <stdio.h>
#include <stdbool.h>

/*
 * Pour modifier les couleurs d'affichage (certaines peuvent être difficile 
 * à lire selon les terminaux).
 * Couleurs possibles:
 * RED     - rouge
 * GRN     - vert
 * YEL     - jaune
 * BLU     - bleu foncé
 * BLUBOLD - bleu clair
 * MAG     - magenta
 * CYN     - cyan
 * WHT     - blanc
 */
#define COL_ENVOI       GRN  /* couleur des messages envoyés */
#define COL_RECU        MAG  /* couleur des messages reçus   */
#define COL_ATTENTION   RED  /* couleur des messages importants */

#define RED   "\x1B[31m"
#define GRN   "\x1B[32m"
#define YEL   "\x1B[33m"
#define BLU   "\x1B[34m"
#define BLUBOLD   "\x1B[34;1m"
#define MAG   "\x1B[35m"
#define CYN   "\x1B[36m"
#define WHT   "\x1B[37m"
#define RESET "\x1B[0m"



#define MAXREP 100000 /* taille maximale d'une réponse du serveur */

#define SOCK_TIMEOUT 60 /* send/recv timeout (secs) vers/depuis le serveur (0 pour désactiver) */

/*
 * Permet l'ouverture d'une connection avec le serveur
 * Les paramètres pour accéder au bon serveur sont à donner en argument:
 * nom du serveur.
 * si l'argument est NULL, une valeur par défaut est utilisée.
 * Renvoie une valeur nulle (faux) en cas d'échec
 */
int connexion(char*);

/*
 * Permet la fermeture de la connection avec le serveur donné en argument
 */
void deconnexion();

/*
 * Permet d'activer (flag == true) ou non (flag == false) le mode debug
 */
void show_messages(bool flag);

/*
 * Permet d'attendre que l'utilisateur appuie sur entrée
 */
void attendre();

/*
 * Demande à l'utilisateur un message qui sera stocké dans la chaine passée en 
 * argument. Redemande un message tant qu'il est vide.
 */
void lire_clavier(char *buffer);

/*
 * Permet d'envoyer un message au serveur sans stocker la réponse.
 */
void envoyer(char *message);

/*
 * Permet d'envoyer un message au serveur et de recevoir la réponse.
 * `reponse` doit pointer vers une zone alloué et disposant de suffisamment de 
 * place pour stocker la réponse du serveur.
 * Renvoie le nombre d'octets de la réponse.
 */
int envoyer_recevoir(char *message, char *reponse);


/*
 * Pour de l'affichage en couleur dans le client interactif
 */
void prefix_print(FILE *out, char *prefix, char *message);

/*
 * Connexion à un serveur local. (Uniquement pour les développeurs AppoLab.)
 */
int connexion_local();

#endif
