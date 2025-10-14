package apotp4;

/**
 * Cette classe représente un ligne polygonale (ligne brisée) avec les contraintes suivantes:
 *
 * - la ligne contient au moins deux sommets
 * 
 * - les sommets de la ligne sont désigné par un numéro, un nombre entier dans l'intervalle [1..n]
 * où le numéro 1 désigne le sommet origine de la ligne et le numéro n désigne le sommet extrémité
 * de la ligne. Une ligne de n sommets est constituée de n−1 segments, chaque segment reliant le
 * sommet i au sommet i+1 avec i ∈ [1..n−1]
 * 
 * - dans une ligne polygonale, un sommet ne peut apparaitre qu'une seule fois. En d'autres termes,
 * dans une ligne polygonale il ne peut avoir deux sommets ayant des coordonnées identiques,
 *
 * - si des sommets de coordonnées identiques peuvent appraître dans plusieurs lignes polygonales,
 * il n'est pas contre pas possible qu'il apparaisse plusieurs fois dans la même ligne polygonale.
 *
 */
public class LignePolygonale2 {

    // ------------------------------------------------
    // Constantes
    // ------------------------------------------------
    public static final int INITIAL_CAPACITY = 10;

    // attributs

    private Point[] sommets; // tableau permettant de stoker les sommets de la ligne
    private int nbSommets; // nombre de sommets de la ligne (2 <= nbSommets)

    // --------------------------------------------------------------------------
    // Constructeurs (permettent de créer les objets)
    // --------------------------------------------------------------------------

    /**
     * initialise une ligne polygonale avec un segment de droite spécifié par les coordonnées
     * cartésiennes de ses deux extrémités.
     *
     * @param x1 abscisse du point origine du segment
     * @param y1 ordonnée du point origine du segment
     * @param x2 abscisse du point extrémité du segment
     * @param y2 ordonnée du point extrémité du segment
     *
     * @throws IllegalOperationException si le segment initial est dégénéré (c'est à dire si le
     *         point origine est confondu avec le point extrémité)
     */
    public LignePolygonale2(double x1, double y1, double x2, double y2)
            throws IllegalOperationException {
        if (x1 == x2 && y1 == y2) {
            // les deux points sont confondus
            throw new IllegalOperationException("polygone dégénéré");
        }
        sommets = new Point[INITIAL_CAPACITY];
        sommets[0] = new Point(x1, y1);
        sommets[1] = new Point(x2, y2);
        this.nbSommets = 2;
    }

    /**
     * initialise une ligne polygonale avec un segment de droite spécifié par deux points.
     *
     * @param p1 point origine du segment
     * @param p2 point extrémité du segment
     *
     * @throws IllegalOperationException si le segment initial est dégénéré (c'est à dire si le
     *         point origine est confondu avec le point extrémité)
     */
    public LignePolygonale2(Point p1, Point p2) throws IllegalOperationException {
        // plutôt qu'écrire le code ci dessous
        //
        // if (p1.egale(p2)) { // Attention !! utiliser la méthode egale de Point et non pas ==
        // throw new IllegalOperationException("polygone dégénéré");
        // }
        // sommets = new Point[NB_MAX_SOMETS];
        // sommets[0] = new Point(p1);
        // sommets[1] = new Point(p2);
        // this.nbSommets = 2;
        //
        // qui est très similaire à celui du premier constructeur , il vaut mieux réutliser le code
        // du premier constructeur
        //
        this(p1.getX(), p1.getY(), p2.getX(), p2.getY());
    }


    // --------------------------------------------------------------------------
    // Méthodes
    // --------------------------------------------------------------------------
    /**
     * retourne le sommet origine (le premier sommet) de la ligne polygonale
     *
     * @return un point identique au sommet origine
     */
    public Point getOrigine() {
        return new Point(sommets[0]); // on retourne une copie du sommet origine
        // et non pas le sommet origine. En effet la relation entre la classe LignePolygonale2
        // et la classe Point est une relation de composition (losange noir sur diagrammme de
        // classes UML). Ce qui signifie que les Points de la ligne polygonale ne peuvent être
        // partagés. Seule la ligne polygonale possède des références vers ses sommets
    }

