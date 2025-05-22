# Projet 1 - INF202 - 2020
# DLST - Universite Grenoble Alpes

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

def printProgram(Dprog):
	'''
	Affiche le programme contenu dans Dprog sous format codifie
	'''
	pass


def afficheRelation(R):
	'''
	Affiche la matrice de la relation d'ordre R
	'''
	pass


def affichePlacee(placee):
	'''
	Affiche la liste placee
	'''
	pass


def affichePlacement(placement):
	'''
	Affiche le tableau placement
	'''
	pass
	
	
def afficheMemoire(memoire):
	'''
	Affiche la memoire de maniere formatee
	'''
	pass