"""
Ecrire une fonction NextElem qui prend en argument un élément elm et une liste d’au moins deux éléments liste. La fonction renvoie l’élément suivant elm dans la liste liste, ou le premier élément de la liste si elm est le dernier de liste. Elle renvoie None si elm n’est pas dans liste.
Exemple:
NextElem('a',['a','b','c'])) vaut 'b'
NextElem('c',['a','b','c'] vaut 'a'
NextElem('d',['a','b','c']) vaut None
Ecrire une fonction encode qui prend en argument un texte (en minuscule, sans accent) et une liste ordre contenant toutes les lettres minuscules et la ponctuation dans un certain ordre (comme ordre_alpha et ordre2 qui vous sont fournis, par exemple) et qui renvoie le texte chiffré, où chaque caractère du texte de départ a été remplacé par son élément suivant dans la liste ordre.
"""


def NextElem(elem, liste):
    if elem in liste:
        if elem == liste[-1]:
            return liste[0]
        for i in range(len(liste)):
            if liste[i] == elem:
                return liste[i + 1]
    else:
        return None


def encode(texte, liste):
    encoded_text = ""
    for lettre in texte:
        if lettre in liste:
            lettre = NextElem(lettre, liste)
        encoded_text += lettre
    return encoded_text

    ordre1 = list("abcdefghijklmnopqrstuvwxyz ,;:!?.")
    ordre2 = list("az.erty,uiop:qsdfg!hjklm;wxcv?bn ")
