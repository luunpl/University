"""
Dans toutes les fonctions demandées dans cet exercice, la liste passée en argument ne doit pas être modifiée par l'appel. Pensez à vous aider de Python Tutor pour visualiser le comportement de vos fonctions.

Ecrire une fonction decale qui prend en argument une liste l et un nombre d et qui renvoie la liste obtenue à partir de l en ajoutant un décalage de d à chaque élément de l.
Exemple : decale([4, 17, 12], 3) vaut [7, 20, 15].

Ecrire une fonction intercale_zeros qui prend en argument une liste l et qui renvoie la liste obtenue à partir de l en intercalant un zéro après chaque élément de l.
Exemple : intercale_zeros([4, 17, 12]) vaut [4, 0, 17, 0, 12, 0].

Ecrire une fonction supprime qui prend en argument une liste l et un élément elem et qui renvoie la liste obtenue à partir de l en supprimant toutes les occurrences de elem.
Exemple : supprime([4, 7, 12, 4, 4, 0, 4, 5], 4) vaut [7, 12, 0, 5].

Ecrire une fonction insere_milieu qui prend en argument une liste l et un élément elem et qui renvoie la liste obtenue à partir de l en ajoutant elem "au milieu" de l, c'est-à-dire:
Si la longueur de l est paire, l'élément est ajouté une fois, au milieu de la liste.
Si la longueur de l est impaire: l'élément est ajouté de part à d'autre de l'élément central.
Exemple : insere_milieu([4, 7, 12, 3], 0) vaut [4, 7, 0, 12, 3]  et insere_milieu([9, 3, 5, 6, 2], 1) vaut [9, 3, 1, 5, 1, 6, 2].

Ecrire une fonction decoupe qui prend en argument une liste de nombres l et un nombre seuil et qui renvoie deux listes: la première est obtenue à partir de l en ne gardant que les nombres inférieurs ou égaux à seuil; la deuxième est obtenue à partir de l en ne gardant que les nombres strictement supérieurs à seuil.
Exemple : decoupe([14, 27, 12, 0, 40, 34, 20, 11], 20) a pour valeur de retour  [14, 12, 0, 20, 11] et [27, 40, 34].
"""


def decale(l, d):
    liste_retour = []
    for i in l:
        liste_retour.append(i + d)
    return liste_retour


# print(decale([4, 17, 12], 3))

def intercale_zeros(l):
    liste_retour = []
    for i in l:
        liste_retour.append(i)
        liste_retour.append(0)
    return liste_retour


# print(intercale_zeros([4, 17, 12]))

def supprime(l, elem):
    liste_retour = []
    for i in l:
        if i != elem:
            liste_retour.append(i)
    return liste_retour


# print(supprime([4, 7, 12, 4, 4, 0, 4, 5], 4))


def insere_milieu(l, elem):
    result = list(l)
    # Traiter le cas pair
    if len(result) % 2 == 0:
        result.insert((len(result) // 2), elem)
    # Cas impair
    else:
        result.insert((len(l) // 2 + 1) - 1, elem)
        result.insert((len(l) // 2 + 1) + 1, elem)
    return result


# print(insere_milieu([4, 7, 12, 3], 0))
# print(insere_milieu([9, 3, 5, 6, 2], 1))

def decoupe(l, seuil):
    l1 = []
    l2 = []
    for i in l:
        if i > seuil:
            l2.append(i)
        else:
            l1.append(i)
    return l1, l2
# print(decoupe([14, 27, 12, 0, 40, 34, 20, 11], 20))
