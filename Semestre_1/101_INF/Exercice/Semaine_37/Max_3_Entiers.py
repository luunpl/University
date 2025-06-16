"""
Ecrire un programme qui:

affiche le titre "Maximum de trois entiers",
puis qui demande successivement trois entiers à l'utilisateur,
puis qui affiche "Le maximum est" suivi de la valeur du maximum des trois entiers fournis.
Pour les phrases à afficher, vous suivrez le modèle de l'exemple suivant:

Maximum de trois entiers
1er entier= * l'utilisateur tape 3*
2eme entier= * l'utilisateur tape 9*
3eme entier= * l'utilisateur tape -4*
Le maximum est : 9
"""

print("Maximum de trois entiers")
x = int(input("1er entier = "))
y = int(input("2eme entier = "))
z = int(input("3eme entier = "))
if x > y:
    if x > z:
        print('Le maximum est :', x)
    else:
        print('Le maximum est :', z)
else:
    if y > z:
        print('Le maximum est :', y)
    else:
        print('Le maximum est :', z)
