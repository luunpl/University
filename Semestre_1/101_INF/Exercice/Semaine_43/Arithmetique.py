"""
1. Écrire une fonction plus_grand_diviseur_premier(n) qui renvoie le plus grand diviseur premier de l’entier n. Il vous est conseillé de commencer par redéfinir la fonction est_premier(n) que l’on a déjà vue.

2. Écrire une fonction pgcd(a,b) qui renvoie le plus grand commun diviseur des entiers a et b.

3. Écrire une fonction ppcm(a,b) qui renvoie le plus petit commun multiple de a et b.

4. Écrire une fonction irreductible(numerateur, dénominateur) qui renvoie True si la fraction correspondante numerateur/denominateur est irréductible, False sinon.
"""


def est_premier(nombre):
    for i in range(2, nombre):
        if nombre % i == 0:
            return False
    return True


def plus_grand_diviseur_premier(n):
    plus_grand = 1
    for i in range(1, n + 1):
        if est_premier(i) and n % i == 0:
            plus_grand = i
    return plus_grand


def pgcd(a, b):
    if b == 0:
        return a
    else:
        r = a % b
        return pgcd(b, r)


def ppcm(a, b):
    return a * b / pgcd(a, b)


def irreductible(numerateur, dénominateur):
    return True if pgcd(numerateur, dénominateur) == 1 else False
