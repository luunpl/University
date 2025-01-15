"""
Partie 1: En 2D

 Écrire une fonction coord_centre_cercle qui prend en arguments les coordonnées x1, y1, x2, y2 de deux points diamétralement opposés sur un cercle (par exemple, comme sur la figure (a)), et qui renvoie les coordonnées x, y du centre du cercle.
 Écrire une fonction coord_bas_losange qui prend en arguments les coordonnées x1,y1,x2,y2 de deux points placés sur un losange vertical comme à la figure (b) (le premier sur le sommet gauche, le second sur le sommet supérieur) et qui renvoie les coordonnées x, y du sommet inférieur du losange.
Écrire une fonction coordDEF qui ne prend pas d'argument, et qui demande à l'utilisateur les coordonnées des points A, B, C de la figure (c) (dans cet ordre, en commençant pour chaque point par l'abscisse puis l'ordonnée), puis qui renvoie 6 valeurs de retours xD, yD, xE, yE, xF, yF correspondant aux coordonnées des points D, E, F dans cet ordre.
Partie 2: En 3D

Note: la valeur de π est disponible dans le module math avec math.pi

Écrire une fonction volume_sphere qui prend en argument le rayon r de la sphere (qui vaudra 1 par défaut) et qui renvoie son volume : V = 4πr3/3.
Écrire une fonction volume_cone qui prend en argument la hauteur h ainsi que le rayon r de la base d’un cône de révolution (r vaudra 1 par défaut) et qui renvoie le volume du cône : V = πr2h/3.
Écrire une fonction volume_figure qui renvoie le volume total de la figure (d). Votre fonction ne prendra pas d'argument mais demandera à l'utilisateur (dans cet ordre):
le rayon de la sphère de gauche,
puis le rayon de la sphère du milieu (qui est le même que celui du cône au-dessus),
puis le rayon de la sphère de droite,
puis le rayon, puis la hauteur du cône de devant,
et enfin la hauteur du cône au-dessus de la sphère.
"""
import math


def coord_centre_cercle(x1, y1, x2, y2):
    return (x1 + x2) / 2, (y1 + y2) / 2


def coord_bas_losange(x1, y1, x2, y2):
    return x2, y1 - (y2 - y1)


def coordDEF():
    xA = float(input())
    yA = float(input())
    xB = float(input())
    yB = float(input())
    xC = float(input())
    yC = float(input())
    xD, yD = coord_centre_cercle(xA, yA, xB, yB)
    xE, yE = coord_bas_losange(xA, yA, xB, yB)
    xF, yF = coord_centre_cercle(xE, yE, xC, yC)
    return xD, yD, xE, yE, xF, yF


def volume_sphere(r=1):
    return 4 * math.pi * (r ** 3) / 3


def volume_cone(h, r=1):
    return math.pi * (r ** 2) * h / 3


def volume_figure():
    r_gauche = float(input())
    r_milieu = float(input())
    r_droite = float(input())
    r_cone_sup = float(input())
    hauteur_cone_sup = float(input())
    hauteur_cone_dessus = float(input())
    return volume_sphere(r_gauche) + volume_sphere(r_milieu) + volume_sphere(r_droite) + volume_cone(hauteur_cone_sup, r_cone_sup) + volume_cone(hauteur_cone_dessus, r_milieu)
