def pgcd_recursif(a, b):
     # Afficher le tuple
    print(a,b)
    # Pgcd
    if b == 0:
        return a
    else:
        return pgcd_recursif(b, a%b)

def pgcd_binare(a, b):
    pu2 = 1
    while a % 2 == 0 and b % 2 == 0:
        # Afficher le tuple
        print(a,b)
        
        pu2 = 2*pu2
        a = a / 2
        b = b / 2
    
    if b%2 == 0:
        a,b = b,a
    
    while a > 0:
        while a%2 == 0:
            a = a / 2
        
        if a < b:
            b = a
    
    return b*pu2


        
#print(pgcd_binare(15, 19))
print(pgcd_recursif(15, 19))
