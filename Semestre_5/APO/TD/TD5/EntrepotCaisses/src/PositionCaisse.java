/**
 * défini la position d'une caisse dans l'entrepot
 * à savoir le numéro de la pile où elle se trouve ainsi
 * que sa position dans la pile.
 */
public class PositionCaisse {
    final int indicePile;
    final int indiceCaisse;

    public PositionCaisse(int indicePile, int indiceCaisse) {
        this.indicePile = indicePile;
        this.indiceCaisse = indiceCaisse;
    }

    public String toString() {
        return "[pile : " + indicePile + ", position : " + indiceCaisse + "]";
    }
}

