#################################
### TP4 - Plus courts chemins ###
#################################

import math
import random

from lib.graphe import Graphe
from lib.tasbinomial import TasBinomial

"""
Les fonctions dont la documentation contient OBLIGATOIRE sont nécessaires pour
avoir le point du TP.  Les exemples donnés servent aussi de tests unitaires si
le fichier est exécuté.

Comment faire les TP :
* Téléchargez et décompressez l'archive du TP.
* Ouvrez le fichier « tp.py » dans votre éditeur de texte favori.
* Complétez une par une les fonctions entre les lignes « ### À COMPLÉTER DÉBUT » (0 ligne(s))

et « ### À COMPLÉTER FIN »
* Lorsque vous pensez avoir terminé une fonction, exécutez le fichier sur votre
machine et vérifiez que les tests unitaires passent. Si ce n'est pas le cas,
corrigez votre fonction.
* Lorsque les tests unitaires passent pour une fonction, faites un
copier-coller du fichier complet sur Caseine dans l'onglet "Edit", sauvegardez
et vérifiez que cela fonctionne sur Caseine avec le bouton "Evaluate".

Pour toute remarque sur le TP en lui-même (indications pas suffisamment
claires, bug, code qui fonctionne en local mais pas sur Caseine, jeux de tests
insuffisants, questions intéressantes à ajouter, orthographe...), contactez
Florian Fontan florian.fontan@grenoble-inp.fr

Attention : les tests fournis ne peuvent être exhaustifs. Qu'une fonction passe
tous les tests ne garantit pas qu'elle soit correcte. Gardez cela en tête
lorsque vous réutilisez vos fonctions dans d'autres fonctions.
"""


def graphe_1():
    """Retourne le graphe G1.

           1     1     1
        8---->9---->10--->11
        ^     ^     ^     ^
        |     |     |     |
        |1    |4    |6    |8
        |     |     |     |
        7<----6<----5<----4      G1
        ^  1  ^  1  ^  1  ^
        |     |     |     |
        |8    |6    |4    |1
        |     |     |     |
        0---->1---->2---->3
           1     1     1

        :Examples:

        >>> graphe_1() # doctest: +NORMALIZE_WHITESPACE
        {12: 0-1->1 0-8->7 1-1->2 1-6->6 2-1->3 2-4->5 3-1->4
                4-1->5 4-8->11 5-1->6 5-6->10 6-1->7 6-4->9 7-1->8
                8-1->9 9-1->10 10-1->11}

    """

    return Graphe(12, [
        (0, 1, 1), (0, 7, 8), (1, 2, 1), (1, 6,
                                          6), (2, 3, 1), (2, 5, 4), (3, 4, 1),
        (4, 5, 1), (4, 11, 8), (5, 6, 1), (5,
                                           10, 6), (6, 7, 1), (6, 9, 4), (7, 8, 1),
        (8, 9, 1), (9, 10, 1), (10, 11, 1)], oriente=True)


def graphe_2():
    """Retourne le graphe G2.

        7<----6<----5<----4      G2
        ^  3  ^  1  ^  1  ^
        |     |     |     |
        |8    |6    |4    |1
        |     |     |     |
        0---->1---->2---->3
           1     1     1

        :Examples:

        >>> graphe_2() # doctest: +NORMALIZE_WHITESPACE
        {8: 0-1->1 0-8->7 1-1->2 1-6->6 2-1->3 2-4->5 3-1->4
                4-1->5 5-1->6 6-3->7}

    """

    return Graphe(8, [
        (0, 1, 1), (0, 7, 8), (1, 2, 1), (1, 6,
                                          6), (2, 3, 1), (2, 5, 4), (3, 4, 1),
        (4, 5, 1), (5, 6, 1), (6, 7, 3)], oriente=True)


def graphe_2_bis():
    """Retourne le graphe G2'.

        G2' est isomorphe à G2, le sommet i de G2' est le sommet 7-i de G2.

        0<----1<----2<----3      G2'
        ^  3  ^  1  ^  1  ^
        |     |     |     |
        |8    |6    |4    |1
        |     |     |     |
        7---->6---->5---->4
           1     1     1

        :Examples:

        >>> graphe_2_bis() # doctest: +NORMALIZE_WHITESPACE
        {8: 1-3->0 2-1->1 3-1->2 4-1->3 5-4->2 5-1->4 6-6->1 6-1->5 7-8->0 7-1->6}

    """

    return Graphe(8, [
        (7, 6, 1), (7, 0, 8), (6, 5, 1), (6, 1,
                                          6), (5, 4, 1), (5, 2, 4), (4, 3, 1),
        (3, 2, 1), (2, 1, 1), (1, 0, 3)], oriente=True)


def graphe_3():
    """Retourne le graphe G3.

            5
           / \
         6/   \1
         /1    \
        1---2   4   G3 (chaque arête (uv) correspond à un arc de u vers v et un arc de v vers u)
         \   \  |
         2\  4\ |4
           \   \|
            0---3
              2

        :Examples:

        >>> graphe_3() # doctest: +NORMALIZE_WHITESPACE
        {6:
                0-2->1 0-2->3
                1-2->0 1-1->2 1-6->5
                2-1->1 2-4->3
                3-2->0 3-4->2 3-4->4
                4-4->3 4-1->5
                5-6->1 5-1->4}

    """

    return Graphe(6, [
        (0, 1, 2), (0, 3, 2),
        (1, 0, 2), (1, 2, 1), (1, 5, 6),
        (2, 1, 1), (2, 3, 4),
        (3, 0, 2), (3, 2, 4), (3, 4, 4),
        (4, 3, 4), (4, 5, 1),
        (5, 1, 6), (5, 4, 1)
    ], oriente=True)


##############################
### Algorithme de Dijkstra ###
##############################

# L'implémentation de l'algorithme de Dijkstra est très proche de celle du
# parcours en largeur. Il suffit juste de remplacer la file par une file de
# priorité et de mémoriser les distances.
# La file de priorité est une structure dans laquelle on peut ajouter des
# éléments en leur assignant un cout. La fonction retirer renvoie alors
# l'élément de la file avec le cout le plus faible.


#############################################################
### File de priorité : implmentation utilisant un tableau ###
#############################################################

# Nous allons d'abord implémenter une file de priorité en utilisant un tableau
# T tel que T[u] corresponde au cout du sommet d'indice u. Comme on veut avoir
# une fonction est_vide(), on garde aussi la taille de la file. La structure
# est donc une liste de deux éléments [T, t]

def fptableau_creer(n):
    """Retourne une file de priorité dont le nombre d'éléments est <= n.

        -------------------
        --- OBLIGATOIRE ---
        -------------------

        :param n: nombre maximum d'éléments ajoutés à la file.

        :Examples:

        >>> fptableau_creer(3)
        [[inf, inf, inf], 0]
        >>> fptableau_creer(4)
        [[inf, inf, inf, inf], 0]

    """

    # Aide : les 'inf' s'obtiennent avec « float('inf') »

    # À COMPLÉTER DÉBUT (1 ligne(s))
    return [[float('inf') for i in range(n)], 0]

    # À COMPLÉTER FIN


def fptableau_ajouter(f, u, c):
    """Ajoute un élément u de cout c à la file de priorité f.

        Si l'élément u est déjà présent dans la file, son cout est mis à jour.

        -------------------
        --- OBLIGATOIRE ---
        -------------------

        :param f: une file de priorité
        :param u: indice de l'élément à ajouter à la file.
        :param c: cout de l'élément e, inférieur au cout actuel si l'élément
        est déjà présent dans la file.

        :Examples:

        >>> f = fptableau_creer(3)
        >>> f
        [[inf, inf, inf], 0]

        >>> fptableau_ajouter(f, 2, 5)
        >>> f
        [[inf, inf, 5], 1]

        >>> fptableau_ajouter(f, 0, 10)
        >>> f
        [[10, inf, 5], 2]

        >>> fptableau_ajouter(f, 2, 4)
        >>> f
        [[10, inf, 4], 2]

    """

    tab = f[0]

    # À COMPLÉTER DÉBUT (3 ligne(s))
    tab[u] = c
    count = 0
    for i in tab:
        if i != float('inf'):
            count += 1
    f[1] = count
    # À COMPLÉTER FIN


