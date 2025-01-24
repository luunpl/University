"""
Le but de cet exercice est de programmer un automate destiné à vendre des cartes de réduction et billets de train pour la SCNF.

Pour simplifier, on ne considérera que deux types de carte de réduction:

la carte Jeune, prix 50€
la carte Senior, prix 60€.
De même on ne considérera que les trajets suivants :

Grenoble - Paris, prix 100€
Grenoble - Lyon, prix 20€
Lyon - Paris, prix 80€
Les prix correspondent à un aller simple plein tarif, et on suppose que le prix du retour est identique à celui de l'aller (par exemple, un Lyon - Grenoble vaut aussi 20€).

Les cartes de réduction offrent les avantages suivants :

En période bleue (période creuse): 50% de réduction
En période blanche (période de pointe): 30% de réduction avec une carte Jeune, et 25% de réduction avec une carte Senior.
De plus, un passager sans carte de réduction peut tout de même obtenir une réduction de 10% s'il choisit un billet non modifiable.

1) Ecrire une fonction tarif_carte qui prend en argument une chaîne de caractère correspondant au nom de la carte ("Jeune" ou "Senior") et qui renvoie le prix de la carte. Si un autre nom que "Jeune" ou "Senior" est utilisé, la fonction affichera "Carte inconnue" et ne renverra rien (ou renverra None, ce qui revient au même).

2) Ecrire une fonction plein_tarif qui prend en argument deux chaînes de caractères correspondant respectivement à la ville de départ de la ville d'arrivée et qui renvoie le prix d'un billet plein tarif sur ce trajet-là. Si le trajet demandé n'est aucun des 6 trajets existants dans cet exercice, la fonction affichera "Trajet inconnu" et renverra None (ou rien).

3) Ecrire une fonction tarif_billet qui prend en argument la ville de départ, la ville d'arrivée et 3 arguments optionnels : un booléen modifiable indiquant si le billet est modifiable (True par défaut), un argument carte correspondant au nom de l'éventuelle carte de réduction (None par défaut; pourra valoir "Jeune" ou "Senior" dans les appels), et enfin un argument periode  (None par défaut; pourra valoir "bleue" ou "blanche" dans les appels). La fonction doit renvoyer le tarif du billet correspondant. Si le trajet ou la carte demandé(e) est inconnu(e), un message d'erreur s'affichera et la fonction renverra None.

4) *Ecrire une fonction prix_client qui ne prend aucun argument et qui renverra le prix total de la commande du client. Pour cela, votre fonction commencera par demander "Voulez-vous acheter une carte de réduction ? (oui/non) ". Si client tape non, on passe directement à l'achat du billet (décrit plus loin); si le client tape oui, on lui demande "Choisissez votre carte : (Jeune/Senior) " et enregistre le prix correspondant. Ensuite, on lui demande "Voulez-vous acheter un billet ? (oui/non) ". Si l'utilisateur tape oui, on lui demande "Depart : " puis "Destination : ". Si l'utilisateur vient d'acheter une carte de réduction, il doit voir s'afficher "Vous avez une carte de réduction" puis "Precisez la periode (bleue/blanche) : ". La fonction peut alors calculer le prix. Si l'utilisateur ne vient pas d'acheter une carte de réduction, on doit lui demander "Autres precisions a fournir ? (oui/non) ". Si l'utilisateur tape non, le prix calculé doit être celui d'un plein tarif modifiable. Sinon, on doit lui demander "Carte de reduction (Jeune, Senior, ou aucune)? ". Si l'utilisateur indique une carte, il faut lui demander "Precisez la periode (bleue/blanche): ", sinon il faut lui demander "Billet modifiable ? (oui/non) ". Avec toutes ces informations, la fonction calcule le bon prix. Dans tous les cas (si l'utilisateur n'achète qu'une carte, ou qu'un billet, ou aucun des deux), votre fonction doit terminer en affichant "Prix total :" suivi du prix total et doit renvoyer le prix total.

Note: Vous êtes libres de rajouter des fonctions intermédiaires si vous jugez cela pertinent.

Exemple 1 pour un appel de prix_client() qui renvoie 50:
Voulez-vous acheter une carte de réduction ? (oui/non) oui
Choisissez votre carte : (Jeune/Senior) Jeune
Voulez-vous acheter un billet ? (oui/non) non
Prix total : 50 euros

Exemple 2 pour un appel de prix_client() qui renvoie 75.0:
Voulez-vous acheter une carte de réduction ? (oui/non) oui
Choisissez votre carte : (Jeune/Senior) Senior
Voulez-vous acheter un billet ? (oui/non) oui
Depart : Lyon
Destination : Grenoble
Vous avez une carte de reduction
Precisez la periode (bleue/blanche) : blanche
Prix total : 75.0 euros

Exemple 3 pour un appel de prix_client() qui renvoie 80:
Voulez-vous acheter une carte de réduction ? (oui/non) non
Voulez-vous acheter un billet ? (oui/non) oui
Depart : Paris
Destination : Lyon
Autres precisions a fournir ? (oui/non) non
Prix total : 80 euros

Exemple 4 pour un appel de prix_client() qui renvoie 90.0:
Voulez-vous acheter une carte de réduction ? (oui/non) non
Voulez-vous acheter un billet ? (oui/non) oui
Depart : Paris
Destination : Grenoble
Autres precisions a fournir ? (oui/non) oui
Carte de reduction (Jeune, Senior, ou aucune)? aucune
Billet modifiable ? (oui/non) non
Prix total : 90.0 euros

Exemple 5 pour un appel de prix_client() qui renvoie 10.0:
Voulez-vous acheter une carte de réduction ? (oui/non) non
Voulez-vous acheter un billet ? (oui/non) oui
Depart : Grenoble
Destination : Lyon
Autres precisions a fournir ? (oui/non) oui
Carte de reduction (Jeune, Senior, ou aucune)? Senior
Precisez la periode (bleue/blanche): bleue
Prix total : 10.0 euros
"""


