"""
Ecrire une fonction sommeDivPropre qui reçoit un entier naturel n, et calcule et renvoie la somme de ses diviseurs propres (ses diviseurs autres que lui-même).
Exemples:
sommeDivPropre(0) renvoie 0
sommeDivPropre(1) renvoie 0
sommeDivPropre(4) renvoie 3
sommeDivPropre(6) renvoie 6

Un entier naturel est dit parfait s’il est égal à la somme de tous ses diviseurs propres. Ecrire une fonction estParfait qui teste si un entier naturel reçu en paramètre est parfait (en utilisant la fonction précédente).
Exemples:
estParfait(6) renvoie True
estParfait(10) renvoie False

Ecrire une fonction parfaits_entre qui reçoit deux entiers binf et bsup (optionnels, valeurs par défaut respectivement 2 et 100), et affiche tous les nombres parfaits de l’intervalle \texttt{[binf,bsup]}, sur une seule ligne, séparés par un espace. On respectera strictement le modèle des exemples ci-dessous.
Exemples:
        parfaits_entre()
         Nombres parfaits de [2,100]
         6 2800
        parfaits_entre(binf=7)
         Nombres parfaits de [7,100]
         28
"""


def sommeDivPropre(n):
    L = []
    for i in range(1, n):
        if n % i == 0:
            L.append(i)
    return sum(L)


def estParfait(entier):
    return entier == sommeDivPropre(entier)


def parfaits_entre(binf=2, bsup=100):
    for i in range(binf, bsup + 1):
        if estParfait(i):
            print(i, end="")
    return ""
