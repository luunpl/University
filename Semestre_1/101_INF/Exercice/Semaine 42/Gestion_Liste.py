"""
1) Ecrire une fonction liste_decroissante prenant en argument un entier n et qui renvoie la liste de tous les entiers de n à 0.

Exemple: liste_decroissante(5) vaut [5, 4, 3, 2, 1, 0]

2) Ecrire une fonction multiples qui prend en argument un entier m et un entier longueur et qui renvoie une liste contenant les multiples de m, en commençant par 0, et dont la longueur est déterminée par l'argument longueur.

Exemple: multiples(5, 6) vaut [0, 5, 10, 15, 20, 25]

3) Ecrire une fonction pairs qui prend un argument longueur qui renvoie une liste contenant les entiers pairs dans l'ordre croissant, en commençant par 0, et dont la longueur est donnée par l'argument longueur. Vous pouvez bien sûr vous aider des fonctions précédentes si vous jugez cela pertinent.

Exemple: pairs(10) vaut [0, 2, 4, 6, 8, 10, 12, 14, 16, 18]
"""


def liste_decroissante(nombre):
    L = []
    i = nombre
    while i >= 0:
        L.append(i)
        i -= 1
    return L


def multiples(nombre, longeur):
    L = []
    i = 0
    while i < longeur:
        L.append(nombre * i)
        i += 1
    return L


def pairs(longeur):
    L = []
    i = 0
    pair = 2
    while i < longeur:
        L.append(pair * i)
        i += 1
    return L
