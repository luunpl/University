import random
import turtle


# Version textuelle
def initGrilleM(N):
    grille = [[False for x in range(N)] for y in range(N)]
    return grille


# print(initGrilleM(5))

def initGrilleV(N, V):
    grille = initGrilleM(N)
    vivant = 0
    while vivant < V:
        x = random.randint(0, N - 1)
        y = random.randint(0, N - 1)
        if not grille[x][y]:
            grille[x][y] = True
            vivant += 1
    return grille


# print(initGrilleV(5, 4))
def afficher(GRILLE):
    # Afficher
    for ligne in range(len(GRILLE)):
        affiche = ""
        for etat in GRILLE[ligne]:
            affiche += etat
        print(affiche)


def afficheSolution(GRILLE):
    # Transformer
    for i in range(len(GRILLE)):
        for j in range(len(GRILLE)):
            if GRILLE[i][j]:
                GRILLE[i][j] = "*"
            else:
                GRILLE[i][j] = "."
    return GRILLE


Test = afficheSolution(initGrilleV(5, 4))


def grilleEtendue(GRILLE):
    # Ajouter les celles mortes chaque ligne
    for i in range(len(GRILLE)):
        GRILLE[i].insert(0, ".")
        GRILLE[i].insert(len(GRILLE[i]), ".")
    # Ajouter 2 lignes premiere et derniere des celles mortes
    GRILLE.insert(0, ["." for x in range(len(GRILLE) + 2)])
    GRILLE.insert(len(GRILLE), ["." for y in range(len(GRILLE) + 1)])
    return GRILLE


# print(grilleEtendue(Test))

def compteVoisins(grille, i, j):
    vivant = 0
    i += 1
    j += 1
    for x in range(-1, 2):
        for y in range(-1, 2):
            if grille[i + x][j + y] == "*":
                vivant += 1
    return vivant


# print(compteVoisins(grilleEtendue(Test), 0, 1))

def evoluerGrille(GRILLE):
    # Evolution suivi la regle
    for i in range(0, len(GRILLE) - 2):
        for j in range(0, len(GRILLE) - 2):
            if compteVoisins(GRILLE, i, j) not in [2, 3]:
                GRILLE[i][j] = "."
            elif compteVoisins(GRILLE, i, j) == 3:
                GRILLE[i][j] = "*"
    return GRILLE


# print(evoluerGrille(grilleEtendue(Test)))

def nombreVivantes(GRILLE):
    vivant = 0
    for i in range(0, len(GRILLE)):
        for j in range(0, len(GRILLE)):
            if GRILLE[i][j] == "*":
                vivant += 1
    return vivant


# print(nombreVivantes(evoluerGrille(grilleEtendue(Test))))

if __name__ == "__main__":
    print("Une grille carre de taille 5 par 5, avec 7 cellules vivantes")
    GRILLE = afficheSolution(grilleEtendue(initGrilleV(5, 7)))
    print(GRILLE)
    for i in range(1, 11):
        print("C'est la", i, "ieme fois d'evolution")
        a_afficher = evoluerGrille(GRILLE)
        print(afficher(a_afficher))
        print("Le nombre de cellules vivantes est ", nombreVivantes(GRILLE))
        if nombreVivantes(GRILLE) == 0:
            break
