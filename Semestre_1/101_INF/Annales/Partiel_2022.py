import random
import math

# Exercice 2
def filtrage():
    lettre = input("lettre ? ")
    mot = input("Mot commence par " + str(lettre) + " ? ")
    while mot[0] != lettre :
        mot = input("Mot commence par " + str(lettre) + " ? ")
    print("Ton mot :", mot)
    
#print(filtrage())

def deviner():
    bingo = random.randint(1, 100)
    essaie = 1
    nombre = int(input("Devine mon nombre? "))
    while nombre != bingo:
        if nombre < bingo:
            nombre = int(input("Tu chauffes, essaie encore? "))
        elif nombre > bingo:
            nombre = int(input("Tu refroidis, essaie encore? "))
        essaie += 1
    print("Victoire en " + str(essaie) + " essais")

#print(deviner())                           

# Exercice 3
# 1
def zero(n):
    for chiffre in str(n):
        if chiffre == "0":
            return True
    return False

# 2
def prod(n):
    produit = 1
    for chiffre in str(n):
        produit *= int(chiffre)
    return produit

#print(prod(1234))

# 3
def fecondite(n):
    fecondite = 0
    terme = n
    produit = prod(terme)
    while not zero(produit):
        produit += prod(produit)
        fecondite += 1
    return fecondite

#print(fecondite(7))

# 4
def boucle():
    nombre = int(input("Saisi un nombre : "))
    while nombre > 0:
        print("Fecondite de", nombre, "est", fecondite(nombre))
        nombre = int(input("Saisi un nombre : "))
#print(boucle())

# Exercice 4
# 1
def taquinAlea(n):
    li = [i for i in range (0, n*n)]
    random.shuffle(li)
    return li

#print(taquinAlea(3))

# 2
def affiche(taq):
    # Chercher le nombre de ligne
    n = int(len(taq) ** 0.5) 
    # Print n lignes
    taq_str = [' ' if x == 0 else str(x) for x in taq]
    for i in range(0, len(taq_str), n):
        print('.'.join(taq_str[i:i+n]) + '.')

#affiche(taquinAlea(3))

# 3
def coordXY(numero, taq):
    n = int(len(taq) ** 0.5)
    return [taq.index(numero)//n, taq.index(numero)%n]

