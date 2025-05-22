"""
Ecrire un programme qui demande à l'utilisateur de saisir un entier positif N et qui vérifie si N est premier.

Exemple 1

Nombre : 25
25 n'est pas premier.

Exemple 2

Nombre : 7
7 est premier.
"""

n = int(input('Nombre : '))
if n < 2:
    print(n, "n'est pas premier")
else:
    est_Premier = True
    i = 2
    while est_Premier and i < n:
        if n % i == 0:
            est_Premier = False
        i += 1
    # Comparer stop pour conclure
    if est_Premier:
        print(n, "est premier")
    else:
        print(n, "n'est pas premier")


