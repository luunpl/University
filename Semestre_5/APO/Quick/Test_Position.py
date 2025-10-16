
""" Le contenu de ce fichier a pour but d'évaluer une expression arithmétique.
 * 
 * - L'expression est donnée sous forme d'une chaîne de caractères qu'il faudra considérer comme un tableau.
 * - L'expression ne contient que des entiers et des opérateurs +, -, * ou /.
 * - L'expression ne contient pas de parenthèse ou de nombre à virgule\n" +
 * (mais le résultat de l'expression peut être un réel, par exemple 10/3 =
 * 3.33333...)
 * Note: On ne tiendra pas compte de la priorité des opérateurs: 3+2*2
 * retournera 10 et non 7.
 *
 * Exemple avec l'expression "15-3*10", on aura le tableau expression:
 *        -------------------------------------------
 * valeur | '1' | '5' | '-' | '3' | '*' | '1' | '0' |
 *        |-----|-----|-----|-----|-----|-----|-----|
 * indice |--0--|--1--|--2--|--3--|--4--|--5--|--6--|
 *        -------------------------------------------
 *
 * Le résultat de l'appel à la fonction evalue sur le tableau précédant devra
 * être 120
 * (rappel: on ne tien pass compte de la priorité des opérateurs)
 *
 *
 * /!\ Ne pas ajouter de fonction
 *
 * /!\ Ne rien écrire en dehors des fonctions
 *
 * /!\ Correction automatique: n'envoyer votre code QUE lorsque qu'il compile !!
"""

"""
Expression sous forme de tableau de caractères (cf exécution).
Expression est une variable globale qui peut être lue et modifiée dans chacune des fonctions ci-dessous.
"""
expression = []

"""
indiceCourant: indice utilisé pour parcourir l'expression: il gardera la valeur que vous lui donnerez dans une méthode.
Il est consiellé de l'utiliser comme marqueur de lecture de l'expression à évaluer (indice courant du tableau)
"""
indiceCourant = 0

def valeur(v1, operateur, v2):
    """
    Calcule et renvoie la valeur de l'expression v1 operateur v2
    Renvoie 0.0 si l'opérateur n'est aucun de ceux autorisés

    Exemples:
    v1 = 4, v2 = 6 et operateur = '+', renvoie 10
    v1 = 4, v2 = 2 et operateur = '-', renvoie 2
    """
    # 1- À Compléter ici
    if operateur == '+':
        return v1 + v2
    if operateur == '-':
        return v1 - v2
    if operateur == '*':
        return v1 * v2
    if operateur == '/':
        return v1 / v2
    return "0.0"


def lireOperateur():
    """
    Renvoie l'opérateur situé à la place indiceCourant du tableau expression sous
    forme de caractère (str).

    Si aucun élément trouvé ou si l'élément trouvé n'est pas un opérateur permis
    (+, -, * ou /),
    renvoie le caractère 'N'
    """
    global indiceCourant
    global expression
    # 2- À Compléter ici
    if expression[indiceCourant] in ['+', '-', '*', '/']:
        return expression[indiceCourant]
    else:
        return 'N'

def lireOperande():
    """
    Lit l'opérande (i.e. le nombre) situé à la case indiceCourant du tableau expression.
    Attention : il peut s'agir d'un nombre à plusieurs chiffres !
    
    Tip: pour savoir si un caractère est un chiffre, on peut utiliser la méthode "isdigit()"
    Par exemple avec l'expression ['3', '5', '+', '2']
        expression[0].isdigit() -> True  # parce que '3' est un chiffre
        expression[2].isdigit() -> False # parce que '+' n'est pas un chiffre
        
    Tip: pour convertir un caractère en entier, on utilise le cast explicite:
        i: int
        c: char
        c = '5'
        i = (int)(c) # i prend la valeur du chiffre 5
    """
    global indiceCourant
    global expression
    # 3- À Compléter ici
    c = ''
    while expression[indiceCourant].isdigit():
        c += expression[indiceCourant]
        indiceCourant += 1
    return c

def evalue():
    """
    Evalue l'expression globae et renvoie son résultat sous forme de nombre réel.
    """
    global indiceCourant
    global expression
    
    indiceCourant = 0
    tailleDuTableau = len(expression)
    resultat = 0.0
    # 4- À Compléter ici
    while indiceCourant != tailleDuTableau:
        a = lireOperande()
        print(a)
        op = lireOperateur()
        print(op)
        indiceCourant += 1
        b = lireOperande()
        print(b)
        resultat += valeur(float(a), op, float(b))
        print(resultat)
        print("Indice courant:", indiceCourant)
    return resultat
    
def expression_as_table(exp):
    """ Fonction qui converti l'expresin en tableau pour une représentation plus facile à l'écran """
    # /!\ Ne pas modifier cette fonction 
    res = "Expression: \n"
    res += "-"
    # Ligne supérieure de la table
    for _ in expression:
        res += "------"
    res += "\n"
    # Ligne des caractères de l'expression
    res += "|"
    for c in expression:
        res += f" '{c}' |"
    res += "\n"
    # Ligne de séparation
    res += "|"
    for _ in expression:
        res += "-----|"
    res += "\n"
    # Ligne des indices
    res += "|"
    for i in range(len(expression)):
        res += f"--{i}--|"
    res += "\n"
    # Ligne inférieure de la table
    res += "-"
    for _ in expression:
        res += "------"
    return res

if __name__ == "__main__":

    # Exécutez les tests proposés. 
    print("--- Test de la méthode valeur")
    print("valeur(12, '+', 5) = ", valeur(12, '+', 5))
    print("valeur(2, '-', 6) = ",  valeur(2, '-', 6))
    print("valeur(5, '*', 2) = ",  valeur(5, '*', 2))
    print("valeur(14, '/', 3) = ", valeur(14, '/', 3))
    print("valeur(14, '$', 3) = ", valeur(14, '$', 3))
    
    
    # Vous pouvez ajouter vos propres tests ici.
    expression = list("10*3-15")
    print("Dans la suite, on utilise l'expressions suivante: ")
    print(expression_as_table(expression))
    
    print("--- Test de la méthode lireOperateur")
    indiceCourant = 4
    c = lireOperateur()
    print(f"L'opérateur lu à l'indice {indiceCourant} est: {c}")
    
    print("--- Test de la méthode lireOperande")
    indiceCourant = 0
    nb = lireOperande()
    print(f"Le nombre lu à l'indice {indiceCourant} est: {nb}")

    print("--- Test de la méthode evalue")
    indiceCourant = 0
    nb = evalue()
    print(f"Le résultat de l'opération est: {nb}")
    
