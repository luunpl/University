/**
 * Représente un entrepot dans lequel on peut empiler des caisses. L'entrepot est défini par le
 * nombre de pile de caisses qu'il peut contenir et par la hauteur maximale que ces piles peuvent
 * atteindre.
 * 
 * Dans ces classes chaque pile de caisses est représentée par un tableau de caisses dont la taille
 * (length) correspond au nombre de caisses. La taille maiximum des piles de caisse est fixé à la
 * création de l'entrepot. Lorsque une ou des caisses sont ajoutées à une pile le tableau de caisses
 * matérialisant la pile est remplacé par un nouveau tableau de taille plus grande capabale
 * d'accueillir toutes les caisses (dans la limite de la taille maximale autorisée pour l'entrepot).
 * 
 * Inversement lorsqu'une ciasse est retiiré d'une pile de caisse, le tableau qui la matérialise est
 * ajusté à un tableau de taille correspondant à la nouvelle hauteur de la pile.
 */
public class Entrepot {

    Caisse[][] caisses; // un tableau de tableaux de caisses
                        // caisses[i] correspond à la ième pile de caisses
                        // caisses[i][j] correspond à la caisse située à la position j de la pile i
                        // caisses[i][0] est la caisse qui est en bas de pile
                        // caisses[i][caisses[i].length - 1] est la caisse située en haut de la pile
                        // i
    int hauteurPileMax; // la hauteur maximale des piles de caisse


    /**
     * @param nbPilesnombre de piles de l'entrepot
     * @param hauteurPileMax hauteur maximale des piles
     */
    Entrepot(int nbPiles, int hauteurPileMax) {
        this.hauteurPileMax = hauteurPileMax;
        this.caisses = new Caisse[nbPiles][0]; // au debut les pile de caisses sont vides, elles ont
                                               // une hauteur de 0
    }

    /**
     * Renvoie la position de la caisse dont l'identifiant est donné en paramètre
     * 
     * @param id identifiant de la caisse dont on cherche la position
     * @return la position de la caisse ou null si la caisse n'est pas dans l'entrepôt
     */
    PositionCaisse getPositionCaisse(String id) {
        int indicePile = 0;
        PositionCaisse positionCaisse = null;

        // On recherche la pile qui contient la caisse
        while (indicePile < this.caisses.length && positionCaisse == null) {
            // pile la pile d'indice indicePile
            Caisse[] pile = this.caisses[indicePile];

            // Recherche dans pile si il existe une caisse dont l'identifiant est id
            int indiceCaisse = 0;
            while (indiceCaisse < pile.length && !pile[indiceCaisse].id.equals(id)) {
                indiceCaisse = indiceCaisse + 1;
            }

            // Est ce que j'ai touvé la caisse dans cette pile ?
            if (indiceCaisse != pile.length) {
                // oui, indiceCaisse donne sa position dans pile
                positionCaisse = new PositionCaisse(indicePile, indiceCaisse);
            } else {
                // indiceCaisse == pile.length on n'a pas trouvé la caisse dans pile
                indicePile = indicePile + 1; // On passe à la pile suivante...
            }
        }

        return positionCaisse;
    }

    /**
     * Ajoute une caisse au sommet d'une pile donnée
     * 
     * @param caisse la caisse à ajouter
     * @param indicePile l'indice de la pile dans laquelle ajouter la caisse
     * @return la position de la caisse ajoutée
     * @throws Exception "Indice de pile invalide" si l'indice de pile est invalide
     * @throws Exception "Pile pleine" si la pile est pleine
     * @throws Exception "Caisse déjà présente" si la caisse est déjà dans l'entrepôt
     */
    PositionCaisse ajouterCaisse(Caisse caisse, int indicePile) throws Exception {
        // On traite les cas exceptionnels
        // 1. Cas indice de pile invalide
        if (indicePile >= this.caisses.length || indicePile < 0) {
            throw new Exception("Indice de pile invalide");
        }

        // 2. On vérifie si la caisse existe déjà ailleurs dans l'entrepôt
        if (this.getPositionCaisse(caisse.id) != null) {
            throw new Exception("Caisse déjà présente");
        }

        // 3. La pile est déjà à sa hauteur maximum
        Caisse[] pile = this.caisses[indicePile]; // La pile
        if (pile.length >= hauteurPileMax) { // Ou pile.length == hauteurPileMax
            throw new Exception("Pile pleine");
        }

        // Cas nominal : j'ai une pile dans laquelle je vais pouvoir empiler la caisse

        // on crée une nouvelle pile pouvant contenir une caisse de plus que pile
        Caisse[] nouvellePile = new Caisse[pile.length + 1];

        // On recopie l'ancienne pile dans la nouvelle pile
        for (int i = 0; i < pile.length; i++) {
            nouvellePile[i] = pile[i];
        }
        // On ajoute la caisse au "sommet"
        nouvellePile[pile.length] = caisse;

        // On "remplace" l'ancienne pile par la nouvelle
        this.caisses[indicePile] = nouvellePile;

        return new PositionCaisse(indicePile, nouvellePile.length);
    }