def fptableau_retirer(f):
    """Supprime et retourne l'élément de cout minimum de la file de priorité f.

        Retourne le couple (el, cout).

        -------------------
        --- OBLIGATOIRE ---
        -------------------

        :param f: une file de priorité

        :Examples:

        >>> f = fptableau_creer(3)
        >>> fptableau_ajouter(f, 2, 5)
        >>> fptableau_ajouter(f, 0, 10)
        >>> fptableau_ajouter(f, 1, 4)
        >>> f
        [[10, 4, 5], 3]
        >>> fptableau_retirer(f)
        (1, 4)
        >>> f
        [[10, inf, 5], 2]
        >>> fptableau_retirer(f)
        (2, 5)
        >>> f
        [[10, inf, inf], 1]
        >>> fptableau_retirer(f)
        (0, 10)
        >>> f
        [[inf, inf, inf], 0]

        >>> f = fptableau_creer(4)
        >>> fptableau_ajouter(f, 2, 10)
        >>> fptableau_ajouter(f, 3, 15)
        >>> fptableau_ajouter(f, 0, 20)
        >>> fptableau_ajouter(f, 1, 5)
        >>> f
        [[20, 5, 10, 15], 4]
        >>> fptableau_retirer(f)
        (1, 5)
        >>> f
        [[20, inf, 10, 15], 3]
        >>> fptableau_retirer(f)
        (2, 10)
        >>> f
        [[20, inf, inf, 15], 2]

    """

    tab = f[0]

    # À COMPLÉTER DÉBUT (8 ligne(s))
    for i in tab:
        if i != float('inf') and i == min(tab):
            index = tab.index(i)
            tab[index] = float('inf')
            f[1] -= 1
            return index, i

    # À COMPLÉTER FIN


def fptableau_cout(f, v):
    """Retourne le cout de l'élément d'indice v dans la file de priorité f.

        -------------------
        --- OBLIGATOIRE ---
        -------------------

        Retourne float('inf') si l'élément d'indice v n'est pas présent dans f.

        :Examples:

        >>> f = fptableau_creer(3)
        >>> fptableau_ajouter(f, 2, 5)
        >>> fptableau_ajouter(f, 0, 10)
        >>> fptableau_cout(f, 0)
        10
        >>> fptableau_cout(f, 1)
        inf
        >>> fptableau_cout(f, 2)
        5

    """

    tab = f[0]

    # À COMPLÉTER DÉBUT (1 ligne(s))
    return tab[v]

    # À COMPLÉTER FIN


def fptableau_est_vide(f):
    """Retourne True ssi la file de priorité f est vide.

        -------------------
        --- OBLIGATOIRE ---
        -------------------

        :param f: une file de priorité

        :Examples:

        >>> f = fptableau_creer(3)
        >>> fptableau_est_vide(f)
        True
        >>> fptableau_ajouter(f, 2, 5)
        >>> fptableau_est_vide(f)
        False
        >>> fptableau_ajouter(f, 0, 10)
        >>> fptableau_est_vide(f)
        False
        >>> a = fptableau_retirer(f)
        >>> fptableau_est_vide(f)
        False
        >>> a = fptableau_retirer(f)
        >>> fptableau_est_vide(f)
        True

    """

    # À COMPLÉTER DÉBUT (1 ligne(s))
    for i in f[0]:
        if i != float('inf'):
            return False
    return True

    # À COMPLÉTER FIN


def chemin(s, t, pred):
    """Retourne le chemin de s à t en se basant sur le tableau de prédécesseurs
    pred.

        :param s: Indice du sommet source
        :param pred: tableau tel que pred[v] est le prédecesseur de v. Si v est
        inaccessible depuis s, alors pred[v] = None
        :param t: Indice du sommet destination tel que le sommet d'indice t est
        accessible depuis le sommet d'indice s.

        :return: liste de sommet l tel que l[0] = s, l[-1] = t et pour tout i =
        1..len(l)-1, pred[l[i]] = l[i-1].

        -------------------
        --- OBLIGATOIRE ---
        -------------------

        :Examples:

        >>> chemin(0, 10, [None, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10])
        [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
        >>> chemin(1, 4, [1, None, 1, 0, 5, 1])
        [1, 5, 4]

    """

    # Récursif
    # À COMPLÉTER DÉBUT (1 ligne(s))
    # return [t] if pred[t] == s else chemin(s, pred[t], pred) + [t]
    # À COMPLÉTER FIN

    # Itératif
    # À COMPLÉTER DÉBUT (4 ligne(s))
    l = [t]
    while pred[t] != s:
        l.append(pred[t])
        t = pred[t]
    l.append(s)
    l.reverse()
    return l
    # À COMPLÉTER FIN


def dijkstra_fptableau(g: Graphe, s, t=None):
    """Retourne un plus court chemin de s à tous les autres sommets du graphe
    g en utilisant l'algorithme de Dijkstra.

        -------------------
        --- OBLIGATOIRE ---
        -------------------

        La file de priorité est implémentée en utilisant un tableau.

        Si t != None, alors l'algorithme retourne seulement un plus court
        chemin de s à t (l'algorithme s'arrête dès qu'un plus court chemin de
        s à t est trouvé).

        :param g: un graphe (Graphe) dont les arêtes sont pondérées (poids positifs)
        :param s: Indice du sommet source, entier naturel compris entre 0 et n-1
        :param t: Indice du sommet destination, entier naturel compris entre 0 et n-1

        :return:
          si t == None, (dist, pred, l) où
            * dist[v] est la longueur d'un plus court chemin de s à v.
              Si v est inaccessible depuis s, alors dist[v] = float('inf')
            * pred[v] est le prédecesseur de v dans le plus court chemin de s à
              v trouvé par l'algorithme.
              Si v est inaccessible depuis s, alors pred[v] = None
            * l[v] est l'itération à laquelle le sommet v a été traité.
          si t != None, (d, c, l) où
            * d est la longueur d'un plus court chemin de s à t.
              Si t est inaccessible depuis s, alors d = float('inf')
            * c est le chemin de s à t.
              Si t est inaccessible depuis s, alors c = None
            * l[v] est l'itération à laquelle le sommet v a été traité.
              Si v n'a pas été traité, alors l[v] = None

        :Examples:

        t == None, retourne (dist, pred, l)

        >>> for e in dijkstra_fptableau(graphe_1(), 0): print(e)
        [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]
        [None, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
        [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]

        >>> for e in dijkstra_fptableau(graphe_2(), 0): print(e)
        [0, 1, 2, 3, 4, 5, 6, 8]
        [None, 0, 1, 2, 3, 4, 5, 0]
        [0, 1, 2, 3, 4, 5, 6, 7]

        >>> for e in dijkstra_fptableau(graphe_2_bis(), 7): print(e)
        [8, 6, 5, 4, 3, 2, 1, 0]
        [7, 2, 3, 4, 5, 6, 7, None]
        [7, 6, 5, 4, 3, 2, 1, 0]

        >>> for e in dijkstra_fptableau(graphe_3(), 1): print(e)
        [2, 0, 1, 4, 7, 6]
        [1, None, 1, 0, 5, 1]
        [2, 0, 1, 3, 5, 4]

        t != None, retourne (d, c, l)

        >>> for e in dijkstra_fptableau(graphe_1(), 0, 10): print(e)
        10
        [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
        [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, None]

        >>> for e in dijkstra_fptableau(graphe_2(), 0, 7): print(e)
        8
        [0, 7]
        [0, 1, 2, 3, 4, 5, 6, 7]

        >>> for e in dijkstra_fptableau(graphe_2_bis(), 7, 0): print(e)
        8
        [7, 0]
        [7, 6, 5, 4, 3, 2, 1, 0]

        >>> for e in dijkstra_fptableau(graphe_3(), 1, 3): print(e)
        4
        [1, 0, 3]
        [2, 0, 1, 3, None, None]

    """

    n = g.nombre_sommets()
    dist = [float('inf')]*n
    pred = [None]*n
    l = [None]*n  # => si l[v] == None, alors le sommet n'a pas encore été traité

    # À COMPLÉTER DÉBUT (13 ligne(s))
    dist[s] = 0
    fp = fptableau_creer(n)
    fptableau_ajouter(fp, s, 0)
    count = 0
    while not fptableau_est_vide(fp):
        for i in range(0, n):
            if fptableau_cout(fp, i) != float('inf'):
                for j, poid in g.voisins_avec_poids(i):
                    if dist[j] > dist[i] + poid:
                        dist[j] = dist[i] + poid
                        pred[j] = i
                        fptableau_ajouter(fp, j, dist[j])
        a, b = fptableau_retirer(fp)
        l[a] = count
        count += 1
        if t != None and l[t] != None:
            break

    # À COMPLÉTER FIN

    return (dist, pred, l) if t == None else (dist[t], chemin(s, t, pred), l)


##################################################################
### File de priorité : implémentation utilisant un tas binaire ###
##################################################################

