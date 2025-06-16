"""
1) Ecrire une fonction commence_par prenant en argument une lettre et un mot et qui renvoie True si le mot commence par la lettre donnée en argument, False sinon.

Exemple: commence_par('h', 'hello') vaut True mais commence_par('e', 'roue') vaut False.

2) Ecrire une fonction contient_voyelle qui prend en argument un mot et qui renvoie True si le mot contient une voyelle, False sinon.

3) Ecrire une fonction derniere_consonne qui prend en argument un mot et qui renvoie deux valeurs de retour: l'indice de sa dernière consonne ainsi que la dernière consonne (comme pour les listes, on considérera que l'indice de la première lettre est zéro). On ne traitera pas le cas problématique où le mot ne contient pas de consonne.

Exemple: derniere_consonne('arrivee') renvoie  4, 'v'

4) Ecrire une fonction double_consonne qui prend en argument un mot et qui a deux valeurs de retour: un booléen valant True si le mot contient une double consonne (deux fois la même consonne à la suite), et dans ce cas la deuxième valeur de retour est la consonne qui est doublée ; s'il n'y a pas de consonne doublée, la fonction doit renvoyer False et None.  Pour information: pour simplifier l'exercice, on ne testera pas votre fonction sur un mot contenant plusieurs double consonnes (par exemple, 'successeur').

Exemples:

double_consonne('arrivee') vaut True, 'r'.
double_consonne('bonbon') vaut False, None
double_consonne('reussite') vaut True, 's'
5) Ecrire une fonction envers qui prend en argument une liste li (attention, pas un mot, contrairement aux autres fonctions de cet exercice) et qui renvoie une liste obtenue à partir de li en inversant l'ordre des éléments.

Exemple: envers(['a', 'b', 'c', 'd']) vaut ['d', 'c', 'b', 'a']

6) Ecrire une fonction palindrome qui prend en argument un mot et qui renvoie un booléen indiquant si le mot est un palindrome. Un palindrome est un mot qui reste identique lorsqu'il est lu de droite à gauche au lieu de l'ordre habituel de gauche à droite.

Exemple: palindrome('ici') vaut True mais palindrome('aller') vaut False.

7) Ecrire une fonction mot_autorise prenant en argument un mot et une liste de mots interdits, et qui renvoie True si le mot est autorisé, et False si le mot est interdit.

Exemple:

mot_autorise('fric',  ['sous', 'fric', 'thune', 'ble']) vaut False
mot_autorise('argent', ['sous', 'fric', 'thune', 'ble']) vaut True
"""


def commence_par(lettre, mot):
    return True if mot[0] == lettre else False


def contient_voyelle(mot):
    voyelle = "aeouiy"
    for i in mot:
        if i in voyelle:
            return True
    return False


def derniere_consonne(mot):
    voyelle = "aeoui"
    for i in range(len(mot) - 1, 0, -1):
        if mot[i] not in voyelle:
            return i, mot[i]


def double_consonne(mot):
    voyelle = "aeoui"
    # Assurer ne pas commettre d'erreur out of range le cas False au dernier mot
    for i in range(len(mot) - 1):
        if (mot[i] == mot[i + 1]) and mot[i] not in voyelle:
            return True, mot[i]
    return False, None


def envers(li):
    result = []
    for i in range(len(li) - 1, -1, -1):
        result.append(li[i])
    return result


def palindrome(mot):
    ordre = list(mot)
    if ordre == envers(list(mot)):
        return True
    else:
        return False


def mot_autorise(mot, liste):
    return True if mot not in liste else False
