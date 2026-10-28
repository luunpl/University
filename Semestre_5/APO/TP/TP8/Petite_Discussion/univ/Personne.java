/*
 * @author : Yvan Maillot (yvan.maillot@uha.fr)
 */
package univ;

public class Personne {
    // TODO 1.01. Déclarer nom, prenom et homme (lettre pour lettre)
    // 
    private String nom;
    private String prenom;
    private boolean homme;   
    
    /**
     * TODO 1.02
     * Créer une personne en définissant son nom, son prenom et s'il est
     * un homme ou une femme
     * @param nom une String
     * @param prenom une String
     * @param homme un boolean vrai masculin, faux féminin
     */
    // TODO 1.02. Le constructeur
    public Personne(String nom, String prenom, boolean homme){
        this.nom = nom;
        this.prenom = prenom;
        this.homme = homme;
    }
    // 

    // TODO 1.03. Ne pas oublier les getters des attributs
    public String getPrenom(){
        return prenom;
    }
    
    public String getNom(){
        return nom;
    }
    
    public boolean isHomme(){
        return homme;
    }
    // 

    /**
     * TODO 1.04
     * Retourne une chaîne de caractères qui constitue la présentation soutenue
     * ou familière de cette personne.
     *
     * La présentation familière est tout simplement le prénom suivi du nom
     * Par exemple, "Lucky Luke"
     *
     * La présentation soutenue est M. ou Mme (en fonction de isHomme()) suivi
     * du nom et du prénom
     * Par exemple, M. Luke Lucky
     *
     * ATTENTION : utilisez NÉCESSAIREMENT les getters et NON les attributs.
     *
     * @param soutenue pour déterminer le type de présentation
     *
     * @return la chaîne de présentation
     */
    protected String presentation(boolean soutenue) {
    // TODO 1.04. La présentation soutenue ou familière (lire la javadoc)
        if (!soutenue){
            return getPrenom() + " " + getNom();
        } else {
            if (isHomme()) {
                return "M. " + getNom() + " " + getPrenom();
            } else {
                return "Mme " + getNom() + " " + getPrenom();
            }
        }
    }

    /**
     * TODO 1.05
     * @return la présentation soutenue
     */
    protected String presentation() {
        return presentation(true);
    // TODO 1.05. Par défaut, la présentation est soutenue
    }

    /**
     * TODO 1.06 String bonjour()
     * @return "Bonjour, je suis " suivi de la présentation soutenue de cette personne
     */
    protected String bonjour() {
        return "Bonjour, je suis " + presentation(true);
    // TODO 1.06. Lire la javadoc
    }

    /**
     * TODO 1.07 String reponseAuBonjourDe(Personne personne)
     * @param personne la personne à qui répond cette personne.
     * @return "Bonjour "
     *         suivi de la présentation soutenue de personne (du paramètre personne)
     *         suivi d'un saut de ligne
     *         suivi de "Moi c'est "
     *         suivi de la présentation soutenue de cette personne.
     *
     *         Exemple : "Bonjour M.Luke Lucky.
     *                    Moi c'est Mme Dalton Ma"
     */
    protected String reponseAuBonjourDe(Personne personne) {
        return "Bonjour " + personne.presentation(true) + ".\n" + "Moi c'est " + this.presentation(true);
    // TODO 1.07. Lire la javadoc
    }

    /**
     * TODO 1.08 String caVa(Personne personne)
     * @param personne la personne à s'adresser (ignorée ici).
     * @return "Comment allez-vous ?"
     */
    protected String caVa(Personne personne) {
        return "Comment allez-vous ?";
    // TODO 1.08. Comment allez-vous
    }

    /**
     * TODO 1.09 String etVous(Personne personne)
     * @param personne la personne à qui s'adresser (ignorée ici).
     * @return "Ca va bien. Merci."
     */
    protected String etVous(Personne personne) {
        return "Ca va bien. Merci.";
    // TODO 1.09. Ca va bien. Merci.
    }

    /**
     * Affiche sur la sortie standard "<< **B** >> dit **P**. \n" où
     *        1. **B** est le résultat de l'invocation de bonjour()
     *        2. **P** est le résultat de l'invocation de presentation(false)
     * Puis invoque personne.repondAuBonjourDe(this) pour continuer le dialogue
     *
     * @param personne est la personne à qui s'adresse le bonjour.
     *
     * NE PAS MODIFIER CETTE MÉTHODE
     */
    public final void ditBonjourA(Personne personne) {
        System.out.printf("<< %s >> dit %s. \n", bonjour(), presentation(false));
        personne.repondAuBonjourDe(this);
    }

    /**
     * Affiche sur la sortie standard "<< **R** >> répond **P**. \n" où
     *        1. **R** est le résultat de l'invocation de reponseAuBonjourDe(personne)
     *        2. **P** est le résultat de l'invocation de presentation(true)
     * Puis invoque demandeSiCaVaA(personne);
     *
     * @param personne est la personne à qui répondre
     *
     * NE PAS MODIFIER CETTE MÉTHODE
     */
    private void repondAuBonjourDe(Personne personne) {
        System.out.printf("<< %s >> répond %s.\n", reponseAuBonjourDe(personne), presentation(false));
        demandeSiCaVaA(personne);
    }

    /**
     * Affiche sur la sortie standard "<< **C** >> répond **P**. \n" où
     *        1. **C** est le résultat de l'invocation de caVa(personne)
     *        2. **P** est le résultat de l'invocation de presentation(true)
     * Puis invoque personne.demandeEtVousA(this);
     *
     * @param personne est la personne à qui demander si ça va.
     *
     * NE PAS MODIFIER CETTE MÉTHODE
     */
    private void demandeSiCaVaA(Personne personne) {
        System.out.printf("<< %s >> continue %s.\n", caVa(personne), presentation(false));
        personne.demandeEtVousA(this);
    }

    /**
     * Affiche sur la sortie standard "<< %s >> termine %s.\n" où
     *        1. **V** est le résultat de l'invocation de etVous(personne)
     *        2. **P** est le résultat de l'invocation de presentation(true)
     * Et le dialogue se termine.
     *
     * @param personne est la personne à qui on s'adresse.
     *
     * NE PAS MODIFIER CETTE MÉTHODE
     */
    private void demandeEtVousA(Personne personne) {
        System.out.printf("<< %s >> termine %s.\n", etVous(personne), presentation(false));
    }

}
