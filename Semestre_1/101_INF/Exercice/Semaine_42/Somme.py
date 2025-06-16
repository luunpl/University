"""
Pour chaque question, écrire une fonction qui prend en argument un entier n et qui :
fonction somme qui renvoie la somme des n premiers entiers (en partant de 1)
fonction somme_impairs qui renvoie la somme des n premiers entiers impairs
fonction somme_carres qui renvoie la somme des n premiers carrés (en partant de 1)
"""


def somme(n):
    i = 1
    somme = 0
    while i <= n:
        somme += i
        i += 1
    return somme


def somme_impairs(n):
    i = 1
    somme = 0
    while i <= n * 2:
        if i % 2 != 0:
            somme += i
        i += 1
    return somme


def somme_carres(n):
    i = 1
    somme = 0
    while i <= n:
        somme += i ** 2
        i += 1
    return somme
