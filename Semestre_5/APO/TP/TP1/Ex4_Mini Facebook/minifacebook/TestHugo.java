package minifacebook;

public class TestHugo {

    public static void main(String[] args) {
        Personne hugo = new Personne("Histe", "Hugo", new DateNaissance());
        hugo.setMeilleurAmi(hugo);
        hugo.ecritInfos();
    }
}
