"""
Vous pouvez écrire les fonctions demandées dans l'ordre que vous voulez (et même en créer d'autres, si cela vous paraît utile). Votre programme principal ne sera pas évalué.

1) Ecrire une fonction ajoute_prefixe qui prend en argument un mot et un préfixe et qui renvoie la chaîne de caractère obtenue en concaténant le préfixe suivi du mot. Par exemple, ajoute_prefixe("mentir", "de") vaut "dementir".

2) Ecrire une fonction repete qui prend en argument un mot et un entier n et qui renvoie la chaîne de caractères
obtenue en répétant le mot n fois à la suite (sans séparation). Par exemple, repete("bla", 3) vaut "blablabla".

3) Ecrire une fonction ajoute_longueur qui prend comme argument un mot et qui ajouter sa longueur au début et à la fin. Par exemple, ajoute_longueur("toto") vaut "4toto4".

Note: On rappelle que la longueur d'un mot est obtenue avec la fonction len, par exemple len("toto") vaut 4. De plus, pour convertir un entier ou flottant en chaînes de caractères, il faut utiliser le mot clé str(...). Par exemple, str(4) vaut "4".

4) Ecrire une fonction que_des_nombres qui prend en argument un mot et qui renvoie la chaîne de caractères obtenue à
partir du mot en remplaçant chaque lettre par sa position dans le mot. Par exemple, que_des_nombres("toto") vaut
"1234", et que_des_nombres("bonjour") vaut "1234567".
"""


def ajoute_prefixe(verbe, prefixe):
    return prefixe + verbe


def repete(mot, fois):
    return fois * mot


def ajoute_longueur(mot):
    return str(len(mot)) + mot + str(len(mot))


def que_des_nombres(mot):
    result = ''
    i = 1
    while i <= len(mot):
        result += str(i)
        i += 1
    return result
