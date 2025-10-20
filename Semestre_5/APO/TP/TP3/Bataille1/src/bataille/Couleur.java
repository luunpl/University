package bataille;

/**
 * Les couleurs possibles pour les cartes d'un jeu de 32 cartes
 */
public enum Couleur {

    PIQUE("pique"), COEUR("coeur"), CARREAU("carreau"), TREFLE("trèfle");

    String nom;

    Couleur(String nom) {
        this.nom = nom;
    }

    public String getNom() {
        return nom;
    }
}
