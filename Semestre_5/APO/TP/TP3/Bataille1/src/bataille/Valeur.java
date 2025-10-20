package bataille;

/**
 * Les valeurs possibles pour les cartes d'un jeu de 32 cartes
 */
public enum Valeur {

    SEPT("sept"),
    HUIT("huit"),
    NEUF("neuf"),
    DIX("dix"),
    VALET("valet"),
    DAME("dame"),
    ROI("roi"),
    AS("as");

    String nom;

    Valeur(String nom) {
        this.nom = nom;
    }

    public String getNom() {
        return nom;
    }
}
