from turtle import *

# Partie A : plateau de jeu et listes
# 1
def init(n):
    depart = [i for i in range(n, 0, -1)]
    return [depart, [], []]


# 2
def nbDisques(plateau, numtour):
    return len(plateau[numtour])


# 3
def disqueSup(plateau, numtour):
    if numtour < 0 or numtour > 2 or nbDisques(plateau, numtour) == 0:
        return -1
    return plateau[numtour][0]


# 4
def posDisque(plateau, numdisque):
    for tour in range(3):
        for disque in plateau[tour]:
            if disque == numdisque:
                return tour
    return -1


# 5
def verifDepl(plateau, nt1, nt2):
    if nbDisques(nt2) == 0 or disqueSup(plateau, nt2) > disqueSup(plateau, nt1):
        return True
    return False


# 6
def verifVictoire(plateau, n):
    return plateau == init(n)[::-1]


# Partie B: graphisme avec Turtle
# Set up Turtle


# 1 
def dessinePlateau(n):
    penup()
    goto(-300, -200)
    pendown()
    # Plateau
    forward(100)

mainloop()

# Test
"""
ini = init(3)
print(ini)
print(nbDisques(ini, 0))
print(disqueSup(ini, 0))
print(posDisque(ini, 1))
print(posDisque(ini, 2))
print(verifVictoire(ini, 3))
"""
print(dessinePlateau(3))