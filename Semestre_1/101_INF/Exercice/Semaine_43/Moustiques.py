"""
Depuis le début de l’année 2017, deux scientifiques Marc et Alice étudient l’évolution d’une population de moustiques
sur l’île Chépaou. Ils ont réussi à obtenir l’estimation suivante sur l’évolution de la population :
si la population contient x moustiques au cours d’une année, alors il y a aura 1.09x − 200 moustiques l’année suivante.
Par contre, ils ne sont pour l’instant pas d’accord sur l’estimation de la population en 2017 :
ils s’accordent seulement sur le fait que ce nombre est compris entre 8 000 et 12 000.
Il faudra donc considérer cette donnée comme une variable.

Écrire une fonction f qui prend en argument le nombre x de moustiques à une certaine année et qui renvoie le nombre de moustiques l’année suivante. La valeur de retour de f doit arrondir la réponse à l'entier inférieur. Comme les valeurs obtenues seront toujours positives, vous pouvez utiliser au choix int(..) ou la fonction floor(...) du module math. Exemple: int(4.5) vaut 4 et math.floor(6.75) vaut 6.
Écrire une fonction nb_moustiques qui prend en arguments nb_debut, le nombre estimé de moustiques en 2017, et un entier annee_voulue. La fonction doit renvoyer le nombre de moustiques qu’il y aura en annee_voulue.
Écrire une fonction annee_atteindra qui prend en argument un entier seuil et un entier nb_debut (qui correspondra au nombre de moustiques en 2017) et qui renvoie l’année à partir de laquelle le nombre de moustiques sera supérieur ou égal à seuil.
Question non-évaluée par Caseine: Écrire un programme principal qui demande à Marc son estimation du nombre de moustiques, puis à Alice la sienne. Votre programme demandera ensuite une année et affichera le nombre de moustiques qu’il y aura cette année-là, selon l’estimation de Marc puis selon celle d’Alice. Enfin, votre programme demandera un seuil et affichera en quelle année on atteint ce seuil, en fonction de chacune des deux estimations.
"""
import math


def f(x):
    return math.floor(1.09 * x - 200)


def nb_moustiques(nb_debut, annee_voulue):
    i = 2017
    while i < annee_voulue:
        nb_debut = f(nb_debut)
        i += 1
    return nb_debut


def annee_atteindra(seuil, nb_debut):
    i = 0
    while nb_debut < seuil:
        nb_debut = f(nb_debut)
        i += 1
    return 2017 + i