    /**
     * retourne le sommet extrémité (le dernier sommet) de la ligne polygonale
     *
     * @return le sommet extrémité
     */
    public Point getExtremite() {
        return new Point(sommets[nbSommets - 1]); // idem que pour getOrigine
    }

    /**
     * retourne le nombre de points de la ligne polygonale
     *
     * @return nombre de sommets de la ligne polygonale
     */
    public int getNbSommets() {
        return nbSommets;
    }

    /**
     * ajoute un sommet spécifié par ses coordonnées cartésiennes à la ligne polygonale
     *
     * @param x abscisse du sommet ajouté à la ligne polygonale
     * @param y ordonnée du sommet ajouté à la ligne polygonale
     *
     * @return la ligne polygonale
     * 
     * @throws IllegalOperationException("sommet déjà présent") si le sommet à ajouter est confondu
     *         avec l'un des sommets déjà existants dans la ligne polygonale
     */
    public LignePolygonale2 ajouterSommet(double x, double y) throws IllegalOperationException {
        if (this.contient(new Point(x, y))) { // ne pas dupliquer du code, utiliser du code déjà
                                              // existant (ici la
            // méthode contient)
            // vous remarquerez que l'on peut appeler une méthode située après
            // dans le code de la classe
            // l'ordre des déclarations de membres (attributs, constructeurs,
            // méthodes) n'a pas d'importance
            throw new IllegalOperationException("sommet déjà présent");
        }
        if (this.nbSommets == sommets.length) {
            // allouer un nouveau tableau de tailel plus grande
            Point[] nouveauTableau = new Point[sommets.length + INITIAL_CAPACITY];
            // recopier dans ce nouveau tableau les références des sommets contenues dans sommet
            for (int i = 0 ; i < sommets.length; i++) {
                nouveauTableau[i] = sommets[i];
            }
            // rempalcer sommets par ce nouveau tableau
            sommets = nouveauTableau;
        }
        sommets[nbSommets] = new Point(x, y);
        nbSommets++;
        return this;
    }

    /**
     * ajoute à la ligne polygonale un sommet spécifié par ses coordonnées cartésiennes
     *
     * @param pt sommet ajouté à la ligne polygonale, ce sommet est ajouté en fin de ligne et
     *        devient la nouvelle extremité de celle-ci
     *
     * @return la ligne polygonale (afin de pouvoir châiner les opérations d'ajout)
     * 
     * @throws IllegalOperationException("sommet déjà présent") si le sommet à ajouter est confondu
     *         avec l'un des sommets déjà existants dans la ligne polygonale
     * 
     * @throws IllegalOperationException("Nombre de somemts maximum déjà atteint, impossible
     *         d'ajouter un nouveau sommet") si la ligne contient déjà NB_MAX_SOMMETS somemts
     */
    public LignePolygonale2 ajouterSommet(Point pt) throws IllegalOperationException {
        return ajouterSommet(pt.getX(), pt.getY());
    }

    /**
     * renvoie le ième sommet de la ligne polygonale (i dans l'intervale [1..n]
     *
     * @param i le numéro du sommet à récupérer
     * @return le ième sommet de la ligne polygonale
     *
     * @throws IndexOutOfBoundsException si i n'est pas dans l'intervalle [1..n] où n est le nombre
     *         de sommets de la ligne polygonale.
     */
    public Point getSommet(int i) { // pas besoin de mettre de throws, IndexOutOfBoundsException est
                                    // une exception de type RunTimeException qui ne sont pas
                                    // contrôlées (checked
                                    // ou vérifiées). Il n' y pas d'obligation de déclaration, car
                                    // ces exceptions
                                    // relèvent plutôt d'une mauvaise programmation.
        if (i < 1 || i > this.nbSommets) {
            throw new IndexOutOfBoundsException("numéro de sommet incorrect : " + i
                    + " n'est pas dans l'intervale [1 .. " + nbSommets + "]");
        }
        return new Point(sommets[i - 1]);
    }

