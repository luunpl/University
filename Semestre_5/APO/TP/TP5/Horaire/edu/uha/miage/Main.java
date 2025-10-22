/*
 * @author : Yvan Maillot (yvan.maillot@uha.fr)
 */
package edu.uha.miage;

/**
 * @author yvan
 */
public class Main {

    public static void main(String[] args) {
        // Ecrire ici vos tests personnels
        System.out.println("Ecrire vos tests personnels dans edu.uha.miage.Main");
        Horaire h112358 = new Horaire(false, 11, 23, 58);
        System.out.println("11:23:58 = " + h112358.toString());
        Horaire h112300 = new Horaire(false, 11, 23);
        System.out.println("11:23:00 = " + h112300.toString());
        Horaire h110000 = new Horaire(false, 11);
        System.out.println("11:00:00 = " + h110000.toString());
        Horaire h000000 = new Horaire();
        System.out.println("00:00:00 = " + h000000.toString());
    }
}
