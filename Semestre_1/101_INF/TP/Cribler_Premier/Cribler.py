import time

# Tester si un nombre est premier
def testPremier(n):
    for i in range(2, int(n / 2) + 1):
        if n % i == 0:
            return False
    return True


# print(testPremier(113))
# Générer une liste de nombres premiers
def genererPremiers(sup):
    return [i for i in range(2, sup + 1) if testPremier(i)]


# print(genererPremiers(100))


# Sauf le 2, la reste est les nombres impairs


# Cribler les nombres premiers
def criblerPremiers(lim):
    Premiers = [2]
    p = 3
    E = [False] * lim
    while p <= lim:
        if not E[p]:
            Premiers.append(p)
            i = p
            while i < lim:
                E[i] = True
                i += p
        p += 2
    return Premiers


"""
Définition d'une fonction Crible d'Ératosthène.

On place 2 comme premier nombre premier dans la liste Premiers, et on commence l'exploration à p = 3.
E (comme éliminés) est une liste qui contient n fois la variable booléenne False. Un False devient True lorsque le nombre
correspondant à sa position est éliminé.

La variable p explore les nombres impairs; sa valeur sera incrémentée de 2 (p  += 2) en fin de boucle.

Mais, tant que sa valeur est inférieure à n et qu'il n'est pas en face d'un True , on retient cette valeur comme nombre 
premier; il est ajouté à la liste Premiers et ses multiples ( i + p) sont positionnés en True dans la liste des éliminés.
"""


# print(criblerPremiers(1000))


# Comparaison des temps d’exécution
def comparer(lim):
    time1 = time.time()
    genererPremiers(lim)
    basique = time.time() - time1
    time3 = time.time()
    criblerPremiers(lim)
    crible = time.time() - time3
    return basique, crible


time_basique, time_crible = comparer(20000)
print("Generation des nombres premiers jusqu'a 20000")
print("Basique:", time_basique, "secondes")
print("Crible:", time_crible, "secondes")