# La file de priorité implémentée dans la section précédente, bien que
# fonctionnelle, n'est pas très efficace. En effet, la fonction 'retirer'
# parcourt l'ensemble de la liste, c'est-à-dire n éléments.
# Nous allons implémenter une autre implémentation de la file de priorité où
# cette fonction ne demandera d'examiner que log(n) éléments (en contrepartie,
# les autres fonctions demanderont aussi d'examiner log(n) éléments).
# Il s'agit de l'implémentation utilisant un tas binaire. Elle est très bien
# expliquée sur Wikipédia
# https://fr.wikipedia.org/wiki/Tas_binaire
# Lisez la page Wikipéida attentivement et passez à l'implémentation une fois
# que vous avez compris.

# Ici, nous allons représenter la file de priorité par une liste de trois
# éléments [arbre, positions, nbelem] où 'arbre' est le tableau de couples
# (sommet, cout) représentant l'arbre binaire, 'position' est un tableau indicé
# par les sommets tel que 'position[v]' est l'indice du sommet v dans 'arbre',
# et 'nbelem' est le nombre d'éléments dans la file.

def tasbinaire_verifier(f, verbose=True):
    """Retourne True ssi f est un tas binaire valide.

        :param f: file de priorité

        :Examples:

        >>> tasbinaire_verifier([[], [], 0])
        True
        >>> tasbinaire_verifier([[None, None], [None, None], 0])
        True
        >>> tasbinaire_verifier([[(0, 2), (2, 4), (1, 3)], [0, 2, 1], 3])
        True

        >>> # Taille fausse
        >>> tasbinaire_verifier([[None, None], [None, None], 1], False)
        False
        >>> tasbinaire_verifier([[(0, 3), None], [0, None], 0], False)
        False
        >>> tasbinaire_verifier([[None, (0, 3)], [1, None], 1], False)
        False
        >>> # Positions incorrectes
        >>> tasbinaire_verifier([[(0, 3), None], [1, None], 1], False)
        False
        >>> # Arbre non tas
        >>> tasbinaire_verifier([[(0, 2), (2, 1), (1, 3)], [0, 2, 1], 3], False)
        False
        >>> tasbinaire_verifier([[(0, 2), (2, 4), (1, 1)], [0, 2, 1], 3], False)
        False

    """

    tas, pos = f[0], f[1]

    if len(pos) != len(tas):
        return False

    n = 0
    while n < len(tas) and tas[n] != None:
        n += 1
    if n != f[2]:
        return False
    for i in range(n, len(tas)):
        if tas[i] != None:
            return False

    for pu in range(n):
        u, cu = tas[pu]
        if pu != pos[u]:
            if verbose:
                print(f)
                print("Positions incohérentes: ",
                      "(", u, ", ", cu, ") est à la position ", pu,
                      " mais devrait être à la position ", pos[u], sep="")
            return False

        for pv in range(2*pu+1, 2*pu+3):
            if pv >= n:
                continue
            v, cv = tas[pv]
            if cv >= cu:
                continue
            if verbose:
                print(f)
                print("L'arbre n'est pas un tas: ",
                      " élément ", pu, " : (", u, ", ", cu, "),"
                      " élément ", pv, " : (", v, ", ", cv, ")", sep="")
            return False
    return True


def tasbinaire_creer(n):
    """Retourne une file de priorité dont le nombre d'éléments est <= n.

        -------------------
        --- OBLIGATOIRE ---
        -------------------

        :param n: nombre maximum d'éléments ajoutés à la file.

        :Examples:

        >>> tasbinaire_creer(3)
        [[None, None, None], [None, None, None], 0]
        >>> tasbinaire_creer(4)
        [[None, None, None, None], [None, None, None, None], 0]

    """

    # À COMPLÉTER DÉBUT (1 ligne(s))
    return [[None]*n, [None]*n, 0]

    # À COMPLÉTER FIN


def tasbinaire_ajouter(f, u, c, debug=False):
    """Ajoute un élément u de cout c à la file de priorité f.

        -------------------
        --- OBLIGATOIRE ---
        -------------------

        Si l'élément u est déjà présent dans la file, son cout est mis à jour.

        :param f: une file de priorité
        :param u: indice de l'élément à ajouter à la file
        :param c: cout de l'élément e, inférieur au cout actuel si l'élément
        est déjà présent dans la file.
        :param debug: si True, la file est affichée après chaque modification

        :Examples:

        >>> f = tasbinaire_creer(3)
        >>> f
        [[None, None, None], [None, None, None], 0]
        >>> tasbinaire_ajouter(f, 2, 5, debug=True)
        [[(2, 5), None, None], [None, None, 0], 1]
        >>> tasbinaire_ajouter(f, 0, 8, debug=True)
        [[(2, 5), (0, 8), None], [1, None, 0], 2]
        >>> tasbinaire_ajouter(f, 1, 3, debug=True)
        [[(2, 5), (0, 8), (1, 3)], [1, 2, 0], 3]
        [[(1, 3), (0, 8), (2, 5)], [1, 0, 2], 3]

        >>> f = tasbinaire_creer(3)
        >>> f
        [[None, None, None], [None, None, None], 0]
        >>> tasbinaire_ajouter(f, 1, 8, debug=True)
        [[(1, 8), None, None], [None, 0, None], 1]
        >>> tasbinaire_ajouter(f, 2, 3, debug=True)
        [[(1, 8), (2, 3), None], [None, 0, 1], 2]
        [[(2, 3), (1, 8), None], [None, 1, 0], 2]

        >>> f = [
        ...     [(7, 4), (4, 10), (1, 6), (0, 18), (2, 12), (5, 14), (6, 16), None],
        ...     [3, 2, 4, None, 1, 5, 6, 0],
        ...     7]
        >>> tasbinaire_ajouter(f, 3, 8, debug=True)
        [[(7, 4), (4, 10), (1, 6), (0, 18), (2, 12), (5, 14), (6, 16), (3, 8)], [3, 2, 4, 7, 1, 5, 6, 0], 8]
        [[(7, 4), (4, 10), (1, 6), (3, 8), (2, 12), (5, 14), (6, 16), (0, 18)], [7, 2, 4, 3, 1, 5, 6, 0], 8]
        [[(7, 4), (3, 8), (1, 6), (4, 10), (2, 12), (5, 14), (6, 16), (0, 18)], [7, 2, 4, 1, 3, 5, 6, 0], 8]
        >>> tasbinaire_ajouter(f, 6, 2, debug=True)
        [[(7, 4), (3, 8), (1, 6), (4, 10), (2, 12), (5, 14), (6, 2), (0, 18)], [7, 2, 4, 1, 3, 5, 6, 0], 8]
        [[(7, 4), (3, 8), (6, 2), (4, 10), (2, 12), (5, 14), (1, 6), (0, 18)], [7, 6, 4, 1, 3, 5, 2, 0], 8]
        [[(6, 2), (3, 8), (7, 4), (4, 10), (2, 12), (5, 14), (1, 6), (0, 18)], [7, 6, 4, 1, 3, 5, 0, 2], 8]

    """

    tas, pos = f[0], f[1]
    tas2, pos2 = tas[:], pos[:]
    if debug:
        tasbinaire_verifier(f)

    # Si l'élément n'est pas dans le tas, on le place à la fin
    # À COMPLÉTER DÉBUT (3 ligne(s))
    if pos[u] is None:
        pos[u] = f[2]
        f[2] += 1
    # À COMPLÉTER FIN

    # On met à jour son cout
    # À COMPLÉTER DÉBUT (1 ligne(s))
    tas[pos[u]] = (u, c)
    # À COMPLÉTER FIN

    if debug:
        print(f)

    # On corrige l'arbre :
    # Tant que u n'est pas la racine
    #     Soit v le père de u
    #     Si cout(v) <= cout(u)
    #         break
    #     Sinon
    #         Échanger u et v
    #     if debug:
    #         print(f)

    # À COMPLÉTER DÉBUT (10 ligne(s))
    while pos[u] != 0:
        v = (pos[u] - 1) // 2
        if tas[v][1] <= tas[pos[u]][1]:
            break
        else:
            tas[pos[u]], tas[v] = tas[v], tas[pos[u]]
            pos[tas[pos[u]][0]], pos[tas[v][0]
                                     ] = pos[tas[v][0]], pos[tas[pos[u]][0]]
        if debug:
            print(f)
    # À COMPLÉTER FIN

    if debug:
        tasbinaire_verifier(f)


