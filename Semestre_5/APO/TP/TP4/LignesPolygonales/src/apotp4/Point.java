package apotp4;

/**
 * Modélise la notion de point du plan avec une représentation cartésienne des
 * coordonnées.
 *
 * @author Philippe Genoud - UGA Université Grenoble Alpes - Lab LIG STeamer
 */
public class Point {
    //-----------------------------------------------------------------
    // variables d'instance (la représentation physique des coordonnées
    //-----------------------------------------------------------------

    /**
     * abscisse du point
     */
    private double x;

    /**
     * ordonnée du point
     */
    private double y;

    //---------------------------------------
    // constructeurs
    //---------------------------------------
    /**
     * Construction d'un point en donnant explicitement sa position.
     *
     * @param x la première coordonnée (abscisse)
     * @param y la seconde coordonnée (ordonnée)
     */
    public Point(double x, double y) {
        this.x = x;
        this.y = y;
    }

    /**
     * Construction d'un point à l'origine.
     */
    public Point() {
        this(0.0, 0.0);
    }

    /**
     * Construction d'un point par clonage.
     *
     * @param p le point à cloner
     *
     */
    public Point(Point p) {
        this(p.getX(), p.getY());
    }

    //---------------------------------------
    // méthodes
    //---------------------------------------
    //-- accesseurs et modifieurs des attributs
    /**
     * Restitue l'abscisse du point.
     *
     * @return l'abscisse du point
     */
    public double getX() {
        return x;
    }

    /**
     * Restitue l'ordonnée du point.
     *
     * @return l'ordonnée du point
     */
    public double getY() {
        return y;
    }


    //--- autres méthodes -------------------------------------------
    /**
     * Positionne le point à la coordonnée cartésienne (x,y).
     *
     * @param x l'abscisse
     * @param y l'ordonnée
     */
    public void placerA(double x, double y) {
        this.x = x;
        this.y = y;
    }

    /**
     * Translate le point.
     *
     * @param dx la composante en x du vecteur de translation.
     * @param dy la translation en y du vecteur de translation.
     */
    public void translater(double dx, double dy) {
        placerA(x + dx, y + dy);
    }

    /**
     * calcule la distance de ce point à l'origine.
     *
     * @return distance à l'origine.
     */
    public double distance() {
        return Math.sqrt(x * x + y * y);
    }
    
    /**
     * Calcule la distance entre ce point et un autre point
     * @param pt le point par rapport auquel on calcule la distance
     * @return la distance entre ce point et le point pt
     */
    public double distance(Point pt) {
        return Math.sqrt((this.x - pt.x) * (this.x -pt.x) + 
                (this.y - pt.y)* (this.y - pt.y));
    }
    
    /**
     * restitue une représentation textuelle du point.
     *
     * @return la chaine représentant le point. Un point d'abscisse 10 et d'ordonnée 14
     *         sera représenté par la chaine <code>"(10.0,14.0)"</code>
     */
    @Override
    public String toString() {
        return "(" + x + "," + y + ")";
    }

    /**
     * Teste l'égalité du point (this) avec un autre point
     * @param p le point à comparer à this.
     * @return  true si this et p ont les mêmes coordonnées, false sinon
     */
    public boolean egale(Point p) {
        return this.x == p.x && this.y == p.y;
    }
}
