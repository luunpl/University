package bataille;

public class Bataille {

    Joueur joueurGauche;   // le joueur à gauche
    Joueur joueurDroite;   // le joueur à droite

    Carte carteGauche;     // la dernière carte jouée par le joueur Gauche
    Carte carteDroite;     // la dernière carte jouée par le joueur Droit

    /**
     * Crée un jeu de bataille avec deux joueurs
     * @param nomGauche le nom du joeur Gauche
     * @param nomDroite le nom du joeur droit
     */
    Bataille(String nomGauche, String nomDroite) {
        joueurGauche = new Joueur(nomGauche);
        joueurDroite = new Joueur(nomDroite);
    }

    /**
     * distribue une carte tirée au hasard au joueur gauche et au joueur droit.
     */
    void distribue() {
        Carte cartePourJoueurGauche;
        Carte cartePourJoueurDroite;

        do {
            cartePourJoueurGauche = new Carte();
            cartePourJoueurDroite = new Carte();
        } while (cartePourJoueurGauche.egale(cartePourJoueurDroite));
        joueurGauche.prendre(cartePourJoueurGauche);
        joueurDroite.prendre(cartePourJoueurDroite);
    }

    /**
     * fait jouer un tour : chaque joueur pose une carte.
     * @throws JoueurException
     */
    void jouerUnTour() throws JoueurException {
        carteGauche = joueurGauche.jouer();
        carteDroite = joueurDroite.jouer();
    }

    /**
     * @return la référence du joueur gagnant du tour , null si il n'y a pas de gagnant
     */
    Joueur gagnant() {
        Joueur gagnant = null;
        if (carteGauche.valeur.ordinal() > carteDroite.valeur.ordinal()) {
            gagnant = joueurGauche;
        } else if (carteDroite.valeur.ordinal() > carteGauche.valeur.ordinal()) {
            gagnant = joueurDroite;
        }
        return gagnant;
    }

    /**
     * affiche sur la console les cartes jouées par le joueur gauche et le joueur droit
     */
    void afficherTour() {
        System.out.println(joueurGauche.getNom() + " a joué : " + carteGauche);
        System.out.println(joueurDroite.getNom() + " a joué : " + carteDroite);
    }
}
