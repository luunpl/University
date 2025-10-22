package complexe;

public class TestComplexe {

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
    public static void main(String[] args) {
    // TODO Implémenter ici le contenu de la méthode main de la classe TestComplexe.
        Complexe c1 = new Complexe();
        Complexe c2 = new Complexe(3.5, 4.4);
        
        // Modification des attributs de c1
        c1.partieReelle = 1.5;
        c1.partieImaginaire = 4.0;

        // Appel unique à une méthode (comme dans les slides)
        c2.ajouter(c1);
    }
}
