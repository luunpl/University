"""
Les fonctions demandées ne sont a priori pas dépendantes les unes des autres. Vous pouvez les écrire dans l'ordre que vous voulez.

1) Ecrire une fonction f qui prend un nombre x en argument et qui renvoie la valeur de 4x2-x+5.

2) Considérons un triangle ABC rectangle en A. Ecrire une fonction coteAB(coteAC, hypotenuse) qui prend en argument la longueur du côté AC et la longueur de l'hypoténuse et qui renvoie la longueur du côté AB.

3) Ecrire une fonction conversion_feet_m qui prend comme argument une longueur en pieds et qui renvoie la longueur en mètres correspondante. On utilisera le taux de conversion suivant: 1 pied=0.3048m.

4) Etant donnés deux points A et B de coordonnées (xA,yA) et (xB,yB), la distance Manhattan entre A et B est donnée par la formule suivante:

d=|xA-xB|+|yA-yB|

(les barres verticales désignent la valeur absolue, dont le nom en Python est abs) . Elle porte ce nom car c'est la distance qu'il faut parcourir pour aller de A à B en utilisant seulement des directions parallèles à l'axe des abscisses ou à l'axe des ordonnées (comme le quadrillage des rues de Manhattan). Ecrire une fonction distance_manh(xA, yA, xB, yB) qui renvoie la distance Manhattan entre A et B.
"""
import math


def f(x):
    return 4 * (x ** 2) - x + 5


def coteAB(coteAC, hypotenuse):
    return math.sqrt(hypotenuse ** 2 - coteAC ** 2)


def conversion_feet_m(feet):
    return feet * 0.3048


def distance_manh(xA, yA, xB, yB):
    return abs(xA - xB) + abs(yA - yB)


"""
1) Écrire une fonction valeur_abs qui prend en argument un nombre x et qui renvoie sa valeur absolue.

2) Écrire une fonction signe_different qui prend en arguments deux nombres x et y et qui renvoie True si x et y ont des signes différents, False sinon (si x ou y est égal à 0, la fonction doit renvoyer False).

3) Soit f la fonction mathématique définie sur R par f (x) = 3x2 + 2x + 3. Écrire une fonction Python f qui prend en argument un réel x et qui renvoie la valeur de f(x).

4) Écrire une fonction nb_racines qui prend en argument trois réels a, b, c et qui renvoie le nombre de racines réelles du polynôme ax2 + bx + c. La fonction doit donc renvoyer un entier qui vaut 0, 1 ou 2 selon les cas. On rappelle la formule du discriminant : ∆ = b2 − 4ac.
"""


def valeur_abs(nombre):
    return -nombre if nombre < 0 else nombre


def signe_different(x, y):
    return True if x * y < 0 else False


def f(x):
    return 3 * (x ** 2) + 2 * x + 3


def nb_racines(a, b, c):
    delta = b ** 2 - 4 * a * c
    if delta > 0:
        return 2
    elif delta == 0:
        return 1
    else:
        return 0
