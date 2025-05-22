#!/usr/bin/python
# -*- coding: UTF-8 -*-

'''
  L’objectif de ce TP est de coder les manipulations d’ensembles vues en TD - Feuille 1.
  Dans le TP une relation est toujours represente avec une matrice.
  
  Le code peut etre execute tel quel, il donnera des instructions 
    et des messages d'erreur.
  Aller dans la fonction __main__ en bas du fichier pour demarrer.
  
  Demarrez par ex_initial()
  Commentez avec # les lignes " print("TODO:... " et inserer votre code en dessous.
  
  Une fois fini, decommentez les lignes des exercices pour qu'elles soient executees: 
  #ex_union()  -> ex_union()  
  #ex_intersecion() -> ex_intersecion() 
  #ex_inverse() -> ex_inverse() 
  #ex_composition() -> ex_composition()
  
  Pour chaque exercice commentez avec # les lignes 
  print("TODO:... et inserer votre code en dessous.
  
  Pensez a sauvegarder et tester regulierement votre travail 
'''

########################################
#### FUNCTIONS DE GENERATION ###########

def genRandom(n, m):
    ''' Genere aleatoirement une relation entre un ensemble a n elements et 
        un ensemble a m elements, represente par une matrice
    '''
    from random import randint
    R = []
    for i in range(n):
        l = []
        for j in range(m):
            l.append(randint(0,1))
        R.append(l)
    return R


def genVide(n, m):
    ''' Genere la relation vide entre un ensemble a n elements et
        un ensemble a m elements (tous les elements de la matrice sont 0)
    '''
    R = []
    
    print("TODO: implementer genVide")

    return R


def genPleine(n, m):
    ''' Genere la relation pleine entre un ensemble a n elements et
    un ensemble a m elements (tous les elements de la matrice sont 1)
    '''
    R = []
    
    print("TODO: implementer genPleine")

    return R


def getPredefinie33():
    print("TODO: modifier la relation pour qu'elle aille les bonnes dimensions: 3x3")
    return [[1,], [1,1,1,1], [1,1]]


def getPredefinie35():
    print("TODO: modifier la relation pour qu'elle aille les bonnes dimensions: 3x5")
    return [[1,0,0,1], [1,1,1], [0,1,1,1,0,1]]


def getPredefinie53():
    print("TODO: modifier la relation pour qu'elle aille les bonnes dimensions: 5x3")
    print("TODO: modifier la relation pour qu'elle soit l'inverse de getPredefinie35")
    return []


def getPredefinieAutoInverse():
    print("TODO: modifier la relation pour qu'elle soit tel que elle meme est sont inverse (3x3)")
    return [[0,1,0], [1,1,1], [0,0,0]]


########################################
#### FUNCTION D'AFFICHAGE ##############

#Afficher la matrice d'une relation 
def affiche(R):
    ''' 
        Cette fonction affiche la relation en entree R.
    '''
    print("\nAffichage: ")
    print("/!\ Selon la version de Python, l'affichage ne fonctionne pas de la meme facon.\n Commenter les 'print' utilises et decommenter les autres. ")
    for i in range(len(R)):
        for j in range(len(R[i])):
            if R[i][j]:
                #print("1"),
                print("1", end=" ")
            else:
                #print("0"),
                print("0", end=" ")
        #print("\n")
        print()
    #print("\n")
    print("\n")


########################################
#### FUNCTIONS DE COMPARAISON ##########

def est_incluse(R1, R2):
    '''
        Cette fonction teste si tout element de R1 est en R2.
        Dans ce cas elle renvoye True sinon False.
        Les deux relations R1 et R2 doivent avoir les memes dimensions.
        Dans le cas de dimensions incompatibles, la fonction affiche un message d'erreur
        et returne False.
    '''
    # Check empty relations case
    if len(R1) == 0:
        if len(R2) == 0:
            return True
        else:
            # TODO: message d'erreur
            return False
        
    # Check R2 has the same sizes as R1
    if not verifier_taille(R2, len(R1), len(R1[0])):
        return False
    
    # Check inclusion
    for i in range(len(R1)):
        for j in range(len(R1[i])):
            if R1[i][j] == 1 and R2[i][j] == 0:
                return False
    return True