    /**
     * verifie si la ligne polygonale contient un sommet identique à un point donné.
     *
     * @param pt le point dont on cherche l'appartenance
     * @return true si la ligne possède un sommet egale à pt, false sinon
     */
    public boolean contient(Point pt) {
        int i = 0;
        while (i < nbSommets && !sommets[i].egale(pt)) {
            i++;
        }
        return (i < nbSommets);
    }

    /**
     * permet de supprimer le ième sommet de la ligne, i appartenant à l'intervalle [1..n] où n est
     * le nombre de sommets de la ligne.
     *
     * @param i le numéro du sommet à supprimer
     *
     * @throws IllegalOperationException si la ligne ne contient que deux sommets.
     *
     * @throws IndexOutOfBoundsException si i n'est pas dans l'intervalle [1..n] où n est le nombre
     *         de sommets de la ligne polygonale.
     */
    public void supprimerSommet(int i) throws IllegalOperationException {
        if (this.getNbSommets() == 2) {
            throw new IllegalOperationException("La liste ne contient que 2 sommets");
        }
        if (i < 1 || i > this.nbSommets) {
            throw new IndexOutOfBoundsException("numéro de sommet incorrect : " + i
                    + " n'est pas dans l'intervale [1 .. " + nbSommets + "]");
        }
        // decaler vers la gauche les sommets à partir du sommet supprimé
        for (int j = i - 1; j < nbSommets - 1; j++) { // on par de i - 1 car pour l'utlisateur
            // les sommets sont numérotés de 1 à nbSommets alors que dans
            // le tableau on a des indices de 0 à nbSommets - 1
            sommets[j] = sommets[j + 1];
        }
        nbSommets--;
    }

    /**
     * retourne la longueur de la ligne polygonale (c'est à dire la somme des longueurs de chacun
     * des segments qui la composent).
     *
     * @return la longueur de la ligne polygonale
     */
    public double getLongueur() {
        double longueur = 0.0;
        for (int i = 0; i < nbSommets - 1; i++) {
            longueur += sommets[i].distance(sommets[i + 1]);
        }
        return longueur;
    }

    /**
     * teste l'égalité de la ligne avec une autre ligne. Deux lignes sont considérées égales si
     * elles ont le même nombre de sommets et que tous les sommets de la première sont identiques
     * aux sommets de la seconde et ce dans le même ordre.
     *
     * @param ligne l'objet LignePolygonale2 à comparer avec cette ligne
     * @return true si obj est une ligne égale à this, false sinon
     */
    public boolean egale(LignePolygonale2 ligne) {
        boolean res = false;
        if (this.getNbSommets() == ligne.getNbSommets()) {
            int i = 0;
            while (i < this.getNbSommets() && this.sommets[i].egale(ligne.sommets[i])) {
                i++;
            }
            res = i == nbSommets;
        }
        return res;
    }

    // --------------------------------------------------------------------------
    // redéfinition de méthodes héritées de Object
    // --------------------------------------------------------------------------

    /**
     * Renvoie un représentation textuelle chaîne de caractères) de la ligne polygonale, plus
     * précisément les coordonnées de chacun de ses sommets. Par exemple, pour une ligne de 4
     * sommets (0.0,0.0), (14.0,6.0), (25.0,-2.0) et (5.0,-8.0), la chaîne retournée par cette
     * méthode sera :
     * 
     * "LignePolygonale2[1:(0.0,0.0),2:(14.0,6.0),3:(25.0,-2.0),4:(5.0,-8.0)]"
     *
     * @return une chaîne de caractères repésentant la ligne polygonale.
     */
    @Override
    public String toString() {
        String res = "LignePolygonale2[";
        for (int i = 0; i < nbSommets - 1; i++) {
            res += (i + 1) + ":" + sommets[i] + ",";
        }
        res += nbSommets + ":" + sommets[nbSommets - 1] + "]";
        return res;
    }

}
