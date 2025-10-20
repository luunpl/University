package bataille;

import java.text.Normalizer;
import java.util.regex.Pattern;

/**
 * Représente une carte à jouer d'un jeu de 32 cartes
 */
public class Carte {

    // ------ attributs ----------------------------

    Couleur couleur; // la couleur de la carte
    Valeur valeur; // la valeur de la carte

    // ------ Constructeurs ----------------------------

    /**
     * 
     * @param valeur
     * @param couleur
     */
    Carte(Valeur valeur, Couleur couleur) {
        this.valeur = valeur;
        this.couleur = couleur;
    }

    /**
     * Créée une carte en choisissant une couleur au hasard parmi les couleurs possibles et une
     * valeur au hasard parmi les valeurs possibles.
     */
    Carte() {
        // On récupère les valeurs possibles de Couleur
        Couleur[] couleurs = Couleur.values();
        // On choisi un indice au hasard entre 0 et couleurs.length
        int indexCouleur = (int) (Math.random() * couleurs.length);
        this.couleur = couleurs[indexCouleur];
        // On récupère les valeurs possibles de Valeur
        Valeur[] valeurs = Valeur.values();
        // On choisi un indice au hasard entre 0 et valeurs.length
        int indexVal = (int) (Math.random() * valeurs.length);
        this.valeur = valeurs[indexVal];
    }


    // ------ Méthodes-------- ----------------------------

    /**
     * renvoie le nom de la carte sous la forme du nom de sa valeur suivi du nom de sa couleur. Par
     * exemple "As de trèfle" ou "Roi de coeur".
     * 
     * @return le nom de la carte
     */
    String getNom() {
        String s = "";
        s += valeur.getNom() + " de " + couleur.getNom();
        return s;
    }

    public String toString() {
        return getNom();
    }

    /**
     * vérifie si la carte passée en paramètre est la même que la carte courante (this, celle à qui
     * s'adresse le message egale), c'est dire si si leur valeur et leur couleur sont exactement les
     * mêmes.
     * 
     * @param c la carte à comparer avec la carte this
     * 
     * @return true si les deux cartes on la même valeur et la même couleur, false sinon
     */
    public boolean egale(Carte c) {
        return (c.couleur == this.couleur) && (c.valeur == this.valeur);
    }


    /**
     * renvoie le nom du fichier image png correspondant au nom de la carte.
     * 
     * @return nom du fichier png
     */
    public String getNomFichierImage() {
        String s = "";
        s += valeur.getNom() + "-de-" + sansAccent(couleur.getNom()) + ".png";
        return s;
    }

    /**
     * Ne PAS modifier cette méthode. Vous pouvez l'utiliser dans l'exercice 8
     * 
     * Supprime tous les accents et caractères diacritiques (les accents, cédilles, trémas, etc.)
     * d'une chaîne de caractères.
     * 
     * @param s la châine à traiter
     * 
     * @return une chaîne sans accents ni caractères diacritiques. Par exemple :
     * 
     *         - sansAccent("trèfle") renverra "trefle"
     * 
     *         - sans accent("valet-de-cœur") renverra "valet-de-coeur"
     */
    String sansAccent(String s) {
        // décompose les caractères accentués en leur caractère de base +
        // leur marque diacritique séparée (forme NFD = Normalization Form Decomposed).
        // Par exemple : "è" devient "e" + "◌̀" (caractère de base + accent grave séparé)
        String strTemp = Normalizer.normalize(s, Normalizer.Form.NFD);
        // utilise une expression régulière (pattern) pour identifier et supprimer tous les
        // caractères de la catégorie Unicode "Combining Diacritical Marks" (les accents,
        // cédilles, trémas, etc.).
        Pattern pattern = Pattern.compile("\\p{InCombiningDiacriticalMarks}+");
        return pattern.matcher(strTemp).replaceAll("");
    }
}
