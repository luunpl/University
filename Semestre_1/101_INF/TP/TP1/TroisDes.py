# Premier
premier = int(input("Donner la valeur du premier dé : "))
if 1 <= premier <= 6:
    print("La valeur du premier de est correcte")
    # Deuxieme
    deuxieme = int(input("Donner la valeur du deuxieme de : "))
    if 1 <= deuxieme <= 6:
        print("La valeur du deuxieme de est correcte")
        # Troisieme
        troisieme = int(input("Donner la valeur du troisieme de : "))
        if 1 <= troisieme <= 6:
            print("La valeur du troisieme de est correcte")
            # Ordre
            if premier > deuxieme > troisieme:
                print("Les des classes en ordre decroissant sont :", premier, deuxieme, troisieme)
            elif premier > troisieme > deuxieme:
                print("Les des classes en ordre decroissant sont :", premier, troisieme, deuxieme)
            elif deuxieme > premier > troisieme:
                print("Les des classes en ordre decroissant sont :", deuxieme, premier, troisieme)
            elif deuxieme > troisieme > premier:
                print("Les des classes en ordre decroissant sont :", deuxieme, troisieme, premier)
            elif troisieme > premier > deuxieme:
                print("Les des classes en ordre decroissant sont :", troisieme, premier, deuxieme)
            elif troisieme > deuxieme > premier:
                print("Les des classes en ordre decroissant sont :", troisieme, deuxieme, premier)

# Gagne
if premier == 4 and deuxieme == 2 and troisieme == 1:
    print("Vous avez gagné !")
else:
    print("Perdu")
