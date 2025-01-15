###############################################
### TP3 - Arbres couvrants de poids minimum ###
###############################################

import copy
from lib.graphe      import Graphe
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
tous les tests ne garantie pas qu'elle soit correcte. Gardez cela en tête
lorsque vous réutilisez vos fonctions dans d'autres fonctions.

---

Dans ce TP, les graphes sont des graphes avec des poids sur les arêtes.
Pensez à regarder les documentations et exemples de la classe Graphe,
notamment pour les méthodes __init__, ajouter_arete et voisins_avec_poids.
"""


#####################################
### Algorithme de Kruskal inversé ###
#####################################

def graphe_1():
    """Retourne le graphe (Graphe) G1.

        -------------------
        --- OBLIGATOIRE ---
        -------------------

                2
               /|
              / |
             /  |
          2 /   | 3          G1
           /    |
          /     |
         /      |
        0-------1-------3
            1       4

        :Examples:

        >>> graphe_1()
        {4: 0-1-1 0-2-2 1-3-2 1-4-3}

    """

    return Graphe(4, [(0, 1, 1), (0, 2, 2), (1, 2, 3), (1, 3, 4)])

def graphe_2():
    """Retourne le graphe (Graphe) G2.

        -------------------
        --- OBLIGATOIRE ---
        -------------------

            11
        0--------1
        |\      /|
        | \10 9/ |
        |  \  /  |
        |   \/   |
        |1  /\  4|            G2
        |  /  \  |
        | /    \ |
        |/      \|
        2--------3
            3

        :Examples:

        >>> graphe_2()
        {4: 0-11-1 0-1-2 0-10-3 1-9-2 1-4-3 2-3-3}

    """

    return Graphe(4, [(0, 1, 11), (0, 2, 1), (0, 3, 10), (1, 2, 9), (1, 3, 4), (2, 3, 3)])

def graphe_3(n):
    """Retourne un graphe à n sommet, tel qu'il existe une arête entre i et j si
    et seulement si |j-i| <= 2 et le poids de l'arête (ij) est i+j.

        -------------------
        --- OBLIGATOIRE ---
        -------------------

                4
            1-------3-----
           / \     / \
         1/  3\  5/  7\       etc        G3
         /     \ /     \ /
        0-------2-------4
            2       6

        :param n: Nombre de sommets, entier naturel supérieur ou égal à 3

        :Examples:

        >>> graphe_3(3)
        {3: 0-1-1 0-2-2 1-3-2}
        >>> graphe_3(4)
        {4: 0-1-1 0-2-2 1-3-2 1-4-3 2-5-3}
        >>> graphe_3(5)
        {5: 0-1-1 0-2-2 1-3-2 1-4-3 2-5-3 2-6-4 3-7-4}

    """

    g = Graphe(n)
    for i in range(n):
        for j in range(i + 1, min(i + 3, n)):
            g.ajouter_arete(i, j, i + j)
    return g

def aretes_triees(g):
    """Retourne la liste des arêtes de g triées par poids croissant.

        Les arêtes (uv) sont tel que u < v.

        -------------------
        --- OBLIGATOIRE ---
        -------------------

        :Examples:

        >>> aretes_triees(graphe_1())
        [(0, 1, 1), (0, 2, 2), (1, 2, 3), (1, 3, 4)]
        >>> aretes_triees(graphe_2())
        [(0, 2, 1), (2, 3, 3), (1, 3, 4), (1, 2, 9), (0, 3, 10), (0, 1, 11)]


    """

    # Pour trier une liste l de tuples selon leur ieme composante :
    # >>> l.sort(key=lambda t: t[i])

    aretes = []
    for u in range(g.nombre_sommets()):
        for v, poids in g.voisins_avec_poids(u):
            if u < v:
                aretes.append((u, v, poids))
    aretes.sort(key=lambda t: t[2])
    return aretes

def est_connexe(g):
    """Retourne True si g est connexe, False sinon.

        -------------------
        --- OBLIGATOIRE ---
        -------------------

        :param g: Un graphe (Graphe)

        :Examples:

        >>> est_connexe(graphe_1())
        True
        >>> est_connexe(graphe_2())
        True
        >>> est_connexe(Graphe(1))
        True
        >>> est_connexe(Graphe(6, [(0, 1), (1, 2), (2, 3), (3, 4), (4, 5)]))
        True
        >>> est_connexe(Graphe(6, [(0, 1), (1, 2), (2, 3), (3, 4), (3, 5), (4, 5)]))
        True
        >>> est_connexe(Graphe(2))
        False
        >>> est_connexe(Graphe(5))
        False
        >>> est_connexe(Graphe(4, [(0, 1), (2, 3)]))
        False
        >>> est_connexe(Graphe(5, [(0, 1), (1, 2), (2, 3)]))
        False
        >>> est_connexe(Graphe(5, [(i, j) for i in range(0, 4) for j in range(i+1, 4)]))
        False
        >>> est_connexe(Graphe(6, [(i, j) for i in range(0, 5) for j in range(i+1, 5)]))
        False
        >>> est_connexe(Graphe(6, [(0, 1), (0, 2), (1, 2), (3, 4), (4, 5), (3, 5)]))
        False
        >>> est_connexe(Graphe(8,
        ...     [(i, j) for i in range(0, 4) for j in range(i+1, 4)] +
        ...     [(i, j) for i in range(4, 8) for j in range(i+1, 8)]))
        ...
        False

    """

    # Si vous aviez déjà implémenté cette fonction au TP précédent, vous pouvez
    # réutiliser votre code.

    def dfs(v, visited):
        visited[v] = True
        for u, _ in g.voisins_avec_poids(v):
            if not visited[u]:
                dfs(u, visited)

    n = g.nombre_sommets()
    if n == 0:
        return True

    visited = [False] * n
    dfs(0, visited)

    return all(visited)


def kruskal_inverse(g):
    """Retourne un arbre couvrant de poids minimum du graphe g en utilisant
    l'algorithme de Kruskal inverse.

        -------------------
        --- OBLIGATOIRE ---
        -------------------

        :param g: un graphe (Graphe) connexe
        :return: un couple (t, l) où
        * t est un arbre (Graphe) couvrant de poids minimum de g
        * l est la liste telle que l[i] est l'arête retirée à l'itération i
        (None si aucune arête n'est retirée)

        :Examples:

        >>> kruskal_inverse(graphe_1())
        ({4: 0-1-1 0-2-2 1-4-3}, [None, (1, 2)])
        >>> kruskal_inverse(graphe_2())
        ({4: 0-1-2 1-4-3 2-3-3}, [(0, 1), (0, 3), (1, 2)])
        >>> kruskal_inverse(graphe_3(4))
        ({4: 0-1-1 0-2-2 1-4-3}, [(2, 3), None, (1, 2)])
        >>> kruskal_inverse(graphe_3(5))
        ({5: 0-1-1 0-2-2 1-4-3 2-6-4}, [(3, 4), None, (2, 3), None, (1, 2)])

    """

    t = copy.deepcopy(g)
    l = []

    aretes = aretes_triees(g)
    for u, v, poids in reversed(aretes):
        if t.nombre_aretes() == t.nombre_sommets() - 1:
            break
        t.supprimer_arete(u, v)
        if est_connexe(t):
            l.append((u, v))
        else:
            t.ajouter_arete(u, v, poids)
            l.append(None)
    
    return (t, l)

#############################
### Algorithme de Kruskal ###
#############################

########################################################
### Union-Find : Implémentation utilisant un tableau ###
########################################################

# Pour implémenter la version classique de l'algorithme de Kruskal, nous allons
# utiliser une structure UNION-FIND que nous allons implémenter.
# On numérote les composantes connexes de la forêt courante. Au début de
# l'algorithme, comme il n'y a pas encore d'arête, chaque sommet est seul dans
# sa composante connexe. Si lorsque l'on examine l'arête (uv), u et v
# appartiennent à la même composante connexe, alors on n'ajoute pas l'arête,
# sinon on l'ajoute et on met à jour notre structure pour fusionner les
# composantes connexes de u et de v.

# Pour la première implémentation de la structure UNION-FIND, nous allons
# utiliser un tableau T (une liste en Python) tel que T[i] est l'indice de la
# composante connexe à laquelle le sommet i appartient.

def ufl_creer(n):
    """Retourne la structure UNION-FIND initialisée.

        -------------------
        --- OBLIGATOIRE ---
        -------------------

        :param n: Nombre de sommets, entier naturel

        :Examples:

        >>> ufl_creer(2)
        [0, 1]
        >>> ufl_creer(5)
        [0, 1, 2, 3, 4]

    """

    return list(range(n))

def ufl_find(l, v):
    """Retourne l'indice de la composante connexe du sommet i dans la structure
    UNION-FIND l.

        -------------------
        --- OBLIGATOIRE ---
        -------------------

        :param v: Un indice d'un sommet, entier naturel compris entre 0 et n-1.

        :Examples:

        >>> l = [0, 0, 1, 0, 2, 3, 4]
        >>> ufl_find(l, 1)
        0
        >>> ufl_find(l, 6)
        4

    """

    while l[v] != v:
        v = l[v]
    return v

def ufl_union(l, i, j):
    """Fusionne les composantes connexes d'indice i et j dans la structure
    UNION-FIND l.

        L'indice de la nouvelle composante connexe est min(i,j).

        -------------------
        --- OBLIGATOIRE ---
        -------------------

        :param i: Un indice d'une composante connexe, i in l
        :param j: Un indice d'une composante connexe, j in l, j != i

        :Examples:

        >>> l = [0, 0, 1, 0, 2, 4, 4]
        >>> ufl_union(l, 1, 0)
        >>> l
        [0, 0, 0, 0, 2, 4, 4]
        >>> ufl_union(l, 4, 2)
        >>> l
        [0, 0, 0, 0, 2, 2, 2]

    """

    root_i = ufl_find(l, i)
    root_j = ufl_find(l, j)
    if root_i != root_j:
        if root_i < root_j:
            for k in range(len(l)):
                if l[k] == root_j:
                    l[k] = root_i
        else:
            for k in range(len(l)):
                if l[k] == root_i:
                    l[k] = root_j

def kruskal_ufl(g):
    """Retourne un arbre couvrant de poids minimum du graphe g en utilisant
    l'algorithme de Kruskal avec la structure UNION-FIND utilisant un tableau.

        -------------------
        --- OBLIGATOIRE ---
        -------------------

        :param g: un graphe (Graphe) connexe
        :return: un couple (t, l) où
        * t est un arbre (Graphe) couvrant de poids minimum de g
        * l est la liste telle que l[i] est l'arête ajoutée à l'itération i
        (None si aucune arête n'est ajoutée)

        :Examples:

        >>> kruskal_ufl(graphe_1())
        ({4: 0-1-1 0-2-2 1-4-3}, [(0, 1), (0, 2), None, (1, 3)])
        >>> kruskal_ufl(graphe_2())
        ({4: 0-1-2 1-4-3 2-3-3}, [(0, 2), (2, 3), (1, 3)])
        >>> kruskal_ufl(graphe_3(4))
        ({4: 0-1-1 0-2-2 1-4-3}, [(0, 1), (0, 2), None, (1, 3)])
        >>> kruskal_ufl(graphe_3(5))
        ({5: 0-1-1 0-2-2 1-4-3 2-6-4}, [(0, 1), (0, 2), None, (1, 3), None, (2, 4)])

    """

    n = g.nombre_sommets()
    t = Graphe(n)
    uf = ufl_creer(n)
    l = []

    aretes = aretes_triees(g)
    for u, v, poids in aretes:
        if t.nombre_aretes() == t.nombre_sommets() - 1:
            break
        root_u = ufl_find(uf, u)
        root_v = ufl_find(uf, v)
        if root_u != root_v:
            t.ajouter_arete(u, v, poids)
            ufl_union(uf, root_u, root_v)
            l.append((u, v))
        else:
            l.append(None)

    return (t, l)

########################################################
### Union-Find : Implémentation utilisant des forêts ###
########################################################

# Essayons de lancer l'algorithme écrit précédemment sur un graphe avec un
# nombre élevé de sommets.
# Décommentez les lignes suivantes et exécutez votre programme :

"""
t0 = time.time()

kruskal_ufl(graphe_3(4096)) # 0.62s sur ma machine (Intel Core i5)
t1 = time.time()
print("KRUSKAL_UFL: ", round(t1-t0, 2), "s", sep="")

quit()
"""

# (Vous pouvez ensuite les commenter à novueau)
# On constate qu'il faut plus d'une demi-seconde pour que l'algorithme se
# termine. En fait, ce sont les appels à la fonction union qui prennent le plus
# de temps lors de l'exécution. En effet, lors de l'appel de cette fonction, il
# faut parcourir la liste en entier. Dans l'implémentation suivante, cette
# fonction ne demande que log(n) opérations, voire moins (en contrepartie, la
# fonction find demandera quant à elle un peu plus d'opérations aussi).
# Pour les détails, lisez l'article consacré sur Wikipédia :
# https://fr.wikipedia.org/wiki/Union-find#Impl%C3%A9mentation_utilisant_des_for%C3%AAts
# Pensez à bien implémenter toutes les optimisations proposées.

def uff_creer(n):
    """Retourne la structure UNION-FIND initialisée.

        La structure est une liste de n couples tel que le premier élément du
        couple i indique le parent de l'élément i (ou i si l'élément est la
        racine), et si l'élément i est la racine, le second élément indique le
        rang de l'ensemble i.

        :param n: Nombre de sommets, entier naturel

        :Examples:

        >>> uff_creer(2)
        [[0, 0], [1, 0]]
        >>> uff_creer(5)
        [[0, 0], [1, 0], [2, 0], [3, 0], [4, 0]]

    """

    ### À COMPLÉTER DÉBUT (1 ligne(s))
    return [[i, 0] for i in range(n)]
    ### À COMPLÉTER FIN

def uff_find(l, v):
    """Retourne l'indice de la composante connexe du sommet i dans la structure
    UNION-FIND l.

        Implémente la compression de chemin comme illustré dans les exemples
        ci-dessous.

        :param v: Un indice d'un sommet, entier naturel compris entre 0 et n-1.

        :Examples:

                 0(3)
               / | \
              /  |  \
             /   |   \
            1(0) 2(1) 4(2)
                 |    | \
                 |    |  \
                 |    |   \
                 3(0) 5(0) 6(1)
                           |
                           |
                           |
                           7(0)

        >>> l = [[0, 3], [0, 0], [0, 1], [2, 0], [0, 2], [4, 0], [4, 1], [6, 0]]
        >>> uff_find(l, 0)
        0
        >>> l # non modifiée
        [[0, 3], [0, 0], [0, 1], [2, 0], [0, 2], [4, 0], [4, 1], [6, 0]]

        >>> uff_find(l, 1)
        0
        >>> l # non modifiée
        [[0, 3], [0, 0], [0, 1], [2, 0], [0, 2], [4, 0], [4, 1], [6, 0]]

        >>> uff_find(l, 4)
        0
        >>> l # non modifiée
        [[0, 3], [0, 0], [0, 1], [2, 0], [0, 2], [4, 0], [4, 1], [6, 0]]

        >>> uff_find(l, 3)
        0
        >>> l # Le nœud 3 n'est plus fils du nœud 2 mais de la racine 0.
        [[0, 3], [0, 0], [0, 1], [0, 0], [0, 2], [4, 0], [4, 1], [6, 0]]

                    0(3)
                    .
                    .
                    .
            1(0) 2(1) 3(0) 4(2)
                           | \
                           |  \
                           |   \
                           5(0) 6(1)
                                |
                                |
                                |
                                7(0)

        >>> uff_find(l, 7)
        0
        >>> l # Les nœud 6 et 7 deviennent des fils de la racine.
        [[0, 3], [0, 0], [0, 1], [0, 0], [0, 2], [4, 0], [0, 1], [0, 0]]

                         0(3)
                         .
                         .
                         .
            1(0) 2(1) 3(0) 4(2) 6(1) 7(0)
                           |
                           |
                           |
                           5(0)


    """

    if not l:
        return None
    if l[v][0] != v:
        l[v][0] = uff_find(l, l[v][0])
    return l[v][0]


def uff_union(l, i, j):
    """Fusionne les composantes connexes d'indice i et j dans la structure
    UNION-FIND l.

        Si les composantes d'indice i et j ont même rang, alors la racine
        de l'union est la racine de i.

        :param i: Un indice d'une composante connexe, i in l
        :param j: Un indice d'une composante connexe, j in l, j != i

        :Examples:

            rang(i) != rang(j)

            1(1)  2(0)                   1(1)
            |                ->         / \
            |                          /   \
            0(0)                      0(1)  2(0)

        >>> l = [[1, 0], [1, 1], [2, 0]]
        >>> uff_union(l, 1, 2)
        >>> l
        [[1, 0], [1, 1], [1, 0]]

            2(1)  1(0)                   2(1)
            |                ->         / \
            |                          /   \
            0(0)                      0(1)  1(0)

        >>> l = [[2, 0], [1, 0], [2, 1]]
        >>> uff_union(l, 1, 2)
        >>> l
        [[2, 0], [2, 0], [2, 1]]

            rang(i) == rang(j)

            1(1)  2(1)   uff_union(1, 2)   1(2)
            |     |           ->          / \
            |     |                      /   \
            0(0)  3(0)                  0(0)  2(1)
                                              |
                                              |
                                              3(0)

        >>> l = [[1, 0], [1, 1], [2, 1], [2, 0]]
        >>> uff_union(l, 1, 2)
        >>> l
        [[1, 0], [1, 2], [1, 1], [2, 0]]

            1(1)  2(1)   uff_union(2, 1)   2(2)
            |     |           ->          / \
            |     |                      /   \
            0(0)  3(0)                  3(0)  1(1)
                                              |
                                              |
                                              0(0)

        >>> l = [[1, 0], [1, 1], [2, 1], [2, 0]]
        >>> uff_union(l, 2, 1)
        >>> l
        [[1, 0], [2, 1], [2, 2], [2, 0]]

    """

    ri = l[i][1]
    ### À COMPLÉTER DÉBUT (7 ligne(s))
    root_i = uff_find(l, i)
    root_j = uff_find(l, j)
    if root_i != root_j:
        if l[root_i][1] > l[root_j][1]:
            l[root_j][0] = root_i
        elif l[root_i][1] < l[root_j][1]:
            l[root_i][0] = root_j
        else:
            l[root_j][0] = root_i
            l[root_i][1] += 1
    ### À COMPLÉTER FIN

def kruskal_uff(g):
    """Retourne un arbre couvrant de poids minimum du graphe g en utilisant
    l'algorithme de Kruskal avec la structure UNION-FIND utilisant des forêts.

        :param g: un graphe (Graphe) connexe
        :return: un couple (t, l) où
        * t est un arbre (Graphe) couvrant de poids minimum de g
        * l est la liste telle que l[i] est l'arête ajoutée à l'itération i
        (None si aucune arête n'est ajoutée)

        :Examples:

        >>> kruskal_uff(graphe_1())
        ({4: 0-1-1 0-2-2 1-4-3}, [(0, 1), (0, 2), None, (1, 3)])
        >>> kruskal_uff(graphe_2())
        ({4: 0-1-2 1-4-3 2-3-3}, [(0, 2), (2, 3), (1, 3)])
        >>> kruskal_uff(graphe_3(4))
        ({4: 0-1-1 0-2-2 1-4-3}, [(0, 1), (0, 2), None, (1, 3)])
        >>> kruskal_uff(graphe_3(5))
        ({5: 0-1-1 0-2-2 1-4-3 2-6-4}, [(0, 1), (0, 2), None, (1, 3), None, (2, 4)])
        >>> kruskal_uff(Graphe(7, [(0, 1, 1), (1, 2, 2), (3, 4, 3), (2, 4, 4), (0, 2, 5), (3, 5, 7), (0, 5, 6), (0, 6, 10)]))
        ({7: 0-1-1 0-6-5 0-10-6 1-2-2 2-4-4 3-3-4}, [(0, 1), (1, 2), (3, 4), (2, 4), None, (0, 5), None, (0, 6)])

    """

    n = g.nombre_sommets()
    uf = uff_creer(n)
    t = Graphe(n)
    l = []

    ### À COMPLÉTER DÉBUT (13 ligne(s))
    n = g.nombre_sommets()
    uf = uff_creer(n)
    t = Graphe(n)
    l = []

    aretes = aretes_triees(g)
    for u, v, poids in aretes:
        if t.nombre_aretes() == t.nombre_sommets() - 1:
            break
        root_u = uff_find(uf, u)
        root_v = uff_find(uf, v)
        if root_u != root_v:
            t.ajouter_arete(u, v, poids)
            uff_union(uf, root_u, root_v)
            l.append((u, v))
        else:
            l.append(None)

    return (t, l)
    ### À COMPLÉTER FIN


# Décommentez les lignes suivantes pour comparer la différence de temps
# d'exécution entre les deux implémentations de la structure UNION-FIND:

"""
t0 = time.time()
n = 4096
g = graphe_3(n)

kruskal_ufl(g) # 0.62s sur ma machine (Intel Core i5)
t1 = time.time()
print("KRUSKAL_UFL: ", round(t1-t0, 2), "s", sep="")

kruskal_uff(g) # 0.13s sur ma machine (Intel Core i5)
t2 = time.time()
print("KRUSKAL_UFF: ", round(t2-t1, 2), "s", sep="")

quit()
"""


##########################
### Algorithme de Prim ###
##########################

# Le pseudo-code de l'algorithme de Prim se trouve sur Wikipédia :
# https://fr.wikipedia.org/wiki/Algorithme_de_Prim
# Son implémentation requiert l'utilisation d'une structure de file de
# priorité. Il ne vous est pas demandé d'implémenter une telle structure pour
# ce TP (mais ça le sera pour le TP suivant :) ). Ici, vous pouvez utiliser la
# classe TasBinomial qui vous est fournie et s'utilise ainsi :

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

def prim(g):
    """Retourne un arbre couvrant de poids minimum du graphe g en utilisant
    l'algorithme de Prim.

        Le sommet de départ est le sommet d'indice 0.

        :param g: un graphe (Graphe) connexe
        :return: un couple (t, l) où
        * t est un arbre (Graphe) couvrant de poids minimum de g
        * l est une liste telle que l[u] est l'itération à laquelle le sommet u
        a été traité.

        :Examples:

        >>> prim(graphe_1())
        ({4: 0-1-1 0-2-2 1-4-3}, [0, 1, 2, 3])
        >>> prim(graphe_2())
        ({4: 0-1-2 1-4-3 2-3-3}, [0, 3, 1, 2])
        >>> prim(graphe_3(4))
        ({4: 0-1-1 0-2-2 1-4-3}, [0, 1, 2, 3])
        >>> prim(graphe_3(5))
        ({5: 0-1-1 0-2-2 1-4-3 2-6-4}, [0, 1, 2, 3, 4])

    """

    # Petite astuce pour économiser une ligne :
    # >>> it = iter(range(n))
    # >>> next(it)
    # 0
    # >>> next(it)
    # 1
    # ...

    n = g.nombre_sommets()
    pred = [None]*n
    l    = [None]*n # l[v] == None <=> v n'a pas encore été ajouté
    t = Graphe(n)
    f = TasBinomial(n)
    it = iter(range(n))

    ### À COMPLÉTER DÉBUT (10 ligne(s))
    n = g.nombre_sommets()
    pred = [None] * n
    l = [None] * n
    t = Graphe(n)
    f = TasBinomial(n)
    it = iter(range(n))

    f.ajouter(0, 0)
    for i in it:
        u, _ = f.retirer()
        l[u] = i
        if pred[u] is not None:
            t.ajouter_arete(u, pred[u], g.voisins_avec_poids(u)[pred[u]])
        for v, poids in g.voisins_avec_poids(u):
            if l[v] is None and poids < f.cout(v):
                f.ajouter(v, poids)
                pred[v] = u

    return (t, l)
    ### À COMPLÉTER FIN

def graphe_4(n):
    """Retourne le graphe G4 à n+2 sommet, tel que le sous-graphe induit par les
    n premiers sommets est complet avec un poids de 2 sur chaque arête, et G4
    contient les arêtes (0,n) avec un poids de 1 et (0,n+1) avec un poids de 3.

        :param n: Nombre de sommets, entier naturel non nul

        n
         \     /2
         3\   /
           \ /  2
            0---- ...
           / \
         1/   \
         /     \2
        n+1

        :Examples:

        >>> graphe_4(1)
        {3: 0-1-1 0-3-2}
        >>> graphe_4(2)
        {4: 0-2-1 0-1-2 0-3-3}
        >>> graphe_4(3)
        {5: 0-2-1 0-2-2 0-1-3 0-3-4 1-2-2}

    """

    g = Graphe(n+2)
    for u in range(n):
        for v in range(u+1, n):
            g.ajouter_arete(u, v, 2)
    g.ajouter_arete(0, n,   1)
    g.ajouter_arete(0, n+1, 3)
    return g

# Décommentez les lignes suivantes pour comparer la différence de temps
# d'exécution entre les différents algorithmes implémentés.
# Quelques résultats à noter :
# * L'algorithme de Kruskal inversé est toujours beaucoup plus lent que les
# autres algorithmes.
# * L'algorithme de Prim est le plus efficace sur les graphes denses, comme
# G4(n). Il bat largement les différentes versions de l'algorithme de Kruskal.
# * L'algorithme de Kruskal avec l'UNION-FIND utilisant les forêts est le plus
# rapide sur les graphes peu denses, comme G3(n), mais Prim n'est vraiment pas
# loin.
# * Sur les graphes denses, comme G4(n), l'algorithme de Kruskal avec
# l'UNION-FIND utilisant les forêts est un peu moins rapide que celui utilisant
# le tableau.

"""
g = graphe_4(1024)
# g = graphe_3(8192)
t0 = time.time()

# kruskal_inverse(g) # Beaucoup trop long sur ma machine... (Intel Core i5)
t1 = time.time()
# print("KRUSKAL_INV: ", round(t1-t0, 2), "s", sep="")

kruskal_ufl(g) # 0.48s sur ma machine (Intel Core i5)
t2 = time.time()
print("KRUSKAL_UFL: ", round(t2-t1, 2), "s", sep="")

kruskal_uff(g) # 0.63s sur ma machine (Intel Core i5)
t3 = time.time()
print("KRUSKAL_UFF: ", round(t3-t2, 2), "s", sep="")

prim(g) # 0.3s sur ma machine (Intel Core i5)
t4 = time.time()
print("PRIM:        ", round(t4-t3, 2), "s", sep="")

quit()
"""


if __name__ == "__main__":
    import doctest
    fonctions = [
            graphe_1,
            graphe_2,
            graphe_3,
            aretes_triees,
            est_connexe,
            kruskal_inverse,
            ufl_creer,
            ufl_find,
            ufl_union,
            kruskal_ufl,
            uff_creer,
            uff_find,
            uff_union,
            kruskal_uff,
            prim,
    ]
    for f in fonctions:
        print("**********************************************************************")
        print(f.__name__)
        doctest.run_docstring_examples(f, globals(), optionflags=doctest.FAIL_FAST)

