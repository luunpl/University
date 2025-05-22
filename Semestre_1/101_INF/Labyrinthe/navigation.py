
# -*- coding: utf-8 -*-

"""
--------------------------------------------------------------------------------
navigation.py : déplacement de la tortue / turtle motions

SPDX-FileCopyrightText: 2022 UGA            <carole.adam@univ-grenoble-alpes.fr>
SPDX-License-Identifier: CC-BY-NC-SA-4.0

Voir l'avis de copyright à la fin de ce fichier.
See copyright notice at the end of this file.
--------------------------------------------------------------------------------
"""

# ----- CODE DE navigation.py -----
import turtle as tt

dis = 30


def gauche():
    tt.setheading(0)
    l = cell2pixel(xcor(), ycor())
    r = typeCellule(l[0]-1, l[1], dicoJeu)
    if r == "passage" or r == "entrée" or r == "sortie":
        tt.penup()
        tt.left(180)
        tt.forward(dis)
        tt.pendown()
    print("gauche ; left")


def droite():
    tt.setheading(0)
    tt.penup()
    tt.forward(dis)
    tt.pendown()
    print("droite ; right")


def bas():
    tt.setheading(0)
    tt.penup()
    tt.right(90)
    tt.forward(dis)
    tt.pendown()
    print("bas ; down")


def haut():
    tt.setheading(0)
    tt.penup()
    tt.left(90)
    tt.forward(dis)
    tt.pendown()
    print("haut ; up")


# key bindings
# tt.onkeypress(gauche, "Left")
# tt.onkeypress(droite, "Right")
# tt.onkeypress(haut, "Up")
# tt.onkeypress(bas, "Down")
# tt.listen()

# # start loop
# tt.goto(0, 0)
# tt.mainloop()


# ***************************** AVIS DE COPYRIGHT ******************************
#
#     English translation hereinafter.
#
#     Ce  document est  mis à  disposition sous  LICENCE Creative  Commons
#   « Attribution - Pas d'utilisation commerciale - Partage dans les Mêmes
#   Conditions 4.0 International » (CC BY-NC-SA  4.0) dont les termes sont
#   détaillés  dans  le  fichier  CC-BY-NC-SA-4.0.txt  situé dans le sous-
#   répertoire LICENSES, ou bien sur :
#   http://creativecommons.org/licenses/by-nc-sa/4.0
#
#     Selon  les  conditions  résumées   ci-dessous,  vous  êtes  autorisé
#   à  partager  (copier, distribuer,  communiquer  ce  document par  tous
#   moyens et sous tous formats),  et adapter (remixer, transformer, créer
#   à partir de ce document) :
#     * Attribution : vous devez créditer l'Oeuvre (nom du créateur et des
#     personnes  à attribuer,  notice explicative  des droits  et crédits,
#     notice  de non-responsabilité  et lien  vers l'Oeuvre),  intégrer un
#     lien  vers la  licence  et  indiquer si  des  modifications ont  été
#     effectuées  à  l'Oeuvre  (et   conserver  les  indications  sur  les
#     précédentes modifications). Vous devez indiquer ces informations par
#     tous les moyens raisonnables,  sans toutefois suggérer que l'Offrant
#     vous  soutient ou  soutient  la  façon dont  vous  avez utilisé  son
#     Oeuvre.
#     * Pas d’Utilisation Commerciale  : vous n'êtes pas  autorisé à faire
#     un usage commercial  de cet document, tout ou partie  du matériel le
#     composant.
#     * Partage dans les Mêmes Conditions :  dans le cas où vous effectuez
#     un  remix, que  vous  transformez,  ou créez  à  partir du  matériel
#     composant l'Oeuvre originale, vous  devez diffuser l'Oeuvre modifiée
#     dans les  même conditions, c'est  à dire  avec la même  licence avec
#     laquelle l'Oeuvre originale a été diffusée.
#   Pas  de  restrictions  complémentaires  :  vous  n'êtes  pas  autorisé
#   à  appliquer des  conditions  légales ou  des  mesures techniques  qui
#   restreindraient  légalement  autrui  à   utiliser  l'Oeuvre  dans  les
#   conditions décrites par la licence.
#
#     Notez qu'aucune garantie n'est donnée.  Il se peut que la licence ne
#   vous  donne   pas  toutes  les  permissions   nécessaires  pour  votre
#   utilisation. Par exemple, certains droits  comme les droits moraux, le
#   droit des données personnelles et le droit à l'image sont susceptibles
#   de limiter votre utilisation.
#
#     Le résumé  ci-dessus n'indique  que certaines  des dispositions
#   clé de la licence.  Ce n'est  pas la licence, dont vous auriez dû
#   recevoir une  copie en même  temps que  ce document. Dans  le cas
#   contraire,   l'intégralité  de   la   licence  se   trouve  à   :
#   http://creativecommons.org/licenses/by-nc-sa/4.0
#
# ****************************** COPYRIGHT NOTICE ******************************
#
#     French translation above.
#
#     This document  is LICENSED  under Creative  Commons «  Attribution -
#   NonCommercial - ShareAlike 4.0 International » (CC BY-NC-SA 4.0) whose
#   terms are detailed in the file CC-BY-NC-SA-4.0.txt located in the sub-
#   directory LICENSES, as well as in :
#   http://creativecommons.org/licenses/by-nc-sa/4.0
#
#     Under the  terms and  conditions summarised below,  you are  free to
#   share (copy, redistribute  this document in any medium  or format) and
#   adapt (remix, transform, and build upon this document):
#     * Attribution: you must give appropriate credit (name of the creator
#     and  attribution  parties,  license notice,  disclaimer  notice  and
#     a link to the material), provide a link to the license, and indicate
#     if  changes  were  made  (and   retain  an  indication  of  previous
#     modifications). You may  do so in any reasonable manner,  but not in
#     any way that suggests the licensor endorses you or your use.
#     * NonCommercial:  you  may  not  use  the  material  for  commercial
#     purposes.
#     * ShareAlike: if you  remix, transform, or build  upon the material,
#     you must distribute your contributions under the same license as the
#     original.
#   No  additional  restrictions:  you  may   not  apply  legal  terms  or
#   technological  measures  that  legally   restrict  others  from  doing
#   anything the license permits.
#
#     Note that no warranties are given.  The license may not give you all
#   of  the permissions  necessary for  your intended  use.  For  example,
#   other rights such as publicity, privacy, or moral rights may limit how
#   you use the material.
#
#     The above summary highlights some of the key features and terms
#   of the  actual license.  It is  not the license; you  should have
#   received  a copy  of the  License along  with this  document; you
#   should carefully  review all of  the terms and conditions  of the
#   actual    license   before    using   the    licensed   material:
#   http://creativecommons.org/licenses/by-nc-sa/4.0
#
# ******************************************************************************
