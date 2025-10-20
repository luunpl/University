package bataille;

/**
 * Représente un joueur de carte. Dans cette version simplifiée un joueur n'a qu'une seule carte.
 */
public class Joueur {

    String nom; // le nom du joueur
    Carte carte; // la carte que le joeur a en main

    /**
     * constructeur pour créer un joueur
     * 
     * @param nom le nom du joueur
     */
    Joueur(String nom) {
        this.nom = nom;
    }

    /**
     * Change la carte que le joueur a en main
     * @param carte la carte que le joeur prend
     */
    void prendre(Carte carte) {
        this.carte = carte;
    }

    /**
     * Fait jouer une carte au joueur
     * @return la carte que le joueur a en main
     * @throws JoueurException si le joeur n'a plus de carte
     */
    Carte jouer() throws JoueurException {
        if (carte == null) {
            throw new JoueurException("opération invalide, le joueur n'a plus de carte");
        }
        Carte c = carte;
        this.carte = null;   // le joeur n'a plus de carte en main
        return c;
    }

    /**
     * @return le nom du joueur
     */
    String getNom() {
        return nom;
    }
}
