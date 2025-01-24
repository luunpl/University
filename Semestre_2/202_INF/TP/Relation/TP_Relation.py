# Projet 1 - INF202 - 2020
# DLST - Universite Grenoble Alpes
from TP_Programme import *
from TP_Operation import *

###################################
## 1- Representation des programmes

repr_prog1 = []
repr_prog2 = []
repr_prog3 = []

def afficheRelation(R):
	'''
	a faire a partir de la fonction du TP1
	Affiche la matrice de la relation d'ordre R
	'''
	pass



############################
## 2- relation de dependance

R_dep1 = []

def const_dep(repr_prog):
	'''
	construire la matrice de R_dep a partir de repr_prog
	'''
	pass

def const_prec(R_dep):
	'''
	construire la matrice de R_prec a partir de R_dep
	'''
	pass



#############################################
## 3- attribution des instructions aux coeurs


#def affichePlacee(placee):
def affich_attrib(attrib):
	'''
	Affiche la liste attrib #placee
	'''
	pass

def schtroumpf(R_pred):
	'''
	remplir la matrice exec_par a partir de R_prec
	'''

#def affichePlacement(placement):
def affich_exec(exec_par):
	'''
	Affiche la matrice exec_par  #le tableau placement
	'''
	pass
	


############################
## 4- execusion du programme


def calcul_mem(repr_prog, exec_par) : 
    '''
    calcul l'etat de la memoire a chaque etape de calcul
    '''
    pass

#def afficheMemoire(memoire):
def affich_mem(mem):
	'''
	Affiche la memoire de maniere formatee
	'''
	pass



############################
## 5- finalisation du script

def readProgram(filename):
	'''
	Cree une liste de listes representant le programme contenu dans le fichier filename.
	'''
	file = open(filename, "r")
	lines = file.readlines()
	file.close()

	Dprog = []

	for line in lines:
		str_list = line.split()

		# chaque ligne doit contenir exactement cinq elements
		assert len(str_list) == 5, "Nombre incorrect d'elements"

		 # on applique la fonction int() a chaque element de str_list afin de convertir chaque element en entier
		int_list = list(map(int, str_list))

		Dprog.append(int_list)

	return Dprog

#def printProgram(Dprog):
def printProgram(repr_prog):
	'''
	Affiche le programme contenu dans Dprog sous format codifie
	'''
	pass