def sont_egales(R1, R2):
    '''
        Cette fonction teste si touts les element de R1 sont egaux a R2
        Dans ce cas elle renvoye True sinon False
        Les deux relations R1 et R2 doivent avoir les memes dimensions.
        Dans le cas de dimensions incompatibles, la fonction affiche un message d'erreur
        et returne False.
    '''
    # Check empty Relations case
    if len(R1) == 0:
        if len(R2) == 0:
            return True
        else:
            # TODO: message d'erreur
            return False
    
    # Check R2 has the same sizes as R1    
    if not verifier_taille(R2, len(R1), len(R1[0])):
        return False
    
    # Check equality
    for i in range(len(R1)):
        for j in range(len(R1[i])):
            if R1[i][j] != R2[i][j]:
                return False
    return True


def sont_inverses(R, invR):
    '''
        Cette fonction teste si R est bien l'inverse de invR.
        Dans ce cas elle renvoye True sinon False.
        Les tailles de R et invR doivent etre compatibles.
        Dans le cas de dimensions incompatibles, la fonction affiche un message d'erreur
        et returne False.
    '''
    
    print("TODO: implementer sont_inverses")
    
    return False


def verifier_taille(R, n, m):
    '''
        Cette fonction teste si la taille de la matrice R est bien nxm 
        Dans ce cas elle renvoye True sinon False.
    '''    
    if len(R) != n:
        print("Probleme de taille: {} attendu, mais relation a {} lignes".format(n, len(R)))
        return False
    
    for i in range(n):
        if len(R[i]) != m:
            print("Probleme de taille dans la ligne {}: {} attendu, mais la relation a {} colonnes".format(i, m, len(R[i])))
            return False
    
    print("Taille {} {} verifie".format(n,m))
    return True


########################################
#### FUNCTIONS DE MANIPULATION #########

def union(R, S):
    '''
        Cette fonction calcule l'union de R et S.
        Les deux relations R et S doivent avoir les memes dimensions.
        Dans le cas de dimensions differentes, la fonction affiche un message d'erreur
        et returne une liste vide [].
    '''
    RuS = []
    
    print("TODO: implementer union")
       
    return RuS


def intersection(R, S):
    '''
        Cette fonction calcule l'intersection de R et S.
        Les deux relations R et S doivent avoir les memes dimensions.
        Dans le cas de dimensions differentes, la fonction affiche un message d'erreur
        et returne une liste vide [].
    '''
    RiS = []
    
    print("TODO: implementer intersection")
   
    return RiS


def inverse(R):
    '''
        Cette fonction calcule l'inverse de R.
    '''
    invS = []
    
    print("TODO: implementer inverse")
    
    return invS
    

def composition(S, R):
    '''
        Cette fonction calcule la composition de R et S.
        Les deux relations R et S doivent avoir des dimensions compatibles.
        Dans le cas de dimensions incompatibles, la fonction affiche un message d'erreur
        et returne une liste vide [].
    '''
    SoR = []
    
    print("TODO: implementer composition")
        
    return SoR


########################################
#### EXERCICES #########################

def ex_initial():
    '''
        Dans cette fonction le code 
        - genere des relations en forme de matrice
        - verifie que leur taille est correcte
        - affiche les matrices obtenues
    '''
    
    # Functions affichage
    RR = genRandom(7,7)
    verifier_taille(RR, 7, 7)
    affiche(RR)
    
    RV = genVide(2, 3)
    verifier_taille(RV, 2, 3)
    affiche(RV)

    RP = genPleine(4, 5)
    verifier_taille(RP, 4, 5)
    affiche(RP)
    
    R33 = getPredefinie33()
    verifier_taille(R33, 3, 3)
    affiche(R33)
    
    R35 = getPredefinie35()
    verifier_taille(R35, 3, 5)
    affiche(R35)


def ex_union():
    '''
        Dans cet exercice on manipule l'union.
    '''
    #################
    ##### UNION #####
    
    RV = genVide(4, 5)
    RP = genPleine(4, 5)
    RR = genRandom(4, 5)
    
    # l'union de Pleine et n'importe quelle matrice doit etre egale a Pleine 
    # Avec la vide
    RP_U_RV = union(RP, RV)
    if sont_egales(RP_U_RV, RP):
        print("Test Union egal 1 OK")
    else:
        print("Test Union egal 1 FAIL")
        
    if est_incluse(RP, RP_U_RV) and est_incluse(RV, RP_U_RV):
        print("Test Union incluse 1 OK")
    else:
        print("Test Union incluse 1 FAIL")
    
    # Avec la Random
    RP_U_RR = union(RP, RR)
    if sont_egales(RP_U_RR, RP):
        print("Test Union egal 2 OK")
    else:
        print("Test Union egal 2 FAIL")
    
    if est_incluse(RP, RP_U_RR) and est_incluse(RR, RP_U_RR):
        print("Test Union incluse 2 OK")
    else:
        print("Test Union incluse 2 FAIL")
    
    
    RR1 = genRandom(4, 5)
    RR2 = genRandom(4, 5)
    
    RR1_U_RR2 = union(RR1, RR2)
    print('TODO: Tester que RR1 est incluse dans l\'union')
    print('TODO: Tester que RR2 est incluse dans l\'union')
    
    print("TODO: Tester que l'UNION d'une matrice avec elle meme, reste elle meme")
    
    
