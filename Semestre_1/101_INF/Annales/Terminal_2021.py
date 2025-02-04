
def verifierMot(mot):
    if "a" <= mot <= "z":
        return True
    return False

def lireFiltrer():
    mot = input("Entrez un mot : ")
    for lettre in mot:
        if not verifierMot(lettre):
            return False
    return mot

def insererMot(mot, liste):
    for i in range(len(liste)):
        if mot < liste[i]:
            liste.insert(i, mot)
            return liste