"""
Ecrire un programme qui demande à l'utilisateur plusieurs nombres successivement en affichant "Nombre ?" jusqu'à ce que l'utilisateur entre le nombre 0. Le programme doit alors afficher "Tous -", ou "Tous +", ou "Seulement 0", ou "Ni tous +, ni tous -" selon que l'utilisateur n'a rentré que des nombres négatifs, ou bien que des nombres positifs, ou bien seulement zéro, ou bien aucun des cas précédents. Dans ce dernier cas (Ni tous +, ni tous -), le programme doit afficher "Somme -", ou "Somme=0", ou "Somme +" selon que la somme totale des nombres donnés par l'utilisateur est strictement négative, nulle ou strictement positive.

Exemple 1
Nombre ? 9
Nombre ? 7.2
Nombre ? 3.4
Nombre ? 0
Tous +

Exemple 2
Nombre ? -4
Nombre ? -2.1
Nombre ? 0
Tous -

Exemple 3
Nombre ? 0
Seulement 0

Exemple 4
Nombre ? -2
Nombre ? 5
Nombre ? -1.1
Nombre ? 0.5
Nombre ? 0
Ni tous +, ni tous -.
Somme +.

Exemple 5
Nombre ? -2.2
Nombre ? 1.1
Nombre ? 1.1
Nombre ? 0
Ni tous +, ni tous -
Somme = 0.

Exemple 6
Nombre ? -10.5
Nombre ? 1.1
Nombre ? 1.1
Nombre ? 0
Ni tous +, ni tous -
Somme -
"""
nombre = float(input("Nombre ? "))
if nombre == 0:
    print("Seulement 0")
else:
    somme = nombre
    tout_negatif = True
    tout_positif = True
    if nombre > 0:
        tout_negatif = False
    elif nombre < 0:
        tout_positif = False

    while nombre != 0:
        nombre = float(input("Nombre ? "))
        somme += nombre
        if nombre > 0:
            tout_negatif = False
        elif nombre < 0:
            tout_positif = False

    if tout_negatif:
        print("Tous -")
    elif tout_positif:
        print("Tous +")
    elif not tout_positif and not tout_negatif:
        print("Ni tous +, ni tous - ")
        if somme > 0:
            print("Somme +")
        elif somme == 0:
            print("Somme = 0")
        else:
            print("Somme -")