def tasbinaire_retirer(f, debug=False):
    """Supprime et retourne l'élément de cout minimum de la file de priorité f.

        -------------------
        --- OBLIGATOIRE ---
        -------------------

        Retourne le couple (el, cout).

        :param f: une file de priorité

        :Examples:

        >>> f = [
        ...     [(7, 4), (4, 10), (1, 6), (0, 18), (2, 12), (5, 14), (6, 16), None],
        ...     [3, 2, 4, None, 1, 5, 6, 0],
        ...     7]
        >>> tasbinaire_retirer(f, True)
        [[(6, 16), (4, 10), (1, 6), (0, 18), (2, 12), (5, 14), None, None], [3, 2, 4, None, 1, 5, 0, None], 6]
        [[(1, 6), (4, 10), (6, 16), (0, 18), (2, 12), (5, 14), None, None], [3, 0, 4, None, 1, 5, 2, None], 6]
        [[(1, 6), (4, 10), (5, 14), (0, 18), (2, 12), (6, 16), None, None], [3, 0, 4, None, 1, 2, 5, None], 6]
        (7, 4)
        >>> tasbinaire_retirer(f, True)
        [[(6, 16), (4, 10), (5, 14), (0, 18), (2, 12), None, None, None], [3, None, 4, None, 1, 2, 0, None], 5]
        [[(4, 10), (6, 16), (5, 14), (0, 18), (2, 12), None, None, None], [3, None, 4, None, 0, 2, 1, None], 5]
        [[(4, 10), (2, 12), (5, 14), (0, 18), (6, 16), None, None, None], [3, None, 1, None, 0, 2, 4, None], 5]
        (1, 6)
        >>> tasbinaire_retirer(f)
        (4, 10)
        >>> tasbinaire_retirer(f)
        (2, 12)

        >>> f = [[(0, 10), None, None], [0, None, None], 1]
        >>> tasbinaire_retirer(f, True)
        [[None, None, None], [None, None, None], 0]
        (0, 10)

        >>> f = [[(4, 3), (2, 6), (1, 7), (0, 8), None], [3, 2, 1, None, 0], 4]
        >>> tasbinaire_retirer(f, True)
        [[(0, 8), (2, 6), (1, 7), None, None], [0, 2, 1, None, None], 3]
        [[(2, 6), (0, 8), (1, 7), None, None], [1, 2, 0, None, None], 3]
        (4, 3)

    """

    tas, pos = f[0], f[1]
    if debug:
        tasbinaire_verifier(f)

    f[2] -= 1  # On met à jour la taille

    # Si la file ne contient qu'un élément, on le supprime et on le retourne
    # À COMPLÉTER DÉBUT (7 ligne(s))
    pos[tas[0][0]] = None
    res = tas[0]
    if f[2] == 0:
        tas[0] = None
    # À COMPLÉTER FIN

    # Sinon, on remplace le premier élément par le dernier
    # À COMPLÉTER DÉBUT (2 ligne(s))
    else:
        tas[0] = tas[f[2]]
        pos[tas[0][0]] = 0
        tas[f[2]] = None
    # À COMPLÉTER FIN
    if debug:
        print(f)

    # On corrige l'arbre :
    # Tant que u n'est pas une feuille
    #     Soit v et w les fils de u
    #     Si cout(v) <= cout(w) et cout(v) < cout(u)
    #         Échanger u et v
    #     Sinon si cout(w) < cout(u)
    #         Échanger u et w
    #     Sinon
    #         break
    #     if debug:
    #         print(f)

    # À COMPLÉTER DÉBUT (14 ligne(s))
    # n = 0
    # while 2 * n + 1 < f[2]:
    #     v, w = 2 * n + 1, 2 * n + 2
    #     if tas[v][1] <= tas[w][1] and tas[v][1] < tas[n][1]:
    #         tas[n], tas[v] = tas[v], tas[n]
    #         pos[tas[n][0]], pos[tas[v][0]] = pos[tas[v][0]], pos[tas[n][0]]
    #     elif tas[w][1] < tas[n][1]:
    #         tas[n], tas[w] = tas[w], tas[n]
    #         pos[tas[n][0]], pos[tas[w][0]] = pos[tas[w][0]], pos[tas[n][0]]
    #     else:
    #         break
    #     n = v
    #     if debug:
    #         print(f)
    a1 = 0
    a2 = 0
    while f[2] > 2 * a1 + 2:
        u = tas[a1]
        v = tas[2 * a1 + 1]
        if tas[2*a1+2][1] < v[1]:
            v = tas[2 * a1 + 2]
            a2 = 2 * a1 + 2
        else:
            a2 = 2 * a1 + 1
        if v[1] < u[1]:
            tas[a1], tas[a2] = tas[a2], tas[a1]
            pos[tas[a1][0]], pos[tas[a2][0]] = pos[tas[a2][0]], pos[tas[a1][0]]
            a1 = a2
            if debug:
                print(f)
        else:
            break
    if f[2] == 2 * a1 + 2:
        if tas[a1][1] > tas[2 * a1 + 1][1]:
            tas[a1], tas[2 * a1 + 1] = tas[2 * a1 + 1], tas[a1]
            pos[tas[a1][0]], pos[tas[2 * a1 + 1][0]
                                 ] = pos[tas[2 * a1 + 1][0]], pos[tas[a1][0]]
        if debug:
            print(f)
    # À COMPLÉTER FIN

    if debug:
        tasbinaire_verifier(f)
    return res


def tasbinaire_cout(f, v):
    """Retourne le cout de l'élément d'indice v dans la file de priorité f.

        -------------------
        --- OBLIGATOIRE ---
        -------------------

        Retourne float('inf') si l'élément d'indice v n'est pas présent dans f.

        :Examples:

        >>> f = [
        ...     [(7, 4), (4, 10), (1, 6), (0, 18), (2, 12), (5, 14), (6, 16), None],
        ...     [3, 2, 4, None, 1, 5, 6, 0],
        ...     7]
        >>> tasbinaire_cout(f, 0)
        18
        >>> tasbinaire_cout(f, 1)
        6
        >>> tasbinaire_cout(f, 2)
        12
        >>> tasbinaire_cout(f, 7)
        4
        >>> tasbinaire_cout(f, 3)
        inf

    """

    tas, pos = f[0], f[1]

    # À COMPLÉTER DÉBUT (4 ligne(s))
    if pos[v] is None:
        return float('inf')
    else:
        return tas[pos[v]][1]
    # À COMPLÉTER FIN

    # À COMPLÉTER FIN


def tasbinaire_est_vide(f):
    """Retourne True ssi la file de priorité f est vide.

        -------------------
        --- OBLIGATOIRE ---
        -------------------

        :param f: une file de priorité

        :Examples:

        >>> f = tasbinaire_creer(3)
        >>> tasbinaire_est_vide(f)
        True
        >>> tasbinaire_ajouter(f, 2, 5)
        >>> tasbinaire_est_vide(f)
        False
        >>> tasbinaire_ajouter(f, 0, 10)
        >>> tasbinaire_est_vide(f)
        False
        >>> a = tasbinaire_retirer(f)
        >>> tasbinaire_est_vide(f)
        False
        >>> a = tasbinaire_retirer(f)
        >>> tasbinaire_est_vide(f)
        True

    """

    # À COMPLÉTER DÉBUT (1 ligne(s))
    return f[2] == 0

    # À COMPLÉTER FIN


