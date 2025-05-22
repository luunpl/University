"""
1) Ecrire une fonction moyenne qui prend en paramètre deux notes, ainsi qu'un paramètre optionnel que l'on appelle bonus et dont la valeur par défaut est 0. La fonction doit renvoyer la moyenne de l'étudiant calculée ainsi: d'abord, on calcule la moyenne "normale" entre les deux notes, puis on ajoute le bonus. Attention, la moyenne renvoyée ne devra pas dépasser 20, même si le calcul expliqué précédemment donne un nombre strictement supérieur à 20.

Exemples:
moyenne(12,14) vaut 13.0
moyenne(12,14,1) vaut 14.0 (car 13 + 1)
moyenne(18,19,2) vaut 20

2) Supposons que l'on joue à un jeu où chaque manche se déroule de la manière suivante: d'abord, on lance un dé, et son résultat donne le nombre de points en jeu. Ensuite, le joueur peut, s'il le souhaite, déclencher son bonus "compte double" ou son bonus "compte triple". Ensuite, le joueur répond à un certain nombre de questions, et calcule son pourcentage de bonnes réponses. Les points attribués au joueur pour cette manche sont alors calculés en fonction du pourcentage de bonnes réponses et du nombre de points en jeu arrondi à l'entier le plus proche (par exemple, avec 50% de bonnes réponses et 6 points en jeu, le joueur obtient 3 points; avec 45% de bonnes réponses et 8 points en jeu, le joueur obtient 4 points). Enfin, ce nombre de points est éventuellement multiplié par deux ou trois si le bonus correspondant a été utilisé.

Ecrire une fonction points_manche qui prend en paramètre le pourcentage, le nombre de points en jeu, et comme paramètre optionnel le multiplicateur (qui doit valoir 1 par défaut, mais qui vaudra 2 lors d'un compte double et 3 lors d'un compte triple), et qui calcule le nombre de points en jeu. Vous utiliserez la fonction round pour arrondir, par exemple round(3.6) renvoie 4.

Exemples:
points_manche(40,6) vaut 2
points_manche(45,8) vaut 4
points_manche(50,9,2) vaut 8
points_manche(20,3,3) vaut 3

3) Ecrire une fonction division_arrondi qui prend en paramètre un numérateur, un dénominateur, et comme paramètres optionnels un booléen arrondi (valant False par défaut) et un entier decimales (valant 0 par défaut) et qui calcule la valeur de la fraction numerateur/denominateur (sauf si le dénominateur est nul, auquel cas votre fonction affichera un message d'erreur et ne renverra rien). Si le booléen arrondi vaut False, la fonction renverra ce résultat sans l'arrondir (si decimales est précisé lors de l'appel, on l'ignorera). Si le booléen arrondi vaut True, le résultat sera arrondi au nombre de décimales demandé (par défaut, à l'entier le plus proche). Pour faire vos arrondis, vous utiliserez round(nombre_a_arrondir, nombre_de_decimales).

Exemples:
division_arrondi(1,3) vaut 0.3333333333333333
division_arrondi(1,3,arrondi=True, decimales=2) vaut 0.33
division_arrondi(15,8) vaut 1.875
division_arrondi(15,8, True) vaut 2
division_arrondi(15,8, arrondi=True, decimales=2) vaut 1.88
"""


def moyenne(note1, note2, bonus=0):
    return ((note1 + note2) / 2) + bonus if ((note1 + note2) / 2 + bonus) <= 20 else 20


# print(moyenne(18,19, 2))

def points_manche(percentage, point, player=1):
    return round((percentage / 100) * point) * player


# print(points_manche(50, 9, 2))

def division_arrondi(numerateur, denominateur, arrondi=False, decimales=0):
    if denominateur != 0:
        return round((numerateur / denominateur), decimales) if arrondi else numerateur / denominateur

# print(division_arrondi(1,3, True, 2))
