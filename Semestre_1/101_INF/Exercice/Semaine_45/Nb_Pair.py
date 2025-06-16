"""
Ecrire une fonction somme_pairs qui prend en argument une liste et qui renvoie la somme des nombres pairs contenus dans la liste.
Exemple : somme_pairs([4, 7, 12, 0, 21, 5]) vaut 16 (car 16=4+12+0).

Ecrire une fonction nb_elem_pairs qui prend en argument une liste et qui renvoie le nombre d'entiers pairs contenus dans la liste.
Exemple : nb_elem_pairs([4, 7, 12, 0, 21, 5]) vaut 3 (car 4, 12 et 0 sont pairs).

Ecrire une fonction max_pair qui prend en argument une liste et qui renvoie le plus grand entier pair contenu dans la liste. On supposera pour simplifier (dans cette question uniquement) que la liste contient toujours au moins un nombre pair.
Exemple : max_pair([4, 7, 12, 0, 21, 5]) vaut 12.

Ecrire une fonction min_pair qui prend en argument une liste et qui renvoie le plus petit entier pair contenu dans la liste. Si la liste ne contient aucun entier pair, la fonction renverra None.
Exemple : min_pair([4, 7, 12, 0, 21, 5])vaut 0 et min_pair([9, 3, 1])vaut None.

Ecrire une fonction indice_de qui prend en argument un entier (supposé pair) et une liste, et qui renvoie l'indice auquel apparaît cet entier dans la liste. Si l'entier n'apparaît pas, la fonction renverra None. On suppose ici pour simplifier que l'entier cherché n'apparaît pas plusieurs fois dans la liste. Indice: si la boucle for e in liste ne vous convient pas, n'oubliez pas que vous pouvez faire un for + range ou un while...
Exemple : indice_de(12, [4, 7, 12, 0, 21, 5]) vaut 2 (car 12 est placé à l'indice 2), et indice_de(6, [4, 7, 12, 0, 21, 5]) vaut None.

Ecrire une fonction trouve_premier_pair qui prend en argument une liste et qui renvoie l'entier pair qui apparaît en premier dans la liste. Si la liste ne contient pas d'entier pair, la fonction renverra None.
Exemple : trouve_premier_pair([1, 15, 4, 7, 12, 3]) vaut  4 et trouve_premier_pair([1, 17, 7]) vaut  None.

Ecrire une fonction extrait_pairs qui prend en argument une liste l1 et qui renvoie la liste obtenue à partir de l1en ne gardant que  les entiers pairs (et sans changer leur ordre). Attention, l1 ne doit pas être modifiée par la fonction.
Exemple : extrait_pairs([4, 7, 12, 0, 3]) vaut  [4, 12, 0] et extrait_pairs([21, 17, 3]) vaut  [ ].
"""


def somme_pairs(liste):
    somme = 0
    for nombre in liste:
        if nombre % 2 == 0:
            somme += nombre
    return somme


# print(somme_pairs([4, 7, 12, 0, 21, 5]))

def nb_elem_pairs(liste):
    occurence = 0
    for nombre in liste:
        if nombre % 2 == 0:
            occurence += 1
    return occurence


# print(nb_elem_pairs([4, 7, 12, 0, 21, 5]))

def max_pair(liste):
    maximum = 0
    for nombre in liste:
        if nombre % 2 == 0 and nombre > maximum:
            maximum = nombre
    return maximum


# rint(max_pair([4, 7, 12, 0, 21, 5]))

def min_pair(liste):
    min = max_pair(liste)
    for nombre in liste:
        if nombre % 2 == 0 and nombre < min:
            min = nombre
            # Le cas liste impair
    if nb_elem_pairs(liste) == 0:
        return None
    else:
        return min


# print(min_pair([4, 7, 12, 0, 21, 5]))
# print(min_pair([9, 3, 1]))

def indice_de(nombre, liste):
    if nombre not in liste:
        return None
    else:
        indice = 0
        for i in liste:
            if i == nombre:
                return indice
            else:
                indice += 1
        return indice


# print(indice_de(12, [4, 7, 12, 0, 21, 5]))
# print(indice_de(6, [4, 7, 12, 0, 21, 5]))

def trouve_premier_pair(liste):
    if nb_elem_pairs(liste) == 0:
        return None
    else:
        for nombre in liste:
            if nombre % 2 == 0:
                return nombre


# print(trouve_premier_pair([1, 15, 4, 7, 12, 3]))
# print(trouve_premier_pair([1, 17, 7]))

def extrait_pairs(liste):
    result = []
    for nombre in liste:
        if nombre % 2 == 0:
            result.append(nombre)
    return result