def dijkstra_tasbinaire(g: Graphe, s, t=None):
    """Retourne un plus court chemin de s à tous les autres sommets du graphe
    g en utilisant l'algorithme de Dijkstra.

        -------------------
        --- OBLIGATOIRE ---
        -------------------

        La file de priorité est implémentée en utilisant un tas binaire.

        Si t != None, alors l'algorithme retourne seulement le plus court
        chemin de s à t (l'algorithme s'arrête dès qu'un plus court chemin de
        s à t est trouvé).

        :param g: un graphe (Graphe) dont les arêtes sont pondérées
        :param s: Indice du sommet source, entier naturel compris entre 0 et n-1
        :param t: Indice du sommet destination, entier naturel compris entre 0 et n-1

        :return:
          si t == None, (dist, pred, l) où
            * dist[v] est la longueur d'un plus court chemin de s à v.
              Si v est inaccessible depuis s, alors dist[v] = float('inf')
            * pred[v] est le prédecesseur de v dans le plus court chemin de s à
              v trouvé par l'algorithme.
              Si v est inaccessible depuis s, alors pred[v] = None
            * l[v] est l'itération à laquelle le sommet v a été traité.
          si t != None, (d, c, l) où
            * d est la longueur d'un plus court chemin de s à t.
              Si t est inaccessible depuis s, alors d = float('inf')
            * c est le chemin de s à t.
              Si t est inaccessible depuis s, alors c = None
            * l[v] est l'itération à laquelle le sommet v a été traité.
              Si v n'a pas été traité, alors l[v] = None

        :Examples:

        t == None, retourne (dist, pred, l)

        >>> for e in dijkstra_tasbinaire(graphe_1(), 0): print(e)
        [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]
        [None, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
        [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]

        >>> for e in dijkstra_tasbinaire(graphe_2(), 0): print(e)
        [0, 1, 2, 3, 4, 5, 6, 8]
        [None, 0, 1, 2, 3, 4, 5, 0]
        [0, 1, 2, 3, 4, 5, 6, 7]

        >>> for e in dijkstra_tasbinaire(graphe_2_bis(), 7): print(e)
        [8, 6, 5, 4, 3, 2, 1, 0]
        [7, 2, 3, 4, 5, 6, 7, None]
        [7, 6, 5, 4, 3, 2, 1, 0]

        >>> for e in dijkstra_tasbinaire(graphe_3(), 1): print(e)
        [2, 0, 1, 4, 7, 6]
        [1, None, 1, 0, 5, 1]
        [2, 0, 1, 3, 5, 4]

        t != None, retourne (d, c, l)

        >>> for e in dijkstra_tasbinaire(graphe_1(), 0, 10): print(e)
        10
        [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
        [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, None]

        >>> for e in dijkstra_tasbinaire(graphe_2(), 0, 7): print(e)
        8
        [0, 7]
        [0, 1, 2, 3, 4, 5, 6, 7]

        >>> for e in dijkstra_tasbinaire(graphe_2_bis(), 7, 0): print(e)
        8
        [7, 0]
        [7, 6, 5, 4, 3, 2, 1, 0]

        >>> for e in dijkstra_tasbinaire(graphe_3(), 1, 3): print(e)
        4
        [1, 0, 3]
        [2, 0, 1, 3, None, None]

    """

    n = g.nombre_sommets()
    dist = [float('inf')]*n
    pred = [None]*n
    l = [None]*n  # => si l[v] == None, alors le sommet n'a pas encore été traité

    # À COMPLÉTER DÉBUT (13 ligne(s))
    f = tasbinaire_creer(n)
    dist[s] = 0
    tasbinaire_ajouter(f, s, 0)
    for v, poid in g.voisins_avec_poids(s):
        dist[v] = poid
        pred[v] = s
        tasbinaire_ajouter(f, v, poid)
    count = 0
    while not tasbinaire_est_vide(f):
        i, j = tasbinaire_retirer(f)
        l[i] = count
        count += 1
        for v, poid in g.voisins_avec_poids(i):
            if dist[v] > dist[i] + poid:
                dist[v] = dist[i] + poid
                pred[v] = i
                tasbinaire_ajouter(f, v, dist[v])
        if t != None and l[t] != None:
            break
    # À COMPLÉTER FIN
    return (dist, pred, l) if t == None else (dist[t], chemin(s, t, pred), l)


def grille(n):
    """Retourne un graphe en forme de grille.

    0---1---2---3
    |   |   |   |
    4---5---6---7
    |   |   |   |
    8---9---10--11
    |   |   |   |
    12--13--14--15

    """

    def ajouter_arete(u, v):
        c = ((15+u)**2 + (15+v)**2) % 100
        g.ajouter_arete(u, v, c)

    g = Graphe(n*n, oriente=True)
    for u in range(n*n):
        col = u % n
        lig = u // n
        if col != 0:
            ajouter_arete(u, u-1)
        if col != n-1:
            ajouter_arete(u, u+1)
        if lig != 0:
            ajouter_arete(u, u-n)
        if lig != n-1:
            ajouter_arete(u, u+n)
    return g

# Décommentez les lignes suivantes pour comparer la différence de temps
# d'exécution entre les deux implémentations de la file de priorité:


"""
import time
n = 64
g = grille(n)
s  = (n//2 * n) + (n // 2)
t0 = time.time()

dijkstra_fptableau(g, s)
t1 = time.time()
print("DIJKSTRA TABLEAU    : ", round(t1-t0, 2), "s", sep="")

dijkstra_tasbinaire(g, s)
t2 = time.time()
print("DIJKSTRA TASBINAIRE : ", round(t2-t1, 2), "s", sep="")

quit()
"""


# Les sections suivantes sont indépendantes entre elles. Si vous souhaitez
# continuer, il y a :
# * quelques compléments sur les implémentations de file de priorité ;
# * un autre algorithme de plus courts chemins qui fonctionne avec des poids
# quelconques (positifs ou négatifs) ;
# * un autre algorithme de plus courts chemins qui retourne le plus court
# chemin entre toute paire de sommets ;
# * une modification de l'algorithme de Dijkstra pour le rendre plus efficace
# sur les graphes de type carte (utilisation pour le GPS ou les jeux vidéos).


######################################################
### Quelques compléments sur les files de priorité ###
######################################################

# Nous avons déjà vu 2 implémentations d'une file de priorité : en utilisant un
# tableau et en utilisant un tas binaire.
# Une file de priorité peut encore être implémentée en utilisant un tas
# binomial :
# https://fr.wikipedia.org/wiki/Tas_binomial
# C'est l'implémentation qui vous a été fournie pour le TP précédent.
# Pour ce qui concerne la complexité théorique, le tas binomial est légèrement
# meilleur (pas la peine d'entrer dans les détails maintenant)
# Qu'en est-il en pratique ?

# La classe TasBinomial vous est fournie, vous n'avez PAS à l'implémenter.
# C'est la même que celle utilisée pour l'algorithme de Prim au TP précédent.
# Pour rappel, elle s'utilise ainsi :

# Créer une file de priorité contenant des éléments indicés de 0 à n-1 :
# >>> f = TasBinomial(n)
# Ajouter un élément v de cout c ou mettre à jour son cout s'il est déjà dans
# la file :
# >>> f.ajouter(v, c)
# Retirer l'élément de cout minimum :
# >>> v, cv = f.retirer()
# Obtenir le cout de l'élément d'indice v (retourne float('inf') si v n'est pas
# dans la file) :
# >>> c = f.cout(v)
# Pour savoir si la file est vide :
# >>> f.est_vide()

def dijkstra_tasbinomial(g, s, t=None):
    """Retourne un plus court chemin de s à tous les autres sommets du graphe
    g en utilisant l'algorithme de Dijkstra.

        La file de priorité est implémentée en utilisant un tas binomial.

        Si t != None, alors l'algorithme retourne seulement le plus court
        chemin de s à t (l'algorithme s'arrête dès qu'un plus court chemin de
        s à t est trouvé).

        :param g: un graphe (Graphe) dont les arêtes sont pondérées
        :param s: Indice du sommet source, entier naturel compris entre 0 et n-1
        :param t: Indice du sommet destination, entier naturel compris entre 0 et n-1

        :return:
          si t == None, (dist, pred, l) où
            * dist[v] est la longueur d'un plus court chemin de s à v.
              Si v est inaccessible depuis s, alors dist[v] = float('inf')
            * pred[v] est le prédecesseur de v dans le plus court chemin de s à
              v trouvé par l'algorithme.
              Si v est inaccessible depuis s, alors pred[v] = None
            * l[v] est l'itération à laquelle le sommet v a été traité.
          si t != None, (d, c, l) où
            * d est la longueur du plus court chemin de s à t.
              Si t est inaccessible depuis s, alors d = float('inf')
            * c est le chemin de s à t.
              Si t est inaccessible depuis s, alors c = None
            * l[v] est l'itération à laquelle le sommet v a été traité.
              Si v n'a pas été traité, alors l[v] = None

        :Examples:

        t == None, retourne (dist, pred, l)

        >>> for e in dijkstra_tasbinomial(graphe_1(), 0): print(e)
        [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]
        [None, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
        [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]

        >>> for e in dijkstra_tasbinomial(graphe_2(), 0): print(e)
        [0, 1, 2, 3, 4, 5, 6, 8]
        [None, 0, 1, 2, 3, 4, 5, 0]
        [0, 1, 2, 3, 4, 5, 6, 7]

        >>> for e in dijkstra_tasbinomial(graphe_2_bis(), 7): print(e)
        [8, 6, 5, 4, 3, 2, 1, 0]
        [7, 2, 3, 4, 5, 6, 7, None]
        [7, 6, 5, 4, 3, 2, 1, 0]

        >>> for e in dijkstra_tasbinomial(graphe_3(), 1): print(e)
        [2, 0, 1, 4, 7, 6]
        [1, None, 1, 0, 5, 1]
        [2, 0, 1, 3, 5, 4]

        t != None, retourne (d, c, l)

        >>> for e in dijkstra_tasbinomial(graphe_1(), 0, 10): print(e)
        10
        [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
        [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, None]

        >>> for e in dijkstra_tasbinomial(graphe_2(), 0, 7): print(e)
        8
        [0, 7]
        [0, 1, 2, 3, 4, 5, 6, 7]

        >>> for e in dijkstra_tasbinomial(graphe_2_bis(), 7, 0): print(e)
        8
        [7, 0]
        [7, 6, 5, 4, 3, 2, 1, 0]

        >>> for e in dijkstra_tasbinomial(graphe_3(), 1, 3): print(e)
        4
        [1, 0, 3]
        [2, 0, 1, 3, None, None]


    """

    n = g.nombre_sommets()
    dist = [float('inf')]*n
    pred = [None]*n
    l = [None]*n  # => si l[v] == None, alors le sommet n'a pas encore été traité

    # À COMPLÉTER DÉBUT (13 ligne(s))
    f = TasBinomial(n)
    f.ajouter(s, 0)
    dist[s] = 0
    i = 0
    while not f.est_vide():
        v, cv = f.retirer()
        if l[v] is None:
            l[v] = i
            i += 1
            for w in g.successeurs(v):
                if l[w] is None:
                    if dist[w] > dist[v] + g.cout(v, w):
                        dist[w] = dist[v] + g.cout(v, w)
                        pred[w] = v
                        f.ajouter(w, dist[w])
    # À COMPLÉTER FIN
    if t is None:
        return dist, pred, l
    else:
        d = dist[t]
        c = None
        if d != float('inf'):
            c = [t]
            while c[-1] != s:
                c.append(pred[c[-1]])
            c.reverse()
        return d, c, l
    # À COMPLÉTER FIN

    return (dist, pred, l) if t == None else (dist[t], chemin(s, t, pred), l)


"""
import time
n = 256
g = grille(n)
s  = (n//2 * n) + (n // 2)
t0 = time.time()

dijkstra_tasbinaire(g, s)
t1 = time.time()
print("DIJKSTRA TASBINAIRE  : ", round(t1-t0, 2), "s", sep="")

dijkstra_tasbinomial(g, s)
t2 = time.time()
print("DIJKSTRA TASBINOMIAL : ", round(t2-t1, 2), "s", sep="")

quit()
"""


# Il existe encore une autre implémentation de file de priorité qui possède, une
# meilleure complexité théorique, en utilisant un tas de Fibonacci :
# https://fr.wikipedia.org/wiki/Tas_de_Fibonacci
# Toutefois, en pratique, celle-ci est aussi moins performante qu'un tas binaire.
# Si cela vous intéresse, vous pouvez en lire plus ici :
# https://stackoverflow.com/questions/504823/has-anyone-actually-implemented-a-fibonacci-heap-efficiently/508221#508221
# Des implémentations en Python si jamais vous voulez tester par vous-même :
# https://pypi.org/project/fibonacci-heap-mod/
# https://github.com/danielborowski/fibonacci-heap-python


##################################
### Algorithme de Bellman-Ford ###
##################################

# L'algorithme de Dijkstra permet de trouver un plus court chemin dans un
# graphe où les distances sont toutes positives. S'il y a des distances
# négatives, l'algorithme peut ne pas retourner un plus court chemin.

def graphe_5():
    """Retourne le graphe G5.

            1
           / \
         3/   \-2
         /     \
        0-------2
            2

        :Examples:

        >>> graphe_5() # doctest: +NORMALIZE_WHITESPACE
        {3: 0-3->1 0-2->2 1--2->2}

    """

    return Graphe(3, [(0, 1, 3), (0, 2, 2), (1, 2, -2)], oriente=True)

# Décommentez les lignes ci-dessous et observer que l'algorithme de Dijkstra ne
# retourne pas un plus court chemin du sommet 0 au sommet 2 dans G3.

# dist, pred, l = dijkstra_tasbinaire(graphe_5(), 0)
# print("DISTANCE DU SOMMET 0 AU SOMMET 2 DANS G3 D'APRÈS L'ALGORITHME DE DIJKSTRA :", dist[2])
# print("CHEMIN   DU SOMMET 0 AU SOMMET 2 DANS G3 D'APRÈS L'ALGORITHME DE DIJKSTRA :", end=" ")
# print(chemin(0, 2, pred))
# quit()

# Dans ce cas, on peut utiliser un autre algorithme, l'algorithme de
# Bellman-Ford, qui, au prix d'un temps d'exécution plus élevé, retournera
# aussi les plus courts chemins dans un graphe avec des poids quelconques
# (positifs ou négatifs).

# L'algorithme de Bellman-Ford consiste à calculer d(u, k), la distance pour
# aller du sommet s au sommet v en utilisant k arêtes, en utilisant la formule
# récursive suivante :
#
#               | d(v, k-1)
#               |       si aucune arête (uv) n'est utilisée.
# d(v, k) = min |
#               | d(u, k-1) + c(u, v) pour tout u tel que l'arête (uv) existe
#               |       si une arête (uv) est utilisée.
#
# avec
# d(s, 0) = 0
# d(v, 0) = inf, pour tout v != s
# et 0 <= k < n

# Pour l'implémentation, on peut utiliser un tableau dist[u] que l'on calcule
# ainsi :
# dist[u] = inf pour tout sommet u
# dist[s] = 0
# Pour k = 1..n-1
#     Pour tout arc (uv)
#         dist[v] = min(dist[v], dist[u]+c(u, v))
# Retourner dist

# Pour plus de détails :
# https://fr.wikipedia.org/wiki/Algorithme_de_Bellman-Ford


def bellman_ford(g, s):
    """Retourne un plus court chemin de s à tous les autres sommets du graphe
    g en utilisant l'algorithme de Bellman-Ford.

        :param g: un graphe (Graphe) dont les arêtes sont pondérées
        :param s: Indice du sommet source, entier naturel compris entre 0 et n-1

        :return: (dist, pred) où
        * dist[v] est la longueur d'un plus court chemin de s à v.
          Si v est inaccessible depuis s, alors dist[v] = float('inf')
        * pred[v] est le prédecesseur de v dans le plus court chemin de s à v
          trouvé par l'algorithme.
          Si v est inaccessible depuis s, alors pred[v] = None

        :Examples:

        >>> for e in bellman_ford(graphe_1(), 0): print(e)
        [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]
        [None, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

        >>> for e in bellman_ford(graphe_3(), 1): print(e)
        [2, 0, 1, 4, 7, 6]
        [1, None, 1, 0, 5, 1]

        >>> for e in bellman_ford(graphe_5(), 0): print(e)
        [0, 3, 1]
        [None, 0, 1]


    """

    n = g.nombre_sommets()
    dist = [float('inf')]*n
    dist[s] = 0
    pred = [None]*n

    # À COMPLÉTER DÉBUT (10 ligne(s))

    # À COMPLÉTER FIN

    return (dist, pred)

# L'algorithme de Bellman-Ford donne bien un plus court chemin dans G3...

# dist, pred = bellman_ford(graphe_5(), 0)
# print("DISTANCE DU SOMMET 0 AU SOMMET 2 DANS G3 D'APRÈS L'ALGORITHME DE BELLMAN-FORD :", dist[2])
# print("CHEMIN   DU SOMMET 0 AU SOMMET 2 DANS G3 D'APRÈS L'ALGORITHME DE BELLMAN-FORD :", end=" ")
# print(chemin(0, 2, pred))
# quit()

# ... mais il est plus lent que Dijkstra sur les graphes avec des poids positifs :


"""
import time

n = 64
g = grille(n)
s  = (n//2 * n) + (n // 2)
t0 = time.time()
print("GRILLE(", n, ")", sep="")

d_dt, p_dt, l = dijkstra_tasbinaire(g, s)
t1 = time.time()
print("DIJKSTRA TASBINAIRE : ", round(t1-t0, 2), "s", sep="")

d_bf, p_bf = bellman_ford(g, s)
t2 = time.time()
print("BELLMAN-FORD        : ", round(t2-t1, 2), "s", sep="")

quit()
"""


####################################
### Algorithme de Floyd-Warshall ###
####################################

# L'algorithme de Floyd-Warshall retourne les plus courts chemins pour toute
# paire de sommets du graphe d'entrée, contrairement aux algorithmes de
# Dijkstra ou Bellman-Ford qui ne retournent que les plus courts chemins d'un
# sommet du graphe à tous les autres.
# Comme l'algorithme de Bellman-Ford, il se base sur une formule récurisve.
# Soit d(u, v, k) la longueur d'un plus court chemin de u à v utilisant seulement
# les sommets 1 à k (en plus des sommets u et v).
# On a alors :
#                  | d(u, v, k-1)
#                  |      Si le chemin ne passe pas par le sommet k.
# d(u, v, k) = min |
#                  | d(u, k, k-1) + d(k, v, k-1)
#                  |      Si le chemin passe par le sommet k.
#
# avec d(u, v, -1) = c(u, v)
# On cherche d(u, v, n-1) pour tout sommets u et v.

