package nombre;

public class Test {

    public static void main(String[] args) {
        int a = 5;
        int b = 10;
        int c = 15;
        TroisNombres nbs = new TroisNombres(a, b, c);
        System.out.println("Somme   de " + a + " + " + b + " + " + c + " : " + nbs.somme());
        System.out.println("Moyenne de " + a + ", " + b + ", " + c + " : " + nbs.moyenne());
        System.out.println("" + a + ", " + b + "  et " + c + " sont ils dans l'ordre ? : " + nbs.enOrdre());
    }
}
