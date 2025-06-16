"""
Ecrire une fonction est_croissante qui reçoit une liste d'entiers et qui renvoie un booléen indiquant si les éléments de cette liste sont dans l'ordre croissant (non strict).
Ecrire une fonction similaire est_decroissante qui détermine si une liste reçue en paramètre est en ordre décroissant (non strict).
Ecrire une fonction est_en_desordre qui détermine si une liste reçue en paramètre est dans le désordre (ni en ordre croissant, ni en ordre décroissant).
"""


def est_croissante(liste):
    return all(liste[i] <= liste[i + 1] for i in range(len(liste) - 1))


def est_decroissante(liste):
    return all(liste[i] >= liste[i + 1] for i in range(len(liste) - 1))


def est_en_desordre(liste):
    return True if (est_croissante(liste) == False and est_decroissante(liste) == False) else False
