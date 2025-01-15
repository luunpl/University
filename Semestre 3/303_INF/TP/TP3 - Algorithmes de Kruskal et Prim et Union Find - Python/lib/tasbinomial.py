import math

class Node:

    __slots__ = ['indice', 'cout', 'pere', 'fils_gauche', 'frere_droit']

    def __init__(self, v, c):
        self.indice = v
        self.cout   = c
        self.pere        = None
        self.fils_gauche = None
        self.frere_droit = None

    def __repr__(self):
        """Affiche l'arbre en utilisant un parcours préfixé.

        """

        s = ""
        if self.frere_droit != None:
            s += str(self.frere_droit) + " "
        s += "(" + str(self.indice) + ", " + str(self.cout) + ")"
        if self.fils_gauche != None:
            s += " " + str(self.fils_gauche)
        return s


class TasBinomial:

    def __init__(self, n):
        """Crée une file de priorité vide utilisant les tas binomiaux.

        """

        self.__noeuds = [None]*n

        # Number of elements
        self.__taille = 0

        # self.__rac[i]: root Node of binomial tree of order i
        self.__rac = [None]*(int(math.log(n, 2)) + 2)

        # self.__ord[i]: i if v is the indice of root Node of the binomial
        # tree of order i
        self.__ord = [None]*n

    def __fusionner(self, t1, t2):
        """Fusionne les tas t1 et t2 et renvoie la racine du nouveau tas.

        """

        if t1.cout <= t2.cout:
            tmin, tmax = t1, t2
        else:
            tmin, tmax = t2, t1
        tmax.frere_droit = tmin.fils_gauche
        tmax.pere = tmin
        tmin.fils_gauche = tmax
        return tmin

    def ajouter(self, v, c):
        """Ajoute l'élément d'indice v avec un cout c à la file.

            Si l'élément est déjà présent, sa valeur est mise-à-jour.

            :Examples:

            >>> f = TasBinomial(8)
            >>> f.ajouter(1, 3)
            >>> f
            {1: (1, 3)}
            >>> f.ajouter(3, 5)
            >>> f
            {2: (1, 3) (3, 5)}
            >>> f.ajouter(0, 4)
            >>> f
            {1: (0, 4); 2: (1, 3) (3, 5)}
            >>> f.ajouter(5, 7)
            >>> f
            {3: (1, 3) (3, 5) (0, 4) (5, 7)}
            >>> f.ajouter(5, 1)
            >>> f
            {3: (5, 1) (3, 5) (1, 3) (0, 4)}
            >>> f.ajouter(0, 2)
            >>> f
            {3: (5, 1) (3, 5) (0, 2) (1, 3)}

        """

        if self.__noeuds[v] == None:
            t = Node(v, c)
            self.__noeuds[v] = t
            i = 1
            while self.__rac[i] != None:
                ti = self.__rac[i]
                t = self.__fusionner(ti, t)
                self.__rac[i] = None
                i += 1
            self.__rac[i] = t
            self.__ord[t.indice] = i
            self.__taille += 1
        else: # Si l'élément est déjà présent dans la file
            t = self.__noeuds[v]
            t.cout = c # On met à jour son cout
            r = v # indice de la racine de l'arbre, nécessaire pour mettre à jour self.__ord
            # Tant que le cout de son père est inférieur, on l'échange avec lui.
            while t.pere != None and t.cout < t.pere.cout:
                p = t.pere
                if p.pere == None:
                    r = p.indice
                t.cout,   p.cout   = p.cout,   t.cout
                t.indice, p.indice = p.indice, t.indice
                self.__noeuds[t.indice] = t
                self.__noeuds[p.indice] = p
                t = p
            if t.pere == None: # On met à jour self.__ord
                self.__ord[t.indice] = self.__ord[r]

    def retirer(self):
        """Supprime et retourne l'élément l'élément de cout minimum de la file.

            :Examples:

            >>> f = TasBinomial(8)
            >>> f.ajouter(1, 3)
            >>> f.ajouter(3, 5)
            >>> f.ajouter(0, 4)
            >>> f.ajouter(5, 7)
            >>> f
            {3: (1, 3) (3, 5) (0, 4) (5, 7)}
            >>> f.retirer()
            (1, 3)
            >>> f
            {1: (3, 5); 2: (0, 4) (5, 7)}
            >>> f.retirer()
            (0, 4)
            >>> f
            {2: (3, 5) (5, 7)}
            >>> f.retirer()
            (3, 5)
            >>> f
            {1: (5, 7)}
            >>> f.retirer()
            (5, 7)
            >>> f
            {}

        """

        self.__taille -= 1 # On met à jour self.__taille

        # On parcours les racines pour trouver le nœud de cout minimum.
        noeud_min = None
        cout_min  = float('inf')
        for noeud in self.__rac:
            if noeud == None:
                continue
            if noeud.cout < cout_min:
                noeud_min = noeud
                cout_min  = noeud.cout

        i = self.__ord[noeud_min.indice] # Order du tas dont noeud_min est la racine.
        self.__rac[i] = None # noeud_min n'est plus une racine.
        self.__noeuds[noeud_min.indice] = None # On retire noeud_min de la liste des noeuds.

        # Si le tas i est celui d'ordre 1, on peut s'arrêter tout de suite.
        if self.__ord[noeud_min.indice] == 1:
            return (noeud_min.indice, noeud_min.cout)

        # Sinon on ajoute les sous-arbres de noeud_min de celui de plus grand
        # degré à celui de plus petit degré dans la liste des tas.
        t = noeud_min.fils_gauche
        k = i
        while t != None:
            t_suiv = t.frere_droit
            t.frere_droit = None
            t.pere = None

            k -= 1
            j = k
            while True:
                if self.__rac[j] == None:
                    self.__rac[j] = t
                    self.__ord[t.indice] = j
                    break
                ti = self.__rac[j]
                t = self.__fusionner(ti, t)
                self.__rac[j] = None
                self.__ord[t.indice] = j+1
                j += 1

            t = t_suiv

        return (noeud_min.indice, noeud_min.cout)

    def cout(self, v):
        """Retourne le cout de l'élément d'indice v.

        Retourne float('inf') si l'élément d'indice v n'est pas dans la file.

            :Examples:

            >>> f = TasBinomial(8)
            >>> f.cout(1)
            inf
            >>> f.ajouter(1, 3)
            >>> f.cout(1)
            3
            >>> f.cout(0)
            inf
            >>> f.ajouter(1, 5)
            >>> f.cout(1)
            5

        """

        if self.__noeuds[v] == None:
            return float('inf')
        return self.__noeuds[v].cout

    def __len__(self):
        """Retourne le nombre d'éléments de la file.

            :Examples:

            >>> f = TasBinomial(8)
            >>> len(f)
            0
            >>> f.ajouter(2, 3)
            >>> len(f)
            1
            >>> f.ajouter(2, 4)
            >>> len(f)
            1
            >>> f.ajouter(3, 2)
            >>> len(f)
            2
            >>> a = f.retirer()
            >>> len(f)
            1
            >>> a = f.retirer()
            >>> len(f)
            0

            >>> k = 50
            >>> f = TasBinomial(k)
            >>> for i in range(k):
            ...    f.ajouter(i, 2*i)
            >>> len(f)
            50
            >>> for i in range(k):
            ...    f.ajouter(i, i)
            >>> len(f)
            50
            >>> for i in range(k):
            ...    a = f.retirer()
            >>> len(f)
            0

        """

        return self.__taille

    def est_vide(self):
        """Retourne True ssi la file est vide.

            :Examples:

            >>> f = TasBinomial(8)
            >>> f.est_vide()
            True
            >>> f.ajouter(2, 3)
            >>> f.est_vide()
            False
            >>> f.ajouter(2, 4)
            >>> f.est_vide()
            False
            >>> f.ajouter(3, 2)
            >>> f.est_vide()
            False
            >>> a = f.retirer()
            >>> f.est_vide()
            False
            >>> a = f.retirer()
            >>> f.est_vide()
            True

        """

        return self.__taille == 0

    def __repr__(self):
        s = "{"
        first = True
        for i in range(len(self.__rac)):
            if self.__rac[i] == None:
                continue
            if self.__rac[i].frere_droit != None:
                print("erreur")
            if not first:
                s += "; "
            else:
                first = False
            s += str(i) + ": " + str(self.__rac[i])
        s += "}"
        return s


if __name__ == "__main__":
    import doctest
    doctest.testmod(verbose=True, optionflags=doctest.FAIL_FAST)

