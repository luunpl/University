"""
Ecrire un programme qui:

- demande à l'utilisateur un premier entier en affichant "Entier a=?"

- demande à l'utilisateur un deuxième entier en affichant "Entier b=?"

- Si la somme des deux entiers est supérieure ou égale à 100, le programme affiche "La somme depasse 100". Sinon,
le programme affiche "La somme est (*véritable valeur de a+b*)."

Exemples d'éxecution :

Exemple 1:

Entier a=? *l'utilisateur entre 5*
Entier b=? *l'utilisateur entre 7*
La somme est 12.

Exemple 2:

Entier a=? *l'utilisateur entre 90*
Entier b=? *l'utilisateur entre 12*
La somme dépasse 100.
"""

a = int(input("Entier a=?"))
b = int(input('Entier b=?'))
if a + b >= 100:
    print('La somme dépasse 100.')
else:
    print('La somme est', a + b)
