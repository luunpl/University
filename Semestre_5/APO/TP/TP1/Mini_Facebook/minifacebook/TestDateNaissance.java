package minifacebook;

public class TestDateNaissance {

    public static void main(String[] args) {
        DateNaissance naissancePatty = new DateNaissance(10, 05, 1968);
        DateNaissance naissanceJack = new DateNaissance();
        naissancePatty.ecritDate();
        System.out.println();
        naissanceJack.ecritDate();
        System.out.println();
        System.out.println("l'âge de Jack est: " + naissanceJack.age());
    }
}
