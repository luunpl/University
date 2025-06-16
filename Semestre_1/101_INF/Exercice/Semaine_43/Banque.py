"""
Aline envisage d’ouvrir un compte à la banque Argento, mais elle veut d’abord savoir si cela sera rentable. Sur un tel compte, les intérêts sont de 5% par an, et la banque prélève un coût fixe annuel de 11 euros. Le capital de l’année n + 1 est donc obtenu par la formule un+1 = un × 1.05 − 11, où un désigne le capital à l’année n.

1) Écrire une fonction capital(nb_annees, capital_debut) qui renvoie le capital en euros qu’Aline aurait sur un tel compte au bout de nb_annees en plaçant initialement un capital égal à capital_debut (en euros).

2) Écrire une fonction gagne_argent(nb_annees, capital_debut) qui renvoie True si le capital au bout de nb_annees sur un tel compte est supérieur ou égal au capital de début.

3) Écrire une fonction capital_debut_min(nb_annees) qui renvoie le capital minimal qu’il faut mettre initialement sur le compte pour qu’après nb_annees, il soit supérieur ou égal au capital de début. On supposera ici que le capital de début est toujours un entier. Par exemple, capital_debut_min(7) renvoit 220.
"""


# 1
def capital(nb_annees, capital_debut):
    # On utilis le boucle while pour compter la somme apres n annees
    i = 0
    while i < nb_annees:
        capital_debut = capital_debut * 1.05 - 11
        i += 1
    return capital_debut


# print(capital(10, 5000))

# 2
def gagne_argent(nb_annees, capital_debut):
    # Une comparaison est suffit
    capital_apres = capital(nb_annees, capital_debut)
    if capital_apres >= capital_debut:
        return True
    else:
        return False


# 3
def capital_debut_min(nb_annees):
    i = 1
    while not gagne_argent(nb_annees, i):
        i += 1
    return i
