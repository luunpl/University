from copy import *

# Version alternative : défenir les connecteur en version prefixe (avec des methodes de classe)
# Utilité de impl et eq ?


class Formule:
    def __init__(self, liste, variables):
        self.liste = liste
        self.variables = variables

    @classmethod
    def new_variable(cls, nom_var):
        """Fonction qui crée une formule constituée d'une variable"""
        return cls([["VAR", nom_var]],  {nom_var})

    @classmethod
    def new_bool(cls, b):
        """Fonction qui crée Une formule constituée d'un booléen"""
        return cls([["BOOL", b]], set())

    @classmethod
    def vrai(cls):
        """Fonction qui crée Une formule constituée d'un booléen"""
        return cls([["BOOL", "VRAI"]], set())

    @classmethod
    def faux(cls):
        """Fonction qui crée Une formule constituée d'un booléen"""
        return cls([["BOOL", "FAUX"]], set())

    def actualise(self, n):
        """Fonction qui à une formule et un entier n renvoie une formule où les positions sont incrémentées de n"""
        m = len(self.liste)
        new_l = deepcopy(self.liste)
        v = copy(self.variables)
        for i in range(m):
            if not isinstance(new_l[i][0], str):
                raise NameError("Formule mal formée")
            else:
                if new_l[i][0] == "VAR" or new_l[i][0] == "BOOL":
                    ()
                elif new_l[i][0] == "NON":
                    new_l[i][1] += n
                elif new_l[i][0] == "OU" or new_l[i][0] == "ET" or new_l[i][0] == "EQ" or new_l[i][0] == "IMPL":
                    new_l[i][1] += n
                    new_l[i][2] += n
                else:
                    raise NameError("Formule mal formée")
        return Formule(new_l, v)

    def get_variables(self):
        """renvoie les variable de la formule sous la forme d'une liste"""
        return(list(self.variables))
        #return(list(self.variables).sort())

    def f_not(self):
        """Fonction qui à une formule renvoie le NON des cette formule"""
        return Formule([["NON", 1]] + self.actualise(1).liste, copy(self.variables))

    def __neg__(self):
        """Fonction qui à une formule renvoie le NON des cette formule
            magic methods
        """
        return Formule([["NON", 1]] + self.actualise(1).liste, copy(self.variables))

    def f_ou(self, f2):
        """Fonction qui à deux formules renvoie le OU des deux formules"""
        l1 = len(self.liste)
        new_l = [["OU", 1, l1+1]] + self.actualise(1).liste + f2.actualise(l1+1).liste
        return Formule(new_l, copy(self.variables) | copy(f2.variables))

    def __add__(self, f2):
        """Fonction qui à deux formules renvoie le OU des deux formules
            magic methods
        """
        l1 = len(self.liste)
        new_l = [["OU", 1, l1+1]] + self.actualise(1).liste + f2.actualise(l1+1).liste
        return Formule(new_l, copy(self.variables) | copy(f2.variables))

    def f_et(self, f2):
        """Fonction qui à deux formules renvoie le ET des deux formules"""
        l1 = len(self.liste)
        new_l = [["ET", 1, l1+1]] + self.actualise(1).liste + f2.actualise(l1+1).liste
        return Formule(new_l, copy(self.variables) | copy(f2.variables))

    def __mul__(self, f2):
        """Fonction qui à deux formules renvoie le ET des deux formules
            magic methods
        """
        l1 = len(self.liste)
        new_l = [["ET", 1, l1+1]] + self.actualise(1).liste + f2.actualise(l1+1).liste
        return Formule(new_l, copy(self.variables) | copy(f2.variables))

    def eq(self, f2):
        """Fonction qui à deux formules renvoie le ET des deux formules"""
        l1 = len(self.liste)
        new_l = [["EQ", 1, l1+1]] + self.actualise(1).liste + f2.actualise(l1+1).liste
        return Formule(new_l, copy(self.variables) | copy(f2.variables))

    def impl(self, f2):
        """Fonction qui à deux formules renvoie le ET des deux formules"""
        l1 = len(self.liste)
        new_l = [["IMPL", 1, l1+1]] + self.actualise(1).liste + f2.actualise(l1+1).liste
        return Formule(new_l, copy(self.variables) | copy(f2.variables))

    def __str__(self):
        liste = self.liste
        n = len(liste)

        def aux(i, j):
            if not isinstance(liste[i][0], str):
                raise NameError("Formule mal formée")
            else:
                if liste[i][0] == "VAR" or liste[i][0] == "BOOL":
                    res = liste[i][1]
                elif liste[i][0] == "NON":
                    res = "NON ( " + aux(i+1, j) + " )"
                elif liste[i][0] == "OU" or liste[i][0] == "ET" or liste[i][0] == "EQ" or liste[i][0] == "IMPL":
                    k1 = liste[i][1]
                    k2 = liste[i][2]
                    res = "( " + aux(k1, k2-1) + " ) " + liste[i][0] + " ( " + aux(k2, j) + " ) "
                else:
                    raise NameError("Formule mal formée")
            return res
        return aux(0, n-1)

    def est_unitaire(self):
        """Prend en entrée une formule et renvoie True s'il s'agit d'une formule unitaire, False sinon"""
        if not isinstance(self.liste[0][0], str):
            raise NameError("Formule mal formée")
        else:
            if self.liste[0][0] == "VAR" or self.liste[0][0] == "BOOL":
                return True
            else:
                return False

    def get_val(self):
        """Prend en entrée une formule unitaire et renvoie sa valeur"""
        if not self.est_unitaire():
            raise NameError("Formule non unitaire")
        else:
             return self.liste[0][1]

    def operateur(self):
        """Prend en entrée une formule et renvoie son opérateur"""
        if not isinstance(self.liste[0][0], str):
            raise NameError("Formule mal formée")
        else:
            return self.liste[0][0]

    def nb_operandes(self):
        """Prend en entrée une formule et renvoie son nombre d'opérandes"""
        if not isinstance(self.liste[0][0], str):
            raise NameError("Formule mal formée")
        else:
            if self.liste[0][0] == "VAR" or self.liste[0][0] == "BOOL":
                return 0
            elif self.liste[0][0] == "NON":
                return 1
            elif self.liste[0][0] == "ET" or self.liste[0][0] == "OU" or self.liste[0][0] == "EQ" or self.liste[0][0] == "IMPL":
                return 2
            else:
                raise NameError("Formule mal formée")

    def decompose(self):
        """Prend en entrée une formule non unitaire et la décompose en une ou deux formules selon l'opérateur"""
        liste = self.liste
        n = len(liste)

        def ens_variables(i, j):
            res = set()
            for k in range(i, j):
                if liste[k][0] == "VAR":
                    res = res | {liste[k][0]}
            return res

        if not isinstance(liste[0][0], str):
            raise NameError("Formule mal formée")
        else:
            if liste[0][0] == "VAR" or liste[0][0] == "BOOL":
                raise NameError("Formule déjà unitaire")
            elif liste[0][0] == "NON":
                l_res = liste[1:n]
                return [(Formule(l_res, copy(self.variables))).actualise(-1)]
            elif liste[0][0] == "OU" or liste[0][0] == "ET" or liste[0][0] == "EQ" or liste[0][0] == "IMPL":
                k1 = liste[0][1]
                k2 = liste[0][2]
                l_res1 = liste[1:k2]
                l_res2 = liste[k2:n]
                return [(Formule(l_res1, ens_variables(1, k2))).actualise(-1*k1),
                        (Formule(l_res2, ens_variables(k2, n))).actualise(-1*k2)]
            else:
                raise NameError("Formule mal formée")
