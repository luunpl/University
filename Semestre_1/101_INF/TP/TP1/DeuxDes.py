# Premier
premier = int(input("Donner la valeur du premier dé : "))
if 1 <= premier <= 6:
    print("La valeur du premier de est correcte")
    # Deuxieme
    deuxieme = int(input("Donner la valeur du deuxieme de : "))
    if 1 <= deuxieme <= 6:
        print("La valeur du deuxieme de est correcte")
        # Ordre
        if premier < deuxieme :
            print("Les des classes en ordre decroissant sont :", deuxieme, premier)
        else:
            print("Les des classes en ordre decroissant sont :", premier, deuxieme)