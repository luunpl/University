package complexe;

public class Complexe {
    /**
     * L'objectif de ce lab est de compléter les 2 fichiers Complexe.java et TestComplexe.java.
     * Pour cela, téléchargez le document http://l3miagelw.free.fr/apogrenoble/ressources/diagAPO2JavaComplexe.pdf
     * Faite défiler ce document page par page (ne pas faire glisser les pages, mais les supperposer les unes aux autres).
     * Il se dessine alors les étapes d'un diagramme APO (cf poly de cours chapitres I et II).
     * A partir de ce diagramme APO, complétez les fichiers Complexe.java et la méthode main qui est dans le fichier TestComplexe.java.
     *
     * Si, malgré la lecture attentive du chapitre II du poly, vous ne parvenez pas à compléter ces 2 fichiers, vous pouvez vous appuyer
     * sur une explication plus détaillée à télécharger dans le fichier suivant:
     * http://l3miagelw.free.fr/apogrenoble/ressources/diagAPO2JavaComplexe-correction.pdf
     */
    // Attributs
    double partieReelle;
    double partieImaginaire;

    // Constructeur par défaut
    public Complexe() {
        this.partieReelle = 0.0;
        this.partieImaginaire = 0.0;
    }

    // Constructeur avec paramètres
    public Complexe(double partieReelle, double partieImaginaire) {
        this.partieReelle = partieReelle;
        this.partieImaginaire = partieImaginaire;
    }

    // Méthode d’addition de complexes
    public void ajouter(Complexe c) {
        this.partieReelle = this.partieReelle + c.partieReelle;
        this.partieImaginaire = this.partieImaginaire + c.partieImaginaire;
    }

    // Méthode d’affichage 
    public void afficher() {
        System.out.println("(" + this.partieReelle + " , " + this.partieImaginaire + ")");
    }
}