def ex_intersecion():
    '''
        Dans cet exercice on manipule l'intersection.
    '''
    ########################
    ##### INTERSECTION #####
    
    RV = genVide(6, 5)
    RP = genPleine(6, 5)
    RR = genRandom(6, 5)
    
    # l'intersection de Vide et n'importe quelle matrice doit etre egale a Vide
    # Avec la Vide 
    RV_I_RP = intersection(RV, RP)
    if sont_egales(RV_I_RP, RV):
        print("Test Intersection egal 1 OK")
    else:
        print("Test Intersection egal 1 FAIL")
        
    print('TODO: Tester que l\'intersection es incluse dans RV et dans RP')
    
    # Avec la Random
    RV_I_RR = intersection(RV, RR)
    if sont_egales(RV_I_RR, RV):
        print("Test Intersection egal 2 OK")
    else:
        print("Test Intersection egal 2 FAIL")
    
    print('TODO: Tester que l\'intersection es incluse dans RV et dans RR')
    
    print("TODO: Tester que l'INTERSECTION d'une matrice avec elle meme, reste elle meme")
    
    
def ex_inverse():
    '''
        Dans cet exercice on manipule l'inverse.
    '''
    ###################
    ##### INVERSE #####
    RR = genRandom(3,5)
    verifier_taille(RR, 3, 5)
    
    invRR = inverse(RR)
    verifier_taille(invRR, 5, 3)
    
    if sont_inverses(RR, invRR):
        print("Test Inverse 1 OK")
    else:
        print("Test Inverse 1 FAIL")
    R35 = getPredefinie35()
    invR35 = inverse(R35)
    
    R53 = getPredefinie53()
    invR53 = inverse(R53)
    print("TODO: Modifier la fonction getPredefinie53() tel qu'elle renvoye l'inverse de getPredefinie35")
    
    if sont_inverses(R35, R53):
        print("Test Inverse 2 OK")
    else:
        print("Test Inverse 2 FAIL")
    
    if sont_egales(invR35, R53):
        print("Test Inverse 3 OK")
    else:
        print("Test Inverse 3 FAIL")
    
    if sont_egales(R35, invR53):
        print("Test Inverse 4 OK")
    else:
        print("Test Inverse 4 FAIL")

    
    print("TODO: Modifier la fonction getPredefinieAutoInverse() tel qu'elle renvoye une matrice qui est l'inverse d'elle meme")
    
    R = getPredefinieAutoInverse()
    
    if sont_inverses(R, R):
        print("Test Inverse 5 OK")
    else:
        print("Test Inverse 5 FAIL")
    
    invR = inverse(R)
    
    if sont_egales(invR, R):
        print("Test Inverse 6 OK")
    else:
        print("Test Inverse 6 FAIL")
    
    
    print("TODO: Creer des examples en utilisant que l'inverse est distributive avec l'union: (A union B)^-1  =  A^-1 union B^-1")
    
    print("TODO: Creer des examples en utilisant que l'inverse est distributive avec l'intersection: (A intersection B)^-1  =  A^-1 intersection B^-1")
    
    
def ex_composition():
    #######################
    ##### COMPOSITION #####
    R35 = getPredefinie35()
    R53 = getPredefinie53()
    
    ID = composition(R35, R53)
    
    affiche(ID)

    print("TODO: Montrer que la composition est distributive avec l'union")
    
    print("TODO: Montrer que la composition N'EST PAS distributive avec l'intersection")
    
    print("TODO: Montrer que la composition d'une intersection est incluse dans l'intersection de compositions")
    
    print("TODO: Montrer que la composition est distributive avec l'inverse")
    

if __name__ == "__main__":
     
    print("EXERCICE INITIAL")
    ex_initial()

    # Une fois l'exercice ex_initial fini,
    # commentez la ligne avec '#' et decomentez l'exercice suivant en enlevant le #
    print("EXERCICE UNION")
    #ex_union()
    
    print("EXERCICE INTERSECTION")
    #ex_intersecion()
    
    print("EXERCICE INVERSE")
    #ex_inverse()
    
    print("EXERCICE COMPOSITION")
    #ex_composition()
    
    