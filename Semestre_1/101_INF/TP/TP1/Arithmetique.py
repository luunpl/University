# Calcul simple
print("Calcul simple de 2 nombres entiers")
a = int(input("Donner un nombre : "))
b = int(input("Donner un autre nombre : "))
c = a + b
print("La somme est : ", c)
print("La difference est : ", a - b)
print("Le produit est : ", a * b)

# Identique
print("\nProgramme pour checker identification")
nombre1 = int(input("Donner un nombre : "))
nombre2 = int(input("Donner un autre nombre : "))
if nombre1 == nombre2:
    print("Les 2 nombres sont egaux")
else:
    print("Les 2 nombres sont differents")
    
# Div et Mod
print("\nCalcul le quotient")
dividende = int(input("Donner un nombre : "))
diviseur = int(input("Donner un autre non nul nombre : "))
print("Le quotient de", dividende, "par", diviseur, "est", dividende // diviseur, ". Le reste est", dividende % diviseur)