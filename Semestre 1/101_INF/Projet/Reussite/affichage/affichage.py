#!/usr/bin/env python3

from random import choice
from turtle import *
fenetre = Screen()  # la fenetre d'affichage

valeurs  = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'V', 'D', 'R', 'A']
couleurs = ['P', 'C', 'K', 'T']

# On charge toutes les images des cartes dans le dictionnaire _carte_
carte = {}
for c in couleurs:
    for v in valeurs:
        fichier = "imgs/carte-" + v + '-' + c + '.gif'
        carte[c, v] = fichier
        fenetre.register_shape( fichier ) # nouvelle forme pour le pointeur

# On charge aussi l'image du dos des cartes
dos = "imgs/carte-dos.gif"
fenetre.register_shape( dos )


# coordonnées de démarrage
xinit = -300
yinit =  100

largeur_carte = 44
hauteur_carte = 64
separation = 5      # espace à laisser entre les cartes



up()          # on ne trace pas les déplacement
speed(3)      # changer la vitesse d'affichage 0-10

tampons = {}  # dictionnaire pour se souvenir où on a placé les cartes

# Affichage de toutes les cartes dans l'ordre
y = yinit
for c in couleurs:
    x = xinit

    for v in valeurs:
        print ("Affichage de", v, "-", c, "à la position", (x,y))

        shape( dos )      # pour faire joli: on affiche le dos des cartes pendant
                          # le déplacement de la tortue
        goto (x, y)                 # on déplace la tortue à l'endroit voulu
        shape( carte[c, v] )      # on change la "forme" de la tortue pour
                                    # l'image de la carte correspondante
        tampons[c, v] = stamp()  # on "tamponne" la forme et on sauvegarde le
                                    # numéro du tampon

        x = x + largeur_carte + separation

    y = y - hauteur_carte - separation

hideturtle()  # on cache la tortue

print (tampons)

# On efface toutes les cartes dans un ordre aléatoire
while tampons != {}:
    v = choice (valeurs)   # valeur au hasard
    c = choice (couleurs)  # couleur au hasard

    if (c, v) in tampons:   # si on n'a pas déjà effacé le tampon
        print ("Efface la carte", v, "-", c)
        clearstamp ( tampons[c, v] )  # on l'efface
        tampons.pop ((c, v))            # puis on l'enlève du dictionnaire

goto(0,0)
write("Cliquez dans la fenêtre pour terminer.", align='center')
exitonclick() # on attend un clic et on ferme la fenetre
