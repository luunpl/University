"""
Guillaume et Marion veulent un petit programme pour gérer leurs comptes bancaires. Ils ont chacun un compte, et veulent
recevoir différents messages selon l'état de leur compte et celui de leur conjoint:
les deux positifs, ou bien les deux négatifs, ou bien l'un positif et l'autre négatif avec un transfert possible
pour rétablir la situation, ou bien l'un positif et l'autre négatif sans transfert possible pour rétablir la situation.

Exemples d'execution :

Exemple 1:

Lancement de la gestion des comptes? *l'utilisateur entre non*
OK. A bientot.

Exemple 2:

Lancement de la gestion des comptes? *l'utilisateur entre oui*
Solde du compte de Guillaume? *l'utilisateur entre 150.5*
Solde du compte de Marion? *l'utilisateur entre 340.12*
Tous les deux en positif!

Exemple 3:

Lancement de la gestion des comptes? *l'utilisateur entre oui*
Solde du compte de Guillaume? *l'utilisateur entre -112*
Solde du compte de Marion? *l'utilisateur entre -240.4*
Tous les deux en négatif!
Impossible de rétablir la situation.

Exemple 4:

Lancement de la gestion des comptes? *l'utilisateur entre oui*
Solde du compte de Guillaume? *l'utilisateur entre 350.87*
Solde du compte de Marion? *l'utilisateur entre -240*
Marion est en négatif.
Guillaume peut lui transférer 240.0 euros (il lui restera 110.87 euros).

Exemple 5:

Lancement de la gestion des comptes? *l'utilisateur entre oui*
Solde du compte de Guillaume? *l'utilisateur entre -270*
Solde du compte de Marion? *l'utilisateur entre 250*
Guillaume est en négatif.
Impossible de rétablir la situation.
"""

reponse = input("Lancement de la gestion des comptes?")
if reponse == "non":
    print("OK. A bientot.")
elif reponse == "oui":
    gui = float(input("Solde du compte de Guillaume?"))
    mar = float(input("Solde du compte de Marion?"))
    if gui > 0 and mar > 0:
        print("Tous les deux en positif!")
    elif gui < 0 and mar < 0:
        print("Tous les deux en négatif!")
        print("Impossible de rétablir la situation.")
    elif gui > 0 > mar:
        print("Marion est en négatif.")
        if gui + mar > 0:
            print("Guillaume peut lui transférer", -mar, "euros (il lui restera", gui + mar, "euros).")
        else:
            print("Impossible de rétablir la situation.")
    elif gui < 0 < mar:
        print("Guillaume est en négatif.")
        if gui + mar > 0:
            print("Marion peut lui transférer", -gui, "euros (il lui restera", gui + mar, "euros).")
        else:
            print("Impossible de rétablir la situation.")
