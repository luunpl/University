"""
Laurence doit gérer les stocks d'un entrepôt de fenêtres, semaine par semaine. Le stock de la semaine 1 est 1024 fenêtres. De plus, elle a réussi à obtenir les prévisions suivantes : pendant la semaine n, le nombre de fenêtres qui partent de l'entrepôt (en direction des magasins) est 20+n. De plus, si le numéro de semaine est un multiple de 4, alors l'entrepôt reçoit une livraison de 500 fenêtres venant de l'usine de production. Donc le stock de la semaine 1 est 1024, le stock de la semaine 2 est 1024-(20+2)=1002, le stock de la semaine 3 est 1002-(20+3)=979, le stock de la semaine 4 est 979-(20+4)+500=1455, etc.

Cet exercice est dédié à la conception d'un programme aidant Laurence dans sa gestion des stocks et suivant le cahier des charges décrit ci-dessous.

Le programme doit commencer par afficher le menu suivant:

a. Prévisions de stock
b. Stock maximal
(q pour quitter)

Si Laurence tape q , le programme s'arrête.

Si Laurence tape a , le programme lui demande un numéro de semaine n puis affiche les prévisions de stock de la semaine 1 à la semaine n. Par exemple:
Choisissez une semaine : 6
Semaine 1 : stock 1024
Semaine 2 : stock 1002
Semaine 3 : stock 979
Semaine 4 : stock 1455
Semaine 5 : stock 1430
Semaine 6 : stock 1404

Si Laurence tape b , le programme lui demande un numéro de semaine n puis calcule quel sera le stock maximal entre la semaine 1 et la semaine n (et lui indique à quelle semaine ce stock maximal sera atteint). Par exemple:
Choisissez une semaine : 6
Stock max égal à 1455 , atteint en semaine 4

Si Laurence tape autre chose que a, b ou q , le programme lui affiche un message d'erreur Choix incorrect, recommencez, et recommence à afficher ce message tant que le choix n'est pas valide.

Exemple 1
a. Prévisions de stock
b. Stock maximal
(q pour quitter)
a
Choisissez une semaine : 7
Semaine 1 : stock 1024
Semaine 2 : stock 1002
Semaine 3 : stock 979
Semaine 4 : stock 1455
Semaine 5 : stock 1430
Semaine 6 : stock 1404
Semaine 7 : stock 1377

a. Prévisions de stock
b. Stock maximal
(q pour quitter)
b
Choisissez une semaine : 8
Stock max égal à 1849 , atteint en semaine 8

a. Prévisions de stock
b. Stock maximal
(q pour quitter)
q

Exemple 2
a. Prévisions de stock
b. Stock maximal
(q pour quitter)
c
Choix incorrect, recommencez 1
Choix incorrect, recommencez b
Choisissez une semaine : 10
Stock max égal à 1849 , atteint en semaine 8

a. Prévisions de stock
b. Stock maximal
(q pour quitter)
q

Exemple 3
a. Prévisions de stock
b. Stock maximal
(q pour quitter)
p
Choix incorrect, recommencez q

Exemple 4
a. Prévisions de stock
b. Stock maximal
(q pour quitter)
a
Choisissez une semaine : 3
Semaine 1 : stock 1024
Semaine 2 : stock 1002
Semaine 3 : stock 979

a. Prévisions de stock
b. Stock maximal
(q pour quitter)
a
Choisissez une semaine : 10
Semaine 1 : stock 1024
Semaine 2 : stock 1002
Semaine 3 : stock 979
Semaine 4 : stock 1455
Semaine 5 : stock 1430
Semaine 6 : stock 1404
Semaine 7 : stock 1377
Semaine 8 : stock 1849
Semaine 9 : stock 1820
Semaine 10 : stock 1790

a. Prévisions de stock
b. Stock maximal
(q pour quitter)
q
"""
replay = True
while replay:
    # Set up
    print('a. Prévisions de stock')
    print('b. Stock maximal')
    print('(q pour quitter)')
    # Prog principale
    reponse = input()
    while reponse not in "abq":
        reponse = input('Choix incorrect, recommencez ')

    # a
    if reponse == "a":
        nb_semaine = int(input('Choisissez une semaine :'))
        stock = 1045
        semaine = 1
        while semaine <= nb_semaine:
            stock = stock - (20 + semaine)
            if semaine % 4 == 0:
                stock += 500
            print("Semaine", semaine, ": stock", stock)
            semaine += 1
    # b
    elif reponse == 'b':
        nb_semaine = int(input('Choisissez une semaine :'))
        semaine = 1
        stock = 1045
        max_semaine = 1
        max_stock = 1045
        while semaine <= nb_semaine:
            stock = stock - (20 + semaine)
            if semaine % 4 == 0:
                stock += 500
            if stock > max_stock:
                max_stock = stock
                max_semaine = semaine
            semaine += 1
        print("Stock max égal à", max_stock, ", atteint en semaine", max_semaine)
    # q
    elif reponse == "q":
        replay = False
