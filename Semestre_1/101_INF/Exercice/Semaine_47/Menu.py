"""
Un restaurant possède trois menus : le Basique à 9 euros, le Gourmand à 15 euros et le Complet à 19 euros. Pour chacun des menus, le client peut choisir de rajouter une boisson à 4 euros. De plus, le client peut choisir un supplément fromage et/ou un supplément café, chaque supplément coûtant 1,50 euros.

Écrire une fonction prix_menu qui prend comme argument le nom du menu (chaîne de caractères), puis deux arguments optionnels : un booléen avecBoisson dont la valeur par défaut est False, et un entier nb_supplement qui doit valoir 0 par défaut. La fonction doit renvoyer le prix du menu correspondant.
Écrire une fonction table_Dupont qui ne prend aucun argument et qui renvoie le prix total de l’addition pour la table des Dupont :
Jacqueline a choisi seulement un menu Basique,
Michel a pris un menu Gourmand avec boisson,
Johanna a choisi un menu Basique avec suppléments fromage et café,
et Antoine a choisi un menu Basique avec boisson et supplément café.
"""


def prix_menu(nomMenu, avecBoisson=False, nb_supplement=0):
    prix_total = 0
    # Menu
    if nomMenu == "Basique":
        prix_total += 9
    elif nomMenu == "Gourmand":
        prix_total += 15
    elif nomMenu == "Complet":
        prix_total += 19
    # Boisson
    if avecBoisson:
        prix_total += 4
    # Nb_sup
    prix_total = prix_total + 1.5 * nb_supplement
    # Total
    return prix_total


def table_Dupont():
    Jacqueline = prix_menu(nomMenu="Basique")
    Michel = prix_menu(nomMenu="Gourmand", avecBoisson=True)
    Johanna = prix_menu(nomMenu="Basique", nb_supplement=2)
    Antoine = prix_menu(nomMenu="Basique", avecBoisson=True, nb_supplement=1)
    return Jacqueline + Michel + Johanna + Antoine