    /**
     * Insère des caisses dans une pile à une position donnée
     * 
     * @param caisses le tableau de caisses à insérer
     * @param indicePile l'indice de la pile dans laquelle insérer les caisses
     * @param positionDansPile la position dans la pile à laquelle insérer les caisses
     * @throws Exception "Indice de pile invalide" si l'indice de pile est invalide
     * @throws Exception "Position dans la pile invalide" si la position dans la pile est invalide
     * @throws Exception "Pas assez de place dans la pile" si la pile n'a pas assez de place pour
     *         accueillir les caisses
     * @throws Exception "Caisse déjà présente" si une des caisses est déjà dans l'entrepôt
     */
    void insererCaisses(Caisse[] caisses, int indicePile, int positionDansPile) throws Exception {
        if (indicePile < 0 || indicePile >= this.caisses.length) {
            throw new Exception("Indice de pile invalide");
        }
        if (positionDansPile < 0 || positionDansPile > this.caisses[indicePile].length) {
            throw new Exception("Position dans la pile invalide");
        }
        if (this.caisses[indicePile].length + caisses.length > this.hauteurPileMax) {
            throw new Exception("Pas assez de place dans la pile");
        }
        for (Caisse caisse : caisses) {
            if (getPositionCaisse(caisse.id) != null) {
                throw new Exception("Caisse déjà présente");
            }
        }

        // Création d'un tableau de Caisses pour représenter la nouvelle pile
        Caisse[] nouvellePile = new Caisse[this.caisses[indicePile].length + caisses.length];

        // Recopie des anciennes caisses dans la nouvelle pile jusqu'à la position d'insertion
        for (int i = 0; i < positionDansPile; i++) {
            nouvellePile[i] = this.caisses[indicePile][i];
        }

        // Ajout des nouvelles caisses
        for (int i = 0; i < caisses.length; i++) {
            nouvellePile[positionDansPile + i] = caisses[i];
        }

        // Recopie des anciennes caisses dans la nouvelle pile après la position d'insertion
        for (int i = positionDansPile; i < this.caisses[indicePile].length; i++) {
            nouvellePile[i + caisses.length] = this.caisses[indicePile][i];
        }

        // Remplacement de l'ancienne pile par la nouvelle
        this.caisses[indicePile] = nouvellePile;
    }

    /**
     * Calcule le poids total des caisses dans l'entrepôt
     * 
     * @return le poids total des caisses
     */
    double poidsTotal() {
        double poids = 0.0;
        for (int iPile = 0; iPile < this.caisses.length; iPile++) {
            for (int iCaisse = 0; iCaisse < this.caisses[iPile].length; iCaisse++) {
                poids += this.caisses[iPile][iCaisse].poids;
            }
        }
        return poids;
    }

    /**
     * Calcule le poids des caisses dans chaque pile
     * 
     * @return un tableau contenant le poids de chaque pile
     */
    double[] poidsDesPiles() {
        double[] poidsPiles = new double[this.caisses.length];
        for (int iPile = 0; iPile < this.caisses.length; iPile++) {
            for (int iCaisse = 0; iCaisse < this.caisses[iPile].length; iCaisse++) {
                poidsPiles[iPile] += this.caisses[iPile][iCaisse].poids;
            }
        }
        return poidsPiles;
    }

    /**
     * Retire la caisse située au sommet d'une pile de caisses
     * 
     * @param indicePile l'indice de la pile concernée
     * 
     * @return la caisse retirée

     * @throws Exception "Indice de pile invalide" si l'indice de pile est invalide
     * @throws Exception "Pile vide" si la pile est vide
     */
    Caisse retirerCaisse(int indicePile) throws Exception {
        // TODO : écrire cette méthode en remplaçant le lancement de l'exception
        // par le code Java correspondant aux spécifications du commentaire documentant
        throw new UnsupportedOperationException("opérationpas encore implémentée");
    }

    /**
     * Retire un ensemble de caisses d'une pile donnée à partir d'une position donnée
     * 
     * @param indicePile l'indice de la pile concernée
     * @param nbCaisse le nombre de caisses à retirer
     * @param position position à partir de laquelles se trouvent les caisses à retirer (en partant du bas)
     * 
     * @return un tableau contenant les caisses retirées
     * 
     * @throws Exception "Indice de pile invalide" si l'indice de pile est invalide
     * @throws Exception "PAs assez de caisses dans la pile" si la pile ne contient pas assez de
     *         caisses à partir de position
     */
    Caisse[] retirerCaisse(int indicePile, int nbCaisse, int position)  throws Exception {
        // TODO : écrire cette méthode en remplaçant le lancement de l'exception
        // par le code Java correspondant aux spécifications du commentaire documentant
        throw new UnsupportedOperationException("opérationpas encore implémentée");
    }

}
