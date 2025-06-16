"""
1) Ecrire une fonction factorielle qui prend en argument un entier naturel n et qui renvoie la valeur de n!.

Rappel: n!=1 × 2× ... n

2) Ecrire une fonction coeff_binomial qui prendre en argument deux entiers naturels n et k (avec k≤n) et qui renvoie la valeur du coefficient binomial correspondant "k parmi n", donnée par le formule ci-dessous:

(nk)=n!(n−k)! k!

3) Ecrire une fonction triangle_pascal qui prend en argument un entier nb_lignes et qui affiche le triangle de Pascal (voir définition ci-dessous) en s'arrêtant au bout du nombre de lignes indiqué par l'argument. Voici un exemple du triangle de Pascal avec 6 lignes:

1
1 1
1 2 1
1 3 3 1
1 4 6 4 1
1 5 10 10 5 1

En numérotant les lignes et les colonnes à parte de zéro, le nombre sur la ligne numéro n et le colonne numéro k est le coefficient binomial (nk)
.  Par exemple, pour la colonne numéro 0, on a toujours (n0)
= 1 , et pour la colonne 1 on a toujours (n1)
 = n
 . De même, lorsque k=n, on a (nn)
= 1  donc chaque ligne se termine par un 1.
"""


def factorielle(n):
    fac = 1
    for i in range(1, n + 1):
        fac *= i
    return fac


def coeff_binomial(n, k):
    return factorielle(n) / (factorielle(n - k) * factorielle(k))


def triangle_pascal(nb_lignes):
    for i in range(nb_lignes):
        for j in range(i + 1):
            print(int(coeff_binomial(i, j)), end=" ")
        print()
