"""
1) Chaque lundi, il souhaite que les mots soient répétés deux fois, séparés par un espace. Ecrivez une fonction lundi qui prend en argument un mot et qui transforme ce mot selon la règle du lundi. Par exemple, lundi("bonjour") doit valoir "bonjour bonjour".

2) Chaque mardi, il faut que les mots de longueur paire soit répétés 6 fois, en séparant par un tiret, alors que les mots de longueur impaire doivent être répétés 3 fois, en séparant par des virgules. Ecrire la fonction mardi qui prend en argument un mot et qui renvoie la chaîne de caractères suivant la règle du mardi. Rappel : la longueur d’une chaîne de caractères est donnée par len(chaine).

3) Chaque mercredi, il faut que les mots de longueur impaire soit remplacés par le mot "impair". Les mots pairs doivent rester tels qu’ils sont. Ecrire la fonction mercredi (qui prend en argument un mot et qui renvoie la bonne chaîne de caractères).

4) Chaque jeudi, il faut que les mots soient répétés autant de fois que leur longueur modulo 3 (à la suite, sans espace). Ecrire la fonction jeudi. Par exemple, jeudi("merci") vaut "mercimerci", jeudi("bonbon") vaut "", jeudi("comment") vaut "comment".

5) Le vendredi, il faut que les mots soient écrits normalement. Et heureusement, il n’y a pas de journal le week-end

6) Ecrire une fonction transforme(mot, num_jour) qui prend en argument un mot et le numéro du jour (1 pour lundi, 2 pour mardi, etc....) et qui renvoie le mot transformé selon la règle du jour correspondant.
"""


def lundi(mot):
    return mot + " " + mot


def mardi(mot):
    mot1 = ""
    if len(mot) % 2 == 0:
        for i in range(0, 6):
            mot1 += mot
            mot1 += "-"
    else:
        for i in range(0, 3):
            mot1 += mot
            mot1 += ","
    return mot1[: -1]


def mercredi(mot):
    if len(mot) % 2 != 0:
        return "impair"
    else:
        return mot


def jeudi(mot):
    repetition = len(mot) % 3
    return repetition * mot


def vendredi(mot):
    return mot


def transforme(mot, num_jour):
    if num_jour == 1:
        return lundi(mot)
    elif num_jour == 2:
        return mardi(mot)
    elif num_jour == 3:
        return mercredi(mot)
    elif num_jour == 4:
        return jeudi(mot)
    elif num_jour == 5:
        return vendredi(mot)
