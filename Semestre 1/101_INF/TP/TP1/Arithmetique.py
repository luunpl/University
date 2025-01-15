# Calcul simple
print("Calcul de la somme de 2 nombres entiers")
a = int(input("Donner un nombre : "))
b = int(input("Donner un autre nombre : "))
c = a + b
print("\nLa somme est : ", c, "\n")
print("\nLa difference est : ", a - b, "\n")
print("\nLe produit est : ", a * b, "\n")

# Identique
print("Programme pour checker identification")
nombre1 = int(input("Donner un nombre : "))
nombre2 = int(input("Donner un autre nombre : "))
if nombre1 == nombre2:
    print("Les 2 nombres sont egaux")
else:
    print("Les 2 nombres sont differents\n")
    
# Div et Mod
print("Calcul le quotient")
dividende = int(input("Donner un nombre : "))
diviseur = int(input("Donner un autre non nul nombre : "))
print("Le quotient de", dividende, "par", diviseur, "est", dividende // diviseur, ". Le reste est", dividende % diviseur)