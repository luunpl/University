# Permutation d'une liste
import itertools
import random
import time
import statistics

# 1
def echange(l, i, j):
    l[i], l[j] = l[j], l[i]


liste = [1, 2, 3, 4, 5]


# 2
def melange(l):
    i = random.randint(0, len(l) - 1)
    j = random.randint(0, len(l) - 1)
    echange(l, i, j)
    return l


# 3
def generer_permutations_1(n, m):
    import copy
    liste_n_entiers = [i for i in range(1, n + 1)]
    liste_a_retourner = []
    for j in range(m):
        liste_copy = copy.deepcopy(liste_n_entiers)
        melange(liste_copy)
        liste_a_retourner.append(liste_copy)
    return liste_a_retourner


# print(generer_permutations_1(2, 7))

# Analyse de la distribution des permutations générées

def frequences(lp):
    start_time = time.time()
    liste_de_permutations = []
    for permutation in lp:
        if permutation not in liste_de_permutations:
            liste_de_permutations.append(permutation)
    frequence = []
    for permutation in liste_de_permutations:
        occ = 0
        for element in lp:
            if element == permutation:
                occ += 1
        frequence.append(occ)
    end_time = time.time()
    exec_time = end_time - start_time
    return exec_time, frequence


# print(frequences(generer_permutations_1(5, 120000)))


def statistique(fq):
    return min(fq), max(fq), statistics.mean(fq), statistics.stdev(fq)


temps, freq = frequences(generer_permutations_1(10, 50000))


# print(statistique(freq))

# Comparaison avec la fonction shuffle

# Algorithme de Knuth ou Fisher-Yates

def permutek(l):
    for i in range(len(l) - 1, 0, -1):
        j = random.randint(0, i + 1)
        echange(l, i, j)


debut = time.time()
random.shuffle(liste)
fin = time.time()


# print(fin - debut)
# print(liste)
# Génération de toutes les permutations possibles d’une liste
def combien(n):
    if n == 1:
        return 1
    else:
        return n * combien(n - 1)


# print(combien(5))

def exhaustive_p(n):
    liste_de_permutations = []
    nb_permutations = combien(n)
    for permutation in generer_permutations_1(n, n * 100000):
        if permutation not in liste_de_permutations:
            liste_de_permutations.append(permutation)
        if len(liste_de_permutations) == nb_permutations:
            break
    return len(liste_de_permutations)


# print(exhaustive_p(5))


def exhaustive_i(n):
    li = [i for i in range(1, n + 1)]
    return list(itertools.permutations(li, n))


# print(exhaustive_i(5))

def verifier(li, sol):
    return li == sol