# Pour l'implémentation, on peut utiliser un tableau dist[u][v] que l'on
# calcule ainsi :
# dist[u][v] = c(u, v) pour tout u, v
# Pour k = 1..n
#     Pour u = 1..n
#         Pour v = 1..n
#             dist[u][v] = min(dist[u][v], dist[u,k]+dist[k,v])
# Retourner dist

# Pour plus de détails :
# https://fr.wikipedia.org/wiki/Algorithme_de_Floyd-Warshall

def floyd_warshall(g):
    """Retourne un plus court chemin entre toute paire de sommets du graphe g en
    utilisant l'algorithme de Floyd-Warshall.

        :param g: un graphe (Graphe) dont les arêtes sont pondérées

        :return: tableau dist tel que dist[u][v] est la longueur d'un plus court
        chemin de u à v dans g. Si v est inaccessible depuis u, alors
        dist[u][v] = float('inf')

        :Examples:

        >>> for e in floyd_warshall(graphe_3()): print(e)
        [0, 2, 3, 2, 6, 7]
        [2, 0, 1, 4, 7, 6]
        [3, 1, 0, 4, 8, 7]
        [2, 4, 4, 0, 4, 5]
        [6, 7, 8, 4, 0, 1]
        [7, 6, 7, 5, 1, 0]
        >>> for e in floyd_warshall(graphe_5()): print(e)
        [0, 3, 1]
        [inf, 0, -2]
        [inf, inf, 0]


    """

    n = g.nombre_sommets()

    # Initialisation de la matrice des plus courts chemins.
    dist = [[float('inf')]*n for _ in range(n)]
    for u in range(n):
        dist[u][u] = 0
        for v, cuv in g.voisins_avec_poids(u):
            dist[u][v] = cuv

    # À COMPLÉTER DÉBUT (4 ligne(s))

    # À COMPLÉTER FIN

    return dist

# L'algorithme de Floyd-Washall permet de faire plus que les algorithms de
# Dijkstra et Bellman-Ford, en contrpartie, il est plus lent :


"""
import time

n = 16
g = grille(n)
s  = (n//2 * n) + (n // 2)
t0 = time.time()
print("GRILLE(", n, ")", sep="")

d_bf, p_bf = bellman_ford(g, s)
t1 = time.time()
print("BELLMAN-FORD   : ", round(t1-t0, 2), "s", sep="")

d_fw = floyd_warshall(g)
t2 = time.time()
print("FLOYD-WARSHALL : ", round(t2-t1, 2), "s", sep="")

quit()
"""


#####################
### Algorithme A* ###
#####################

# L'algorithme A* est une modification de l'algorithme de Dijkstra pour le faire
# mieux fonctionner sur des graphes représentants des cartes (GPS, jeux vidéos...).
# Essayons d'abord de comprendre pourquoi Dijkstra peut ne pas être le plus
# efficace pour ces graphes. Si on cherche un plus court chemin de s à t dans
# un graphe g, l'algorithme de Dijkstra ne sait pas par où chercher le sommet
# t, il explore donc les sommets en faisant grandir un cercle autour du sommet
# initial s. Il explore donc un grand nombre de sommets qui sont loin de t et
# dont le traitement n'était pas forcément nécessaire.

# L'algorithme A* corrige cela en utilisant comme cout dans la file pour le
# sommet v, non plus la distance du sommet v au sommet initial s, mais cette
# distance + une approximation de la distance du sommet v au sommet final t.
# Ainsi, il évite d'explorer les sommets qui sont trop loin.

# En contrepartie, lorsqu'on défile un sommet u, il se peut que dist[u] ne soit
# pas la longueur d'un plus court chemin de s à u et le sommet u pourra être
# ajouté à nouveau à la file s'il possède un nouveau cout plus faible que celui
# qu'il avait quand on l'a défilé.
# Si on stocke le cout du sommet u quand on le défile dans cout[u], la
# condition pour ajouter un sommet de cout c à la file devient alors « c <
# cout[v] et c < cout de v dans la file ».

# Notez que la distance dist[i] ne s'obtient plus lorsqu'on défile le sommet i,
# pensez à calculer dist[i] AVANT d'ajouter i dans la file.

# Nous ne ferons pas la démonstration ici, mais l'algorithme A* retourne bien un
# plus court chemin de s à t si l'approximation que l'on utilise pour estimer
# la distance de v à t ne la surévalue jamais.

# Exemple (les valeurs entre paranthèse sont les valeurs de l'heuristique)

def graphe_4():
    """Retourne le graphe G4.

                  1(5)
                 / \
               1/   \4
               /     \   1     6
              0(10)   3-----4-----5     G4
               \     /(1)  (6)
               2\   /2
                 \ /
                  2(8)

        :Examples:

        >>> graphe_4()
        {6: 0-1->1 0-2->2 1-4->3 2-2->3 3-1->4 4-6->5}

    """

    return Graphe(6, [(0, 1, 1), (0, 2, 2), (1, 3, 4), (2, 3, 2), (3, 4, 1), (4, 5, 6)], oriente=True)


def graphe_4_heuristique(u):
    return [10, 5, 8, 1, 6, 0][u]

# État de la file à chaque itération :
# 0 : {(0, 10)} -> (0, 10)
# 1 : {(1, 6), (2, 10)} -> (1, 6)
# 2 : {(3, 6), (2, 10)} -> (3, 6)
# 3 : {(2, 10), (4, 12)} -> (2, 10)
# On avait déja traité 3, mais comme son nouveau cout 5 < 6 son ancien cout, on
# l'ajoute quand même à nouveau dans la file.
# 4 : {(3, 5), (4, 12)} -> (3, 5)
# 5 : {(4, 11)} -> (4, 11)
# 6 : {(5, 11)} -> (5, 11)

# Pour plus de détails, vous pouvez lire la page Wikipédia :
# https://fr.wikipedia.org/wiki/Algorithme_A*


def a_star(g, d, s, t):
    """Retourne un plus court chemin de s à t dans g en utilisant l'algorithme
    A*.

        La file de priorité est implémentée en utilisant un tas binaire.

        :param g: un graphe (Graphe) dont les arêtes sont pondérées
        :param d: fonction qui prend en entrée un sommets u et retourne une
        borne inférieure de la distance entre u et t.
        :param s: Indice du sommet source, entier naturel compris entre 0 et
        n-1
        :param t: Indice du sommet destination, entier naturel compris entre 0
        et n-1

        :return: (dist, c, l) où
        * dist est la longueur d'un plus court chemin de s à t.
          Si t est inaccessible depuis s, alors dist = float('inf')
        * c est le chemin de s à t sous forme de liste [s, ..., t].
        * l[v] est la dernière itération à laquelle le sommet v a été traité.
          Si v n'a jamais été traité, alors l[v] = None

        :Examples:

        On commence par tester avec une heuristique qui renvoie toujours 0 comme
        approximation de la distance de v à t. L'algorithme A* est alors
        équivalent à l'algorithme de Dijkstra.
        >>> dist = lambda u: 0
        >>> a_star(graphe_1(), dist, 0, 11)
        (11, [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11])
        >>> a_star(graphe_3(), dist, 1, 4)
        (7, [1, 5, 4], [2, 0, 1, 3, 5, 4])
        >>> a_star(graphe_4(), graphe_4_heuristique, 0, 5)
        (11, [0, 2, 3, 4, 5], [0, 1, 3, 4, 5, 6])


    """

    n = g.nombre_sommets()
    # dist[v] : plus petite distance courante pour aller de s à v.
    dist = [float('inf')]*n
    # cout[u] : cout du sommet u la dernière fois qu'il a été défilé.
    cout = [float('inf')]*n
    pred = [None]*n
    l = [None]*n

    dist[s] = 0

    # À COMPLÉTER DÉBUT (15 ligne(s))

    # À COMPLÉTER FIN

    return (dist[t], chemin(s, t, pred), l)

# Les fonctions suivantes sont utilisées pour générer un graphe où les sommets
# sont des points d'un plan. Vous n'avez pas besoin de les comprendre.


def intersection(p1, q1, p2, q2):
    """Retourne True ssi le segment [p1,q1] intersecte le segment [p2,q2].

        :Examples:

    """

    def sur_segment(p, q, r):
        return (q[0] <= max(p[0], r[0]) and q[0] >= min(p[0], r[0]) and
                q[1] <= max(p[1], r[1]) and q[1] >= min(p[1], r[1]))

    def orientation(p, q, r):
        val = (q[1] - p[1]) * (r[0] - q[0]) - (q[0] - p[0]) * (r[1] - q[1])
        if val == 0:
            return 0
        elif val > 0:
            return 1
        else:
            return 2

    o1 = orientation(p1, q1, p2)
    o2 = orientation(p1, q1, q2)
    o3 = orientation(p2, q2, p1)
    o4 = orientation(p2, q2, q1)

    # print("P1", p1, "Q1", q1, "P2", p2, "Q2", q2)
    # print("sur_segment(P2, Q1, Q2):", sur_segment(p2, q1, q2))
    # print("sur_segment(P1, Q2, Q1):", sur_segment(p1, q2, q1))
    # print("sur_segment(P2, P1, Q2):", sur_segment(p2, p1, q2))
    # print("sur_segment(P1, P2, Q1):", sur_segment(p1, p2, q1))
    if p1 == p2:
        return (o4 == 0 and (sur_segment(p2, q1, q2) or sur_segment(p1, q2, q1)))
    if p1 == q2:
        return (o4 == 0 and (sur_segment(p2, q1, q2) or sur_segment(p1, p2, q1)))
    if q1 == p2:
        return (o3 == 0 and (sur_segment(p2, p1, q2) or sur_segment(p1, p2, q1)))
    if q1 == q2:
        return (o3 == 0 and (sur_segment(p2, p1, q2) or sur_segment(p1, q2, q1)))

    if o1 != o2 and o3 != o4:
        return True
    if o1 == 0 and sur_segment(p1, p2, q1):
        return True
    if o2 == 0 and sur_segment(p1, q2, q1):
        return True
    if o3 == 0 and sur_segment(p2, p1, q2):
        return True
    if o4 == 0 and sur_segment(p2, q1, q2):
        return True

    return False


def gen_coord(n, seed=0):
    random.seed(seed)
    coord = []
    for i in range(n):
        while True:
            x = random.randint(0, 10*n)
            y = random.randint(0, 10*n)
            if (x, y) not in coord:
                break
        coord.append((x, y))
    return coord


def fsqrt(n):
    """Retourne floor(sqrt(n)).

        :Examples:

        >>> fsqrt(4)
        2
        >>> fsqrt(5)
        3
        >>> fsqrt(8)
        3
        >>> fsqrt(9)
        3

    """

    x = n
    y = (x + 1) // 2
    while y < x:
        x = y
        y = (x + n // x) // 2
    if x**2 == n:
        return x
    else:
        return x + 1


def distance(coord, u, v):
    """Retourne la distance euclidienne entre les points de coord d'indices u
    et v, arrondie à l'entier supérieur.

        :Examples:

        >>> coord = [(0, 0), (1, 0), (1, 2)]
        >>> distance(coord, 0, 1)
        1
        >>> distance(coord, 1, 2)
        2
        >>> distance(coord, 0, 2)
        3

    """

    x = (coord[v][1] - coord[u][1])**2 + (coord[v][0] - coord[u][0])**2
    return fsqrt(x)


def carte(coord):
    """Retourne un graphe orienté planaire triangulé dont les coordoonnées du
    sommet i sont coord[i].

        Pour tout sommets u = (xu, yu) et v = (xv, yv) :
        c(u, v) >= sqrt((yv-yu)**2 + (xv-xu)**2)

        :Examples:

        >>> carte([(0, 0)])
        {1:}
        >>> carte([(0, 0), (1, 0)])
        {2: 0-1->1 1-1->0}
        >>> carte([(0, 0), (1, 0), (2, 0)])
        {3: 0-1->1 1-1->0 1-1->2 2-1->1}
        >>> carte([(0, 0), (1, 0), (2, 0), (3, 0)])
        {4: 0-1->1 1-1->0 1-1->2 2-1->1 2-1->3 3-1->2}
        >>> carte([(0, 0), (1, 0), (1, 1), (0, 2)])
        {4: 0-1->1 0-2->2 0-2->3 1-1->0 1-1->2 2-2->0 2-1->1 2-2->3 3-2->0 3-2->2}

    """

    n = len(coord)
    g = Graphe(n, oriente=True)

    aretes_0 = []
    for u in range(n):
        for v in range(u+1, n):
            aretes_0.append((u, v, distance(coord, u, v)))
    aretes_0.sort(key=lambda t: t[2])

    aretes = []
    for e0 in aretes_0:
        u, v, w = e0
        inter = False
        a = coord[u]
        b = coord[v]
        for e in aretes:
            if intersection(coord[u], coord[v], coord[e[0]], coord[e[1]]):
                inter = True
                break
        if inter:
            continue
        aretes.append(e0)
        g.ajouter_arete(u, v, w)
        g.ajouter_arete(v, u, w)

    return g

# Décommentez maintenant les lignes ci-dessous pour observer la différence
# entre le nombre de sommets traités par l'algorithme de Dijkstra et le nombre
# de sommets traités par l'algorithme A* :


"""
for i in range(10):
    print("GRAPHE CARTE 100", i)
    coord = gen_coord(100, i)
    g = carte(coord)
    s, t = 0, 99
    dist, pred, l = dijkstra_tasbinaire(g, s, t)
    print("NOMBRE DE SOMMETS TRAITÉS PAR L'ALGORITHME DE DJIKSTRA :", max(it for it in l if it is not None))
    d, c, l = a_star(g, lambda u: distance(coord, u, t), s, t)
    print("NOMBRE DE SOMMETS TRAITÉS PAR L'ALGORITHME A*          :", max(it for it in l if it is not None))
quit()
"""

# Toutefois, sur des graphes non adaptés (qui ne correspondent pas suffisamment
# à des cartes ou avec une très mauvaise heuristique), le nombre d'itérations
# de l'algorithme A* peut être de l'ordre de n^2 (contre n pour Dijkstra).
# Observer par exemple ce qui se passe sur le graphe G5.


def graphe_6(n):
    """Retourne le graphe G6.

        Toutes les distances dans Kn sont égales à 0.
        Toutes les heuristiques dasn Kn sont égales 0.

            0   (n)   n
          -----  1  -----

            0  (n-1) n-1
          -----  2  -----

                            (0)   0          0   (0)    0   (n+1)  n+1   (0)
        0 ----- ... -----   n+2 ----- ...  ----- 2n+1 -----  2n+2 ----- 2n+3

            0   (1)   1
          -----  n  -----

            0  (n+1)  0
          ----- n+1 -----

        :Examples:

        >>> graphe_6()
        {6: 0-1->1 0-2->2 1-4->3 2-2->3 3-1->4 4-6->5}

    """

    g = Graphe(2*n+4, oriente=True)
    for v in range(1, n+2):
        g.ajouter_arete(0, v, 0)
        g.ajouter_arete(v, n+2, n+1-v)
    for u in range(n+2, 2*n+2):
        g.ajouter_arete(u, u+1, 0)
    g.ajouter_arete(2*n+2, 2*n+3, n+1)
    return g


def graphe_6_heuristique(n, u):
    if u == 0:
        return n+1
    elif 1 <= u and u <= n+1:
        return u
    elif n+2 <= u <= 2*n+1:
        return 0
    elif u == 2*n + 2:
        return n+1
    else:  # u == 2*n + 3
        return 0


"""
for n in range(100, 105):
    print("GRAPHE 6", n)
    g = graphe_6(n)
    s, t = 0, 2*n + 3
    dist, pred, l = dijkstra_tasbinaire(g, s, t)
    print("NOMBRE DE SOMMETS TRAITÉS PAR L'ALGORITHME DE DJIKSTRA :", max(it for it in l if it is not None))
    # print(dist[t], chemin(s, t, pred))
    dist, c, l = a_star(g, lambda u: graphe_6_heuristique(n, u), s, t)
    print("NOMBRE DE SOMMETS TRAITÉS PAR L'ALGORITHME A*          :", max(it for it in l if it is not None))
    # print(dist, c)
quit()
"""


if __name__ == "__main__":
    import doctest

    # doctest.testmod(verbose=True, optionflags=doctest.FAIL_FAST)
    fonctions = [
        fptableau_creer,
        fptableau_ajouter,
        fptableau_retirer,
        fptableau_cout,
        fptableau_est_vide,
        chemin,
        dijkstra_fptableau,
        tasbinaire_creer,
        tasbinaire_ajouter,
        tasbinaire_retirer,
        tasbinaire_cout,
        tasbinaire_est_vide,
        dijkstra_tasbinaire,
        dijkstra_tasbinomial,
        bellman_ford,
        floyd_warshall,
        a_star,
    ]
    for f in fonctions:
        print("**********************************************************************")
        print(f.__name__)
        doctest.run_docstring_examples(
            f, globals(), optionflags=doctest.FAIL_FAST)