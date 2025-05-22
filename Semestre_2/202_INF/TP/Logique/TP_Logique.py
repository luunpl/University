from Formules import *

#############################################################################################################
#                                        LA BIBILOTEQUE FORMULE                                             #
#############################################################################################################


#####################################
print("Exemples variables :")

# Pour créer une formule contenant uniquement une variable on peut utiliser la fonction "new_variable()"
fx = Formule.new_variable("x")
fy = Formule.new_variable("y")
print(fx)
print(fy)

######################################
print("\nExemples booléen")

# Pour créer une formule contenant uniquement un booléen on peut utiliser la fonction "vrai()" ou la fonction "faux()"
fv = Formule.vrai()
ff = Formule.faux()
print(fv)
print(ff)

########################################
print("\nExemples opérateurs")

# Pour le NON on utilise le -
print(-fy)

# Pour le OU on utilise le +
print(fv+fx)

# Pour le ET on utilise le *
print(fy*fx)

# Pour l'implication on utilise la fonction impl
print(fy.impl(fx))

# Pour l'équivalence on utilise la fonction eq
print(fv.eq(fv))

# On peut combiner ces opérateurs comme on le souhaite
print( (fx.impl(fy).eq( -fx + fy ) ) )

#################################################
print("\nExemples information sur les formules")

print("\nget_variables")
# La fonction get_variables renvoie la liste des variables d'une formule
f = fx+fy+fv+fx
print(f)
print(f.get_variables())

print("\nest_unitaire")
# La fonction est_unitaire permet de savoir si une formule n'est constitué que d'une variable ou d'un bouléen
print(fx.est_unitaire())
print(fv.est_unitaire())
print((fx+fy).est_unitaire())

print("\noperateur")
# La fonction operateur permet de connaitre l'opérateur de la formule
print(fx.operateur())
print(fv.operateur())
print((-fv).operateur())
print((fx+fv).operateur())

print("\nget_val")
# La fonction get_val permet de connaitre la valeur de la formule s'il s'agit d'une formule unitaire
print(fx.get_val())
print(fv.get_val())

print("\nnb_operandes")
# La fonction nb_operandes permet de connaitre le nombre d'opérandes de l'operateur
print(fx.nb_operandes())
print(fv.nb_operandes())
print((-fv).nb_operandes())
print((fx+fv).nb_operandes())

print("\ndecompose")
# La fonction decompose permet de récupérer les sous-formules directe de la formule actuelle dans une liste
# /!\ renvoie une erreur quand appliquée à une formule unitaire
print((-(fv+fx)).decompose()[0])
print((fv+fx).decompose()[0])
print((fv+fx).decompose()[1])


#############################################################################################################
#                                           EXERCICES                                                       #
#############################################################################################################


# Exercice 1 : faire en sorte que la fonction renvoie la formule ( ( x ) OU ( y ) ) ET ( z )
def f_predef():
    """Modifier cette fonction pour qu'elle renvoie le bon résultat"""
    return Formule.vrai()


# Exemple de fonction recursive
def compte_vrai(f):
    """compte le nombre de VRAI dans la formule f"""
    n = f.nb_operandes()
    if n == 0:
        v = f.get_val()
        if v == "VRAI":
            return 1
        else:
            return 0
    elif n == 1:
        f2 = (f.decompose())[0]
        return compte_vrai(f2)
    else:
        [f2, f3] = f.decompose()
        return compte_vrai(f2)+compte_vrai(f3)


# Exercice 2 : faire en sorte que la fonction prenne en entrée le nom d'une variable et renvoie son nombre
# d'occurence dans la formule
def compte_var(f, var):
    """compte le nombre d'apparition de la variable var dans f"""
    return 0


# Exercice 3 : # Exercice 3 : faire en sorte que la fonction suivante prenne en entrée une formule et retourne la chaine de caractère telle que
# les ET soient remplacé par "n", les OU par "u", les NON par "-", les IMPL par =>, les EQ par "<=>",les VRAI par "V"
# et les FAUX par "F". Les noms de variables restent les mêmes.
# Pour éviter tout problème d'interprétation de la formule, on mettra des parenthèses autour des opérandes des opérateurs
# On ne met pas d'espace entre les parenthèse et les formules internes mais on en met entre les opérateurs et leurs opérandes
#
#Exemple:
# joli_string( (fx.impl(fy).eq( -fx + fv ) ) ) -> "((x) => (y)) <=> ((- (x)) u (V))"
# joli_string( fx ) -> "x"
# la chaine de caracteres doit respecter exactement le format demande (y compris les espaces et les majuscules)
def joli_string(f):
    """renvoie une jolie chaine de caractèrepour la formule f """
    return ""

def affiche(f):
    print(joli_string(f))

# Amélioration possible : ne pas mettre de parenthèse autour des variables ou des constante
# (si vous souhaitez coder cette amélioration faites le avec un nom autre que joli_string
# sinon le correcteur automatique considerera votre fonction comme fausse)

# Exercice 4 : Etant donné une formule qui n'utilise que des booleens et pas de variables,
# renvoyer à quelle valeur elle s'évalue
def eval_bool(f):
    """Evalue la formule booléenne donnée"""
    return True


# Exemple d'utilisation des dictionnaire en python
# En python un dictionnaire une structure de donnée qui associe des clés à des éléments sous la forme suivante :
# mondico = {cle1: elt1, cle2: elt2, cle3: elt3...}
# Les clés peuvent être des nombre ou des chaines de caractères
# On utilisera la structure de dictionnaire pour attribuer des valeurs booléennes aux différentes variables
# La suite donne un exemple de ce qu'on peut faire avec un dictionnaire
assignation = {'x': 'VRAI', 'y': 'FAUX', 'z': 'FAUX'}
print('\nLa variable x a pour valeur : ' + assignation['x'])
print('La variable y a pour valeur : ' + assignation['y'])
print('La variable z a pour valeur : ' + assignation['z'])


# Exercice 5 : Etant donné une formule et une assignation des variables renvoie son évaluation
def eval(f, assignation):
    return True


# Exercice 6 : Etant donné une formule et un nombre n, renvoie une assignation des variables
# telle que pour tout n entre 0 et 2^(nombre de variables)-1 l'assignation obtenue soit différente des autres.
# Pour ce faire on va utiliser l'écriture binaire de n
# Par exemple, si n = 3 et f.get_variables()=["x","y","z"]
# comme l'écriture binaire de 3 est 011 (autant de bits que de variables)
# on va avoir pour dictionnaire {"x":"VRAI, "y:"VRAI", "z":"FAUX"} (on comence par les bits de poids faible)
## vous devez utiliser la methode 'sort' pour que les variables soit triée dans l'ordre alphabetique : 'liste.sort()' 
def int_to_assign(f, n):
    return {}


# Exercice 7 : Etant donné une formule, renvoie vrai s'il existe une assignation de ses variables
# telle qu'elle sévalue à VRAI
def satis(f):
    return True


# Exercice 8 : Etant donné deux formules f1 et f2 renvoie vrai si elles sont équivalentes
# c'est à dire si toute assignation de variables s'évalue à la même valeur pour f1 et f2
# On supposera que f1 et f2 ont le même ensemble de variables
def equiv(f1, f2):
    return True

