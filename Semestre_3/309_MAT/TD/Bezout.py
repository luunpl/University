# Bezout naif
def Bezout_Naif(a, b):
    x_ligne1 = 1
    x_ligne2 = 0
    y_ligne1 = 0
    y_ligne2 = 1
    reste = a % b
    
    # Boucle principal 
    while reste != 0:
        
        fois = a // b
        x_ligne3 = x_ligne1 - fois*x_ligne2
        y_ligne3 = y_ligne1 - fois*y_ligne2
        
        # Nouvelle valeur
        x_ligne1 = x_ligne2
        y_ligne1 = y_ligne2
        x_ligne2 = x_ligne3
        y_ligne2 = y_ligne3
        a = b
        b = reste
        
        reste = a % b
        print(x_ligne3, y_ligne3)
        
    return x_ligne3, y_ligne3

# Bezout recursif
def Bezout_Recursif(a, b, x_ligne1 = 1, x_ligne2 = 0, y_ligne1 = 0, y_ligne2 = 1):
    print(x_ligne2, y_ligne2)
    reste = a % b
    fois = a // b
    
    if reste == 0:
        return x_ligne2, y_ligne2
    
    return Bezout_Recursif(b, reste, x_ligne2, x_ligne1 - fois*x_ligne2, y_ligne2, y_ligne1 - fois*y_ligne2)

# Bezout de Monsieur
    
print(Bezout_Naif(15, 19))

print(Bezout_Recursif(15, 19))

