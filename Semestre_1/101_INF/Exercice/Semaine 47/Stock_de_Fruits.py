"""
Dans cet exercice, nous allons gérer un stock de fruits qui sera représenté par un dictionnaire, dont les clés seront les noms de fruits (au singulier), et les valeurs seront le nombre de fruits correspondant dans le stock. Par exemple, si le stock contient 2 pommes et 6 bananes, il sera représenté par le dictionnaire suivant: {'pomme' : 2, 'banane' : 6}. Pour simplifier l'écriture des exemples, on supposera que ce dictionnaire sera stocké dans une variable appelée stock.

Dans tout l'exercice, le(s) dictionnaire(s) passé(s) en argument ne doi(ven)t pas être modifié(s).

Vous n'êtes pas obligés de traiter les questions dans l'ordre.

Ecrire une fonction ajoute1 qui prend en argument un stock (dictionnaire) et un nom de fruit, et qui renvoie le nouveau stock, dans lequel un fruit du type donné a été ajouté.
Exemples:
ajoute1(stock , 'pomme') renvoie {'pomme' : 3, 'banane' : 6}
ajoute1(stock , 'poire') renvoie {'pomme' : 2, 'banane' : 6, 'poire' : 1}
Ecrire une fonction enleve1 qui prend en argument un stock (dictionnaire) et un nom de fruit, et qui renvoie le nouveau stock, où un fruit du type donné a été enlevé (s'il y avait un stock suffisant). Si le stock de ce fruit tombe à zéro, il faut enlever la clé du dictionnaire. Si le stock n'était pas suffisant, le programme affichera "Erreur: quantité insuffisante de (*nom du fruit*)" et renverra le stock initial non modifié.
Exemples:
enleve1(stock , 'pomme') renvoie {'pomme' : 1, 'banane' : 6}
enleve1(stock , 'poire') affiche "Erreur: Quantité insuffisante de poire" et renvoie {'pomme' : 2, 'banane' : 6}
Ecrire une fonction ajoute qui prend en argument un stock (dictionnaire), un nom de fruit et une quantité q, et qui renvoie le nouveau stock, dans lequel on a ajouté une quantité q du type de fruit précisé.
Exemples:
ajoute(stock , 'pomme', 5) renvoie {'pomme' : 7, 'banane' : 6}
ajoute(stock , 'poire', 4) renvoie {'pomme' : 2, 'banane' : 6, 'poire' : 4}
Ecrire une fonction enleve qui prend en argument un stock (dictionnaire), un nom de fruit et une quantité q, et qui renvoie le nouveau stock où l'on a enlevé la quantité q du type de fruit précisé. De même que pour la fonction enleve1, si le stock de ce fruit tombe à zéro, il faut enlever la clé du dictionnaire. Si le stock n'était pas suffisant, le programme affichera "Erreur: quantité insuffisante de (*nom du fruit*)" et renverra le stock initial non modifié.
Exemples:
enleve(stock , 'pomme', 2) renvoie {'banane' : 6}
enleve(stock , 'banane', 10) affiche "Erreur: Quantité insuffisante de banane" et renvoie {'pomme' : 2, 'banane' : 6}
Ecrire une fonction apres_livraison qui prend en argument un stock (dictionnaire) ainsi que le contenu de la livraison (représenté aussi par un dictionnaire) et qui renvoie le nouveau stock après la livraison (sachant que le contenu de la livraison vient augmenter le stock actuel).
Exemple:
apres_livraison(stock , {'peche' : 4, 'pomme' : 5}) renvoie {'pomme' : 7, 'banane' : 6, 'peche' : 4}
Ecrire une fonction commande qui prend en argument le stock actuel (dictionnaire) ainsi que le stock minimum voulu (dictionnaire aussi) et qui renvoie le dictionnaire correspondant à la commande qu'il faut faire pour obtenir le stock voulu. Si le fruit apparaît déjà en quantité suffisante dans le stock actuel (supérieure ou égal au stock voulu), il ne doit pas apparaître dans la commande.
Exemple:
En supposant que stock_voulu={'pomme': 15, 'orange': 20}, alors commande(stock , stock_voulu) renvoie {'pomme' : 13, 'orange' : 20}.
En supposant que stock_voulu={'pomme': 10, 'banane': 4}, alors commande(stock , stock_voulu) renvoie {'pomme' : 8}.
Ecrire une fonction total qui prend en argument le stock et qui renvoie le nombre total de fruits présents dans le stock (tous types confondus)
Exemple:
total(stock) renvoie 8.
Ecrire une fonction quantite qui prend en argument le stock ainsi qu'une liste de noms de fruits fruits_a_compter, et qui renvoie la quantité de fruits présents dans le stock dont le nom est dans la liste fruits_a_compter.
Exemple:
En supposant que stock_bis={'pomme': 15, 'peche': 4, 'citron': 3, 'orange': 20}, alors quantite(stock_bis , ['pomme', 'citron', 'poire']) renvoie 18.
Ecrire une fonction quantite_agrumes qui prend en argument le stock et qui renvoie la quantité d'agrumes présents dans le stock. Seront considérés comme noms d'agrumes: orange, citron, mandarine, clémentine et pamplemousse (attention à ne pas mettre d'accent à "clémentine" dans votre programme).
Exemple:
En supposant que stock_bis={'pomme': 15, 'peche': 4, 'citron': 3, 'orange': 20}, alors quantite_agrumes(stock_bis) renvoie 23.
"""


