"""
Ecrire un programme qui demande un entier positif n et qui calcule la factorielle de n. Si le nombre donné est strictement négatif, le programme doit afficher un message d'erreur et terminer. Pour les phrases à afficher, vous suivrez celles des exemples suivants.

Rappel: la factorielle de n est définie par: n! = 1 x 2 x 3 x .... x n

Exemple 1:

n=? -5
La factorielle n'est pas definie pour les nombres négatifs.

Exemple 2:

n=? : 5
La factorielle de 5 vaut 120 .

Exemple 3:

n=? 0
La factorielle de 0 vaut 1 .
"""

n = int(input("n = "))
fact = 1
i = 1
if n < 0:
    print("La factorielle n'est pas definie pour les nombres négatifs.")
else:
    while i <= n:
        fact = fact * i
        i = i + 1
    print("La factorielle de", n, "vaut", fact)