def tarif_carte(carte):
    if carte == "Jeune":
        return 50
    elif carte == "Senior":
        return 60
    else:
        print("Carte inconnue")


def plein_tarif(depart, arrive):
    if (depart == "Grenoble" and arrive == "Paris") or (
        depart == "Paris" and arrive == "Grenoble"
    ):
        return 100
    elif (depart == "Grenoble" and arrive == "Lyon") or (
        depart == "Lyon" and arrive == "Grenoble"
    ):
        return 20
    elif (depart == "Lyon" and arrive == "Paris") or (
        depart == "Paris" and arrive == "Lyon"
    ):
        return 80
    else:
        print("Trajet inconnu")


def tarif_billet(depart, arrive, modifiable=True, carte=None, periode=None):
    # Trajet
    tarif = plein_tarif(depart, arrive)
    # Periode
    if periode == "bleue":
        tarif = tarif / 2
    elif periode == "blanche":
        if carte == "Jeune":
            tarif = (tarif * 70) / 100
        elif carte == "Senior":
            tarif = tarif * 75 / 100
    # Modifiable
    if carte is None and not modifiable:
        tarif = tarif * 0.9

    return tarif


def prix_client():
    global carte_reduction
    prix_total = 0
    reponse1 = input("Voulez-vous acheter une carte de réduction ? (oui/non)")
    # Reduction
    if reponse1 == "oui":
        carte_reduction = input("Choisissez votre carte : (Jeune/Senior)")
        prix_total += tarif_carte(carte_reduction)
    # billet
    reponse2 = input("Voulez-vous acheter un billet ? (oui/non) ")
    if reponse2 == "oui":
        depart = input("Depart :")
        arrive = input("Destination : ")
        # Si avoir la carte de reduction
        if reponse1 == "oui":
            print("Vous avez une carte de réduction")
            periode_preciser = input("Precisez la periode (bleue/blanche) : ")
            prix_total += tarif_billet(
                depart, arrive, carte=carte_reduction, periode=periode_preciser
            )
        # Si l'utilisateur ne possede pas carte de reduction
        elif reponse1 == "non":
            precision = input("Autres precisions a fournir ? (oui/non) ")
            # Avec precision
            if precision == "oui":
                carte_reduction2 = input(
                    "Carte de reduction (Jeune, Senior, ou aucune)?"
                )
                if carte_reduction2 == "Jeune" or carte_reduction2 == "Senior":
                    periode_preciser2 = input("Precisez la periode (bleue/blanche) : ")
                    prix_total += tarif_billet(
                        depart,
                        arrive,
                        carte=carte_reduction2,
                        periode=periode_preciser2,
                    )
                else:
                    modifiable = input("Billet modifiable ? (oui/non) ")
                    if modifiable == "non":
                        prix_total += tarif_billet(depart, arrive, modifiable=False)
                    else:
                        prix_total += tarif_billet(depart, arrive)
            # Sans precision
            elif precision == "non":
                prix_total += tarif_billet(depart, arrive)

    # Return value
    if reponse1 == "oui" or reponse2 == "oui":
        return prix_total
    elif reponse1 != "oui" and reponse2 != "oui":
        return 0