def ajoute1(stock, fruit):
    dico = dict(stock)
    if fruit in dico:
        dico[fruit] += 1
    else:
        dico[fruit] = 1
    return dico


# print(ajoute1(stock , 'pomme'))
# print(ajoute1(stock , 'poire'))


def enleve1(stock, fruit):
    dico = dict(stock)
    if fruit in dico:
        dico[fruit] -= 1
        return dico
    else:
        print("Erreur: Quantité insuffisante de", fruit)
        return dico


# print(enleve1(stock , 'poire'))


def ajoute(stock, fruit, q):
    dico = dict(stock)
    if fruit in dico:
        dico[fruit] += q
    else:
        dico[fruit] = q
    return dico


# print(ajoute(stock , 'pomme', 5))
# print(ajoute(stock , 'poire', 4))


def enleve(stock, fruit, q):
    dico = dict(stock)
    if fruit in dico:
        if dico[fruit] < q:
            ""
        else:
            dico[fruit] -= q
        # Si le fuit tombe a zeros
        if dico[fruit] == 0:
            del dico[fruit]
        return dico
    else:
        print("Erreur: Quantité insuffisante de", fruit)
        return dico


def apres_livraison(stock, livraison):
    dico = dict(stock)
    for key in livraison:
        if key in dico:
            dico[key] += livraison[key]
        else:
            dico[key] = livraison[key]
    return dico


def commande(stock, stock_voulu):
    dico = {}
    for key in stock_voulu:
        if key in stock:
            if stock_voulu[key] > stock[key]:
                dico[key] = stock_voulu[key] - stock[key]
        else:
            dico[key] = stock_voulu[key]
    return dico


# stock_voulu={'pomme': 15, 'orange': 20}
# print(commande(stock , stock_voulu))


def total(stock):
    fruit = []
    for key in stock:
        fruit.append(stock[key])
    return sum(fruit)


# print(total(stock))


def quantite(stock, name):
    fruit = []
    for key in stock:
        if key in name:
            fruit.append(stock[key])
    return sum(fruit)


# print(quantite(stock_bis , ['pomme', 'citron', 'poire']) )

def quantite_agrumes(stock):
    agrumes = ['orange', 'citron', 'mandarine', 'clementine', 'pamplemousse']
    return quantite(stock, agrumes)
