"""
1)Écrire une fonction maximum qui prend en arguments deux nombres et qui renvoie le plus grand des deux.

2)Écrire une fonction maximum3 qui prend en arguments trois nombres et qui renvoie le plus grand des trois.
Vous ferez appel à votre fonction maximum.

3) Écrire une fonction maximum3_input qui ne prend pas d’arguments,
qui demande trois nombres à l’utilisateur puis qui renvoie le maximum des 3 nombres.
Vous ferez appel à votre fonction maximum3.
"""


def maximum(a, b):
    if a > b:
        return a
    else:
        return b


def maximum3(a, b, c):
    if maximum(a, b) > c:
        return maximum(a, b)
    else:
        return c


def maximum3_input():
    a = float(input('a = '))
    b = float(input('b = '))
    c = float(input('c = '))
    return maximum3(a, b, c)




