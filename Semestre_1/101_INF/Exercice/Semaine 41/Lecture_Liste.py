"""
Ecrire une fonction LireListeEntiers sans argument qui permet de lire des entiers positifs ou nuls saisis au clavier. La saisie s’arrête lorsque l’on entre un nombre négatif. La fonction retourne la liste des entiers saisis.

Ecrire le programme principal qui permet d’appeler la fonction et d’afficher ensuite la liste obtenue avec la fonction print.

Proposer une fonction LireListeReelsBornes avec deux arguments facultatifs bmin et bmax, qui permet de lire des réels saisis au clavier. La saisie s’arrête lorsque l’utilisateur saisit une valeur en dehors de l’intervalle [bmin ;  bmax]. Par défaut, les valeurs de min et max sont fixées à 0 et 100 respectivement. La fonction doit retourner une liste.

Définir une fonction MMSListe qui prend en argument une liste et qui retourne le minimum, le maximum et la somme de la liste.
Votre fonction doit utiliser une boucle while ou for , et ne doit pas utiliser les fonctions max, min et sum pré-définies en Python.

Complétez votre programme principal en utilisant LireListeReelsBornes pour saisir une liste de réels au clavier et MMSListe pour obtenir le minimum, le maximum et la somme des valeurs saisies. Afficher les 3 valeurs obtenues à la console.
"""


def LireListeEntiers():
    L = []
    entier = float(input())
    while entier >= 0:
        L.append(entier)
        entier = float(input())
    return L


def LireListeReelsBornes(bmin=0, bmax=100):
    L = []
    entier = float(input())
    while bmin <= entier <= bmax:
        L.append(entier)
        entier = float(input())
    return L


def MMSListe(liste):
    minimum = liste[0]
    maximum = liste[0]
    somme = 0
    i = 0
    while i < len(liste):
        if liste[i] > maximum:
            maximum = liste[i]
        if liste[i] < minimum:
            minimum = liste[i]
        somme += liste[i]
        i += 1
    return minimum, maximum, somme
