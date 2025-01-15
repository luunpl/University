"""
Vous partez à la recherche d'un trésor caché dans une pyramide. Vous avez réussi à obtenir des informations sur les épreuves qui vous attendent à l'intérieur de celle-ci:

- dans le hall d'entrée, une statue de sphinx va vous demander un code secret sous la forme suivante : "Je n'aime que les nombres p qui sont des nombres premiers, tels que p+2 soit aussi un nombre  premier... Et mon nombre préféré de la journée est  *un nombre qui change tous les jours*. Le code secret est le plus petit nombre supérieur ou égal à mon nombre préféré parmi les nombres que j'aime."

- une fois entré, vous parcourez un labyrinthe dont vous vous êtes déjà procuré le plan, puis vous arrivez face à une statue d'Osiris qui garde la salle du trésor. Il va vous demander un code secret sous la forme suivante: "Je n'aime que les nombres n tels que n+1 soit une puissance de 2.... et il faut également que le reste de la division de n par 5 soit égal à 3... Mon nombre préféré de la journée est *un nombre qui change tous les jours*. Le code secret est le plus petit nombre supérieur ou égal à mon nombre préféré, parmi les nombres que j'aime."

Pour chacune des deux énigmes, vous n'aurez que 5 secondes pour répondre, sinon la sortie sera verrouillée et vous resterez enfermés dans la pyramide à tout jamais. Pour éviter cela à tout prix, vous décidez d'écrire un programme que vous emporterez sur votre smartphone et qui vous aidera à résoudre les énigmes. Pour cela:

Ecrire une fonction est_premier qui prend en argument un entier supérieur ou égal à 2 et qui renvoie True si l'entier en premier, False sinon.
Ecrire une fonction sphinx_aime qui prend en argument un entier supérieur ou égal à 2 et qui renvoie True si l'entier est un nombre que le sphinx aime, False sinon.
Ecrire une fonction code_hall qui prend en argument le nombre préféré du sphinx ce jour-là (un entier strictement positif) et qui renvoie le code secret du hall.
Ecrire une fonction est_puissance2 qui prend en argument un entier positif et qui renvoie True s'il s'agit d'une puissance de 2, False sinon.
On vous demande ici de ne pas utiliser le logarithme, et de fournir une solution efficace (par exemple, sur un immense entier impair, votre fonction doit immédiatement répondre False)
Ecrire une fonction osiris_aime qui prend en argument un entier positif et qui renvoie True si Osiris aime cet entier, False sinon.
Ecrire une fonction code_tresor qui prend en argument le nombre préféré d'Osiris ce jour-là (un entier strictement positif) et qui renvoie le code secret permettant d'accéder au trésor.
Par exemple, si le nombre préféré du sphinx est 15, alors le code secret du hall ce jour-là est 17 (car 17 et 19 sont premiers). Si le nombre préféré d'Osiris ce jour-là est 20, alors le code secret de la salle du trésor est 63 (car 63+1 est une puissance de 2, et 63= 12 x 5+3).
"""


def est_premier(nombre):
    for i in range(2, nombre):
        if nombre % i == 0:
            return False
    return True


def sphinx_aime(nombre):
    return est_premier(nombre) and est_premier(nombre + 2)


def code_hall(nombre):
    i = nombre
    while not sphinx_aime(i):
        i += 1
    return i


def est_puissance2(n):
    return n & (n - 1) == 0 and n != 0


def osiris_aime(nombre):
    return est_puissance2(nombre + 1) and (nombre % 5 == 3)


def code_tresor(nombre):
    i = nombre
    while not osiris_aime(i):
        i += 1
    return i
