"""
1. Écrire les expressions booléennes vraies si et seulement si :
(a) L’entier a est pair et compris entre 0 inclus et 20 exclu.
--> a % 2 == 0 and 0 <= a < 20
(b) Les caractères x et y correspondent à la même lettre, l’une en minuscule, l’autre en majuscule
(attention on ne sait pas dans quel ordre).
--> abs(ord('x') - ord('y')) == 32
(c) Parmi les entiers a et b, au moins un est multiple de 2, et aucun n’est multiple de 3. Indice
: il y a une astuce pour éviter de devoir lister tous les cas !
--> a * b % 2 == 0 and a * b % 6 != 0
(d) x est un mot de 6 caractères commençant par une voyelle majuscule. On interdit ici d’utiliser
l’opérateur in.
--> len(x) == 6 and (x[0] == "A" or x[0] == "E" or x[0] == "O" ...)
2. Écrire la négation de ces expressions booléennes, simplifiée au maximum (pas d’opérateur not).
"""


# EXERCICE 2 : DES MOTS (4 points)
def ex2():
    print("Tape des mots(stop pour arreter)")
    reponse = input("? ")
    mot_long = reponse
    mot_court = reponse
    if reponse == "stop":
        """"""
    else:
        while reponse != "stop":
            reponse = input("? ")
            if len(reponse) >= len(mot_long):
                mot_long = reponse
            elif len(reponse) < len(mot_court):
                mot_court = reponse
        print("Mot le plus long : " + mot_long)
        print("Mot le plus court : " + mot_court)


# EXERCICE 3 : SUITE DE HERON (5 points)
def int_sqrt(a):
    entier = 1
    while entier**2 <= a:
        entier += 1
    return entier - 1


def heron_sqrt(a, n):
    x = int_sqrt(a)
    terme = 1
    while terme < n:
        x = (x + a / x) / 2
        terme += 1
    return x


# print(heron_sqrt(5, 3))


def heron_rank(a, p):
    n = 1
    while heron_sqrt(a, n) ** 2 - a < float(p):
        n += 1
    return n


# print(heron_rank(5, 0.01))


def ex3():
    print("Estimation de la racine carre")
    rejouer = True
    while rejouer:
        entier = int(input("a >= 1 ? "))
        while entier < 1:
            entier = int(input("a >= 1 ? "))
        precision = input("precision ? : ")
        rang = heron_rank(entier, precision)
        print("Precision de " + str(precision) + " obtenue au rang " + str(rang))
        print(
            "Carre de l'estimation de rang "
            + str(rang)
            + " = "
            + str(heron_sqrt(entier, rang) ** 2)
        )
        replay = input("Veux-tu rejouer (oui/non)? : ")
        if replay == "non":
            rejouer = False
    print("C'est fini")


# EXERCICE 4 : PENDU (7 points)
def lit_lettre():
    lettre = input("lettre = ? ")
    while lettre < "A" or lettre > "Z":
        lettre = input("lettre = ? ")
    return lettre


def compte_lettre(mot, lettre):
    compteur = 0
    for l in mot:
        if l == lettre:
            compteur += 1
    return compteur


def affiche_mot(mot, connues):
    tiret = ""
    for lettre in mot:
        if lettre in connues:
            tiret += lettre
        else:
            tiret += "-"
    return tiret


# print(affiche_mot("BONJOUR", ["B", "O"]))


def victoire(secret, essais):
    resultat = affiche_mot(secret, essais)
    if "-" not in resultat:
        return True
    else:
        return False


# print(victoire("BONJOUR",["B","O","N","J","U","R"]))

liste_mot = ["BONJOUR", "BONNE", "LUUNPL", "UGA"]


def mot_secret(diff):
    import random

    difficulte = random.randint(0, diff - 1)
    li = []
    for mot in liste_mot:
        if len(mot) <= difficulte:
            li.append(mot)
    hasard = random.randint(0, len(li) - 1)
    return li[hasard]


# print(mot_secret(10))


def erreurs(secret, essais):
    li = []
    for lettre in essais:
        if lettre not in secret:
            li.append(lettre)
    return li


# print(erreurs("CHATEAU",["E","A","X","R","T","S"]))


def ex4():
    rejouer = True
    while rejouer:
        print("************")
        print("Jeu du pendu")
        print("************")
        diff = int(input("Niveau de difficulte? : "))
        essai = diff - 1
        print("Tu as droit a", essai, "erreurs")
        # Set up
        mot_a_trouver = mot_secret(diff) 
        

#print(ex4())