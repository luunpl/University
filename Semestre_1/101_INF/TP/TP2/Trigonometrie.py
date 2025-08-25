import math 
import random

# Ex1a
hypotenuse = float(input("Entrez la longueur de l'hypotenuse : "))
angle_degrees = float(input("Entrez la mesure de l'angle en degrés : "))
cote1 = hypotenuse * math.cos(math.radians(angle_degrees))
cote2 = hypotenuse * math.sin(math.radians(angle_degrees))
print("Les deux côtés sont:", cote1, "et", cote2)

# Ex1b
if cote1 ** 2 + cote2 ** 2 == hypotenuse ** 2:
    print("Les côtés forment un triangle rectangle.")
else:
    print("Les côtés ne forment pas un triangle rectangle.")
    
# Ex2
while True:
    a = float(input("Entrez la valeur de a : "))
    b = float(input("Entrez la valeur de b : "))
    c = float(input("Entrez la valeur de c : "))
    delta = b ** 2 - 4 * a * c
    if delta >= 0:
        racine1 = (-b + math.sqrt(delta)) / (2 * a)
        racine2 = (-b - math.sqrt(delta)) / (2 * a)
        print("Les racines du polynôme sont:", racine1, "et", racine2)
        break
    else:
        print("La valeur de delta est négative. Veuillez réessayer.")
