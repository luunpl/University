package nombre;

public class TroisNombres {

    /**
     * Trois nombres: a, b et c déclarés ici
     * Ces 3 variables peuvent être utilisées dans
     * toutes les fonctions ci-dessous.
     */
    int a;

    int b;

    int c;

    /**
     *  Constructeur.
     *  NE PAS MODIFIER CETTE FONCTION
     */
    public TroisNombres(int a, int b, int c) {
        this.a = a;
        this.b = b;
        this.c = c;
    }

    public int somme() {
    // TODO Calclule la somme des 3 entiers a, b et c
        return a + b + c;
    }

    public double moyenne() {
    // TODO Calcule la moyenne des 3 entiers a, b et c
        return somme() / 3.0;
    }

    public boolean enOrdre() {
    // TODO Renvoie vrai si a <= b <= c et faux sinon
        return a <= b && b <= c;
    }
}
