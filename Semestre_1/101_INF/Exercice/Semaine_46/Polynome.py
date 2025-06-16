"""
Dans cet exercice, on veut travailler avec des polynômes de degrés quelconques. On peut représenter chaque polynôme avec un dictionnaire, dont les clés correspondent aux puissances de x, et les valeurs aux coefficients. Par exemple, pour représenter le polynôme x6 + 3x2 , on peut utiliser le dictionnaire :

{ 6: 1, 2: 3 }

On interdit d’avoir des monômes “inutiles”, c’est-à-dire avec un coefficient à zéro. Le polynôme nul sera modélisé par un dictionnaire vide {}.

1. Ecrire une fonction evaluer(p, x) qui prend un polynôme p et un nombre x en arguments, et renvoie la valeur du polynôme au point x.

2. Ecrire une fonction somme_polynomes(p1, p2) qui prend deux polynômes (dictionnaires) en arguments et qui renvoie un nouveau dictionnaire représentant la somme des deux polynômes p1 et p2.

3. Ecrire une fonction produit_polynomes(p1, p2) qui prend deux polynômes en argument et renvoie le produit des deux polynômes dans un nouveau dictionnaire.

Exemple d’exécution:

evaluer({3:1, 1: 2, 0: -1}, 2)

11

somme_polynomes({3:1, 2:1, 0:1}, {4:2, 2:3})

{0: 1, 2: 4, 3: 1, 4: 2}

produit_polynomes({3:1, 2:1, 0:1}, {4:2, 2:3})

{2: 3, 4: 5, 5: 3, 6: 2, 7: 2}

somme_polynomes({2:1, 1:1, 0:1}, {2:1, 1:-1, 0:1})

{0: 2, 2: 2}
"""


def evaluer(p, x):
    valeur = 0
    for i in p:
        valeur += p[i] * (x ** i)
    return valeur


def somme_polynomes(p1, p2):
    result_dict = {}

    for key in p1:

        if key in p2:

            result_dict[key] = p1[key] + p2[key]
        else:

            result_dict[key] = p1[key]

    for key in p2:
        if key not in result_dict:
            result_dict[key] = p2[key]

    # Verifier si coeff egal a 0

    supprimer = []
    # Eviter error RuntimeError: dictionary changed size during iteration
    for deg in result_dict:
        if result_dict[deg] == 0:
            supprimer.append(deg)

    for key in supprimer:
        del result_dict[key]
    return result_dict


# print(somme_polynomes({3:1, 2:1, 0:1}, {4:2, 2:3}))
# print(somme_polynomes({2:1, 1:1, 0:1}, {2:1, 1:-1, 0:1}))

def produit_polynomes(p1, p2):
    result = {}
    for i in p1:
        a_ajouter = {}
        for j in p2:
            # La cle est le degree
            cle = i + j
            # Le coeff
            coeff = p1[i] * p2[j]
            # Ajouter a une dict vide
            a_ajouter[cle] = coeff
            # Reutiliser la fonction de la question precedente
        result = somme_polynomes(result, a_ajouter)
    return result
