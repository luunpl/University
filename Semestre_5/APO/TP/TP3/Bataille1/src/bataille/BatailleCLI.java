package bataille;

import java.util.Scanner;

/** 
 * Pour tester la classe Bataille depuis la ligne de commande avec une
 * interface textuelle
*/
public class BatailleCLI {
    public static void main(String[] args) throws JoueurException {

		Scanner scanner = new Scanner(System.in);
        Bataille bataille = new Bataille("Anna Tomie", "Guy de Michelin");

		String reponse = "non";
		do {
            bataille.distribue();
			bataille.jouerUnTour();
            Joueur gagnant = bataille.gagnant();
            System.out.println(bataille.joueurGauche.getNom() + " a joué : " + bataille.carteGauche);
            System.out.println(bataille.joueurDroite.getNom() + " a joué : " + bataille.carteDroite);
            if (gagnant == null) {
                System.out.println("les cartes ont la même valeur - Bataille");
            }
            else {
                System.out.println("le gagnant est " + gagnant.getNom());
            }
			System.out.print("Voulez-vous rejouer ? (o/n ou oui/non) ");
			reponse = scanner.next();
		} while (reponse.toLowerCase().startsWith("o"));

        scanner.close();
    }

}