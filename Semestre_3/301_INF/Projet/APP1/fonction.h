#ifndef __FONCTION_H__
#define __FONCTION_H__
#include <stdio.h>
#include <stdbool.h>

// Travail en binome
// ProjetX : Permet de decaler pour trouver bon message
void Cesar(char message[], int decalage);

// crypteMove :
// - soit TXT la sequence des caracteres a encrypter
// - soit ENC la sequence de sortie
//   (au debut, ENC est vide)
// - j'effectue ensuite la manipulation suivante:
//   * je prends C le premier caractere de TXT et le rajoute a la fin de ENC
//   * soit X le code ASCII de C modulo 8 (par exemple pour la lettre 'b', son 
//     code ASCII est 98 donc X = 2)
//   * je prends les X premiers caracteres de TXT et les deplace a la fin de TXT
//     (s'il reste au moins X caracteres dans TXT)
//   * je recommence jusqu'a ce que TXT soit vide
// - a la fin, ENC contiendra le message encrypte.

void crypteMove(char TXT[], char ENC[]);

// BayOfPigs:
// Idee
// soit ENC la sequence des caracteres a decrypter
// - soit TXT la sequence de sortie
//   (au debut, TXT est vide)
// - j'effectue ensuite la manipulation suivante:
//   * je prends C le dernier caractere de ENC
//   * soit X le code ASCII de C modulo 8 (par exemple pour la lettre 'b', son
//     code ASCII est 98 donc X = 2)
//   * si X < longeur de TXT, je prends X derniers caracteres et les deplace au debut de TXT
//   * je deplace C au debut de TXT
//   * je recommence jusqu'a ce que ENC soit vide
// - a la fin, TXT contiendra le message ORIGINAL

void BayOfPigs(char ENC[], char TXT[]);

// crypteSeq
// En voici le principe :
// - durant l'encryption, je maintiens une sequence de tous les caracteres deja 
//   rencontres, dans l'ordre
// - pour chaque caractere C a crypter, je cherche dans la sequence s'il a deja 
//   ete rencontre
//   - si c'est la premiere fois, je l'ajoute en fin de sequence et je le laisse 
//     inchange dans le message crypte
//   - sinon, je considere D qui est soit:
//     - le caractere qui precede C dans la sequence
//     - le dernier caractere de la sequence si C est le premier caractere de la 
//       sequence
//     je remplace C par D dans le message crypte et je deplace C a la fin de la 
//     sequence

// Fonction pour vérifier si le caractère est dans la séquence
int estDansSeq(char SEQ[], char caractere);

// Fonction pour trouver la position du caractère dans la séquence
int positionDansSEQ(char SEQ[], char caractere);

// Fonction principale pour crypter le texte
void crypteSeq(char TXT[], char SEQ[], char ENC[]);

//

#endif