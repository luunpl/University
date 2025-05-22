try:
    from lib.sortedcontainers import SortedDict
except:
    from sortedcontainers import SortedDict

class Graphe:

    def __init__(self, n, e=None, **kwargs):
        """Crée un graph vide à n sommets.

            :param n: Nombre de sommet, entier naturel
            :param e: Liste d'arêtes

            :Examples:

            >>> # Graphe vide à 4 sommets
            >>> g = Graphe(4)

            >>> # Graphe à 3 sommets avec les arêtes 0-1 et 1-2
            >>> Graphe(3, [(0, 1), (1, 2)])
            {3: 0--1 1--2}

            >>> # Graphe à 3 sommets avec l'arête 0-1 de poids 10 et l'arête 1-2 de poids 20
            >>> Graphe(3, [(0, 1, 10), (1, 2, 20)])
            {3: 0-10-1 1-20-2}

            >>> # Graphe orienté à 3 sommets avec les arêtes 0-1 et 1-2
            >>> Graphe(3, [(0, 1, 10), (1, 2, 20)], oriente=True)
            {3: 0-10->1 1-20->2}

        """

        self.__oriente = kwargs.get("oriente", False)
        self.__aretes = []
        self.__m = 0
        self.__w = 0
        for u in range(0, n):
            self.__aretes.append(SortedDict())
        if e != None:
            for a in e:
                self.ajouter_arete(*a)

    def nombre_sommets(self):
        """Retourne le nombre de sommets du graphe.

            :Examples:

            >>> g = Graphe(4) # Graphe vide à 4 sommets
            >>> g.nombre_sommets()
            4

        """

        return len(self.__aretes)

    def nombre_aretes(self):
        """Retourne le nombre d'aretes du graphe.

            :Examples:

            >>> g = Graphe(4) # Graphe vide à 4 sommets
            >>> g.nombre_aretes()
            0
            >>> g.ajouter_arete(0, 1)
            >>> g.nombre_aretes()
            1
            >>> g.ajouter_arete(1, 2)
            >>> g.nombre_aretes()
            2

        """

        return self.__m

    def ajouter_arete(self, u, v, weights=None):
        """Ajoute une arête entre les sommets u et v.

            Une erreur est lancée si l'arête est déjà présente dans le graphe.

            :param u: Indice d'un sommet, compris entre 0 et n-1
            :param v: Indice d'un sommet, compris entre 0 et n-1, différent de u
            :param w: Poids de l'arête (uv)

            :Examples:

            >>> g = Graphe(3) # Graphe vide à 3 sommets
            >>> g.ajouter_arete(0, 1)
            >>> g
            {3: 0--1}
            >>> g.ajouter_arete(0, 2)
            >>> g
            {3: 0--1 0--2}
            >>> g.ajouter_arete(1, 2) # g est maintenant complet
            >>> g
            {3: 0--1 0--2 1--2}

            >>> g = Graphe(3, oriente=True)
            >>> g.ajouter_arete(0, 1)
            >>> g
            {3: 0-->1}
            >>> g.ajouter_arete(1, 0)
            >>> g
            {3: 0-->1 1-->0}

        """

        if self.__aretes[u].__contains__(v):
            raise Exception('L\'arête est déjà présente dans le graphe.')
        if u == v:
            raise Exception('Les deux sommets incidents à une arêtes doivent être distincts.')

        self.__aretes[u][v] = weights
        if not self.__oriente:
            self.__aretes[v][u] = weights
        if weights != None:
            self.__w += weights
        self.__m += 1

    def supprimer_arete(self, u, v):
        """Supprime l'arête entre les sommets u et v.

            :param u: Indice d'un sommet, compris entre 0 et n-1
            :param v: Indice d'un sommet, compris entre 0 et n-1, tel qu'il
            existe une arête entre u et v.

            :Examples:

            >>> g = Graphe(3, [(0, 1), (0, 2)])
            >>> g
            {3: 0--1 0--2}
            >>> g.supprimer_arete(0, 1)
            >>> g
            {3: 0--2}

        """

        self.__m -= 1
        w = self.__aretes[u].pop(v, None)
        if not self.__oriente:
            self.__aretes[v].pop(u, None)
        if w != None:
            self.__w -= w

    def supprimer_chemin(self, c):
        """Supprime toutes les arêtes du chemin c.

            :param c: Chemin, liste d'indices de sommets compris entre 0 et n-1

            :Examples:

            >>> g = Graphe(3, [(0, 1), (0, 2), (1, 2)])
            >>> g
            {3: 0--1 0--2 1--2}
            >>> g.supprimer_chemin([0, 1, 2])
            >>> g
            {3: 0--2}

        """

        for i in range(0, len(c)-1):
            self.supprimer_arete(c[i], c[i+1])

    def degre(self, u):
        """Retourne le degré du sommet u.

            :param u: Indice d'un sommet, compris entre 0 et n-1

            :Examples:

            >>> g = Graphe(4, [(0, 1), (0, 3)])
            >>> g.degre(0)
            2
            >>> g.degre(1)
            1
            >>> g.degre(2)
            0
            >>> g.degre(3)
            1

        """

        return len(self.__aretes[u])

    def voisins(self, u):
        """Retourne l'ensemble des voisins du sommet u.

            Les voisins peuvent ensuite être parcourus à l'aide d'une boucle for.
            Le nombre de voisins peut-être obtenu à l'aide de la fonction len.
            (cf exemples)

            :param u: Indice d'un sommet, compris entre 0 et n-1

            :Examples:

            >>> g = Graphe(4, [(0, 1), (0, 3)])
            >>> for v in g.voisins(0):
            ...     print(v)
            ...
            1
            3

        """

        return self.__aretes[u]

    def premier_voisin(self, u):
        """Retourne l'indice du premier voisin du sommet d'indice u.

            Le premier voisin est le voisin de plus petit indice.

            :param u: Indice d'un sommet, compris entre 0 et n-1, de degré >= 1

            :Examples:

            >>> g = Graphe(4, [(0, 1), (0, 3)])
            >>> g.premier_voisin(0)
            1

        """

        return next(iter(self.__aretes[u]))


    #############
    ### Poids ###
    #############

    def poids(self):
        """Retourne le poids total du graphe.

            :Examples:

            >>> g = Graphe(4, [(0, 1, 10), (0, 2, 20), (1, 3, 25)])
            >>> g.poids()
            55

        """

        return self.__w

    def voisins_avec_poids(self, u):
        """Retourne l'ensemble des voisins du sommet u avec le poids des arêtes
        correspondantes.

            Les voisins peuvent ensuite être parcourus à l'aide d'une boucle for.
            (cf exemples)

            :param u: Indice d'un sommet, compris entre 0 et n-1

            :Examples:

            >>> g = Graphe(4, [(0, 1, 10), (0, 3, 20)])
            >>> for v, poids in g.voisins_avec_poids(0):
            ...     print(v, poids)
            ...
            1 10
            3 20

        """

        return self.__aretes[u].items()


    ##################
    ### Operateurs ###
    ##################

    def __eq__(self, other):
        if isinstance(other, Graphe):
            return self.__aretes == other.__aretes
        return NotImplemented

    def __repr__(self):
        s = "{" + str(self.nombre_sommets()) + ":"
        for u in range(0, self.nombre_sommets()):
            for v,w in self.__aretes[u].items():
                if not self.__oriente and u > v:
                    continue
                s += " " + str(u) + "-"
                if w != None:
                    s += str(w)
                s += "-"
                if self.__oriente:
                    s += ">"
                s += str(v)
        s += "}"
        return s

    def __copy__(self):
        g = Graphe(self.nombre_sommets(), oriente=self.__oriente)
        for u in range(0, self.nombre_sommets()):
            for v, w in self.voisins_avec_poids(u):
                if self.__oriente or u < v:
                    g.ajouter_arete(u, v, w)
        return g


if __name__ == "__main__":
    import doctest
    doctest.testmod(verbose=True, optionflags=doctest.FAIL_FAST)

