"""
Alain vient d'ouvrir un club de gym en 2017 et il a déjà 100 adhérents. D'après ses pronostics, le nombre d'adhérents devrait augmenter de 8% par an. Ecrire un programme pour aider Alain dans ses prévisions de nombre d'adhérents, en suivant le cahier des charges décrit ci-dessous.

Le nombre d'adhérents chaque année sera arrondi à l'entier le plus proche grâce à la fonction round(...). Par exemple, round(6.8) vaut 7.

Lorsqu'Alain lance l'application, le menu suivant doit s'afficher:
Menu, veuillez choisir:
1. Prévisions adhérents à l'année N (resumé)
2. Prévisions adhérents à l'année N (détails)
3. Adhésions cumulées à l'année N
4. Année à laquelle on obtiendra M adhérents
Q. Quitter

Si Alain tape 1, le programme lui affiche Choisissez une année : puis le nombre d'adhérents qu'il y aura à l'année choisie, par exemple si Alain tape 2018, le programme doit afficher En 2018 il y aura 108 adherents. Ensuite, le programme doit ré-afficher le menu.

Si Alain tape 2, le programme lui affiche Choisissez une année : puis le détail des nombres d'adhérents prévus de l'année 2017 à l'année choisie. Par exemple si Alain tape 2019, le programme doit afficher:
En 2017 il y a 100 adherents.
En 2018 il y aura 108 adherents.
En 2019 il y aura 117 adherents.
Ensuite, le programme doit ré-afficher le menu.
Si l'année choisie est inférieure ou égale à 2017, seule la ligne En 2017 il y a 100 adherents. doit s'afficher.

Si Alain tape 3, le programme lui affiche Choisissez une année : puis le nombres d'adhésions cumulées entre l'année 2017 et l'année choisie (car chaque adhérent doit renouveler son adhésion chaque année). Par exemple si Alain tape 2019, le programme doit afficher De 2017 à 2019 il y aura 325 adhésions cumulées. (c'est la somme des nombres affichés dans le choix 2 du menu). Ensuite, le programme doit ré-afficher le menu.

Si Alain tape 4, le programme lui affiche Entrez le nombre d'adherents voulus : puis l'année à partir de laquelle ce nombre d'adhérents sera atteint. Par exemple si Alain tape 115, le programme doit afficher On atteindra 115 adhérents en 2019. Ensuite, le programme doit ré-afficher le menu.

Si Alain tape Q, le programme lui affiche Au revoir. et s'arrête.

Si Alain tape autre chose que 1, 2, 3, 4 ou Q, le programme doit lui répondre Choix invalide, recommencez : (sans ré-afficher le menu) et recommencer à lui afficher cette phrase jusqu'à ce que son choix devienne valide.

Exemple 1:

Menu, veuillez choisir :
1. Prévisions adhérents à l'année N (resumé)
2. Prévisions adhérents à l'année N (détails)
3. Adhésions cumulées à l'année N
4. Année à laquelle on obtiendra M adhérents
Q. Quitter
4
Entrez le nombre d'adherents voulus: 203
On atteindra 203 adhérents en 2027.

Menu, veuillez choisir :
1. Prévisions adhérents à l'année N (resumé)
2. Prévisions adhérents à l'année N (détails)
3. Adhésions cumulées à l'année N
4. Année à laquelle on obtiendra M adhérents
Q. Quitter
Q
Au revoir.

Exemple 2:

Menu, veuillez choisir :
1. Prévisions adhérents à l'année N (resumé)
2. Prévisions adhérents à l'année N (détails)
3. Adhésions cumulées à l'année N
4. Année à laquelle on obtiendra M adhérents
Q. Quitter
1
Choisissez une année : 2020
En 2020 il y aura 126 adherents.

Menu, veuillez choisir :
1. Prévisions adhérents à l'année N (resumé)
2. Prévisions adhérents à l'année N (détails)
3. Adhésions cumulées à l'année N
4. Année à laquelle on obtiendra M adhérents
Q. Quitter
5
Choix invalide, recommencez : -1
Choix invalide, recommencez : 1
Choisissez une année : 2023
En 2023 il y aura 159 adherents.

Menu, veuillez choisir :
1. Prévisions adhérents à l'année N (resumé)
2. Prévisions adhérents à l'année N (détails)
3. Adhésions cumulées à l'année N
4. Année à laquelle on obtiendra M adhérents
Q. Quitter
3
Choisissez une année : 2020
De 2017 à 2020 il y aura 451 adhésions cumulées.

Menu, veuillez choisir :
1. Prévisions adhérents à l'année N (resumé)
2. Prévisions adhérents à l'année N (détails)
3. Adhésions cumulées à l'année N
4. Année à laquelle on obtiendra M adhérents
Q. Quitter
Q
Au revoir.

Exemple 3 :

Menu, veuillez choisir :
1. Prévisions adhérents à l'année N (resumé)
2. Prévisions adhérents à l'année N (détails)
3. Adhésions cumulées à l'année N
4. Année à laquelle on obtiendra M adhérents
Q. Quitter
2
Choisissez une année : 2023
En 2017 il y a 100 adherents.
En 2018 il y aura 108 adherents.
En 2019 il y aura 117 adherents.
En 2020 il y aura 126 adherents.
En 2021 il y aura 136 adherents.
En 2022 il y aura 147 adherents.
En 2023 il y aura 159 adherents.

Menu, veuillez choisir :
1. Prévisions adhérents à l'année N (resumé)
2. Prévisions adhérents à l'année N (détails)
3. Adhésions cumulées à l'année N
4. Année à laquelle on obtiendra M adhérents
Q. Quitter
Q
Au revoir.
"""
replay = True
while replay:
    print('Menu, veuillez choisir:')
    print("1. Prévisions adhérents à l'année N (resumé)")
    print("2. Prévisions adhérents à l'année N (détails)")
    print("3. Adhésions cumulées à l'année N")
    print("4. Année à laquelle on obtiendra M adhérents")
    print("Q. Quitter")
    reponse = input()
    while reponse not in "1234Q":
        reponse = input("Choix invalide, recommencez :")
    # 1
    if reponse == "1":
        annee = int(input("Choisissez une année : "))
        debut = 2017
        adherent = 100
        while debut < annee:
            adherent = adherent + round(adherent * 0.08)
            debut += 1
        print("En", annee, "il y aura", adherent, "adherents.")
    # 2
    elif reponse == "2":
        annee = int(input("Choisissez une année : "))
        if annee == "2017":
            print(" En 2017 il y a 100 adherents.")
        else:
            debut = 2017
            adherent = 100
            while debut <= annee:
                print("En", debut, "il y aura", adherent, "adherents.")
                adherent += round(adherent * 0.08)
                debut += 1

    # 3
    elif reponse == "3":
        annee = int(input("Choisissez une année : "))
        debut = 2017
        adherent = 100
        nombre = 0
        while debut <= annee:
            nombre += adherent
            adherent += round(adherent * 0.08)
            debut += 1
        print("De 2017 à", annee, "il y aura ", nombre, "adhésions cumulées. ")
    # 4
    elif reponse == "4":
        voulu = int(input("Entrez le nombre d'adherents voulus : "))
        debut = 2017
        adherent = 100
        while adherent <= voulu:
            adherent += round(adherent * 0.08)
            debut += 1
        print("On atteindra", voulu, "adhérents en", debut)
    # Q
    elif reponse == "Q":
        print("Au revoir")
        replay = False
