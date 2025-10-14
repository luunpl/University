import java.util.Scanner;

public class TestEntrepot {
    static Scanner sc = new Scanner(System.in);

    static int choisirOperation() {
        // """ ... """ permet de faire des String sur plusieurs lignes (Text Blocks) sans utiliser
        // de \n, disponilbe depuis Java 15
        System.out.print("""

                Choisissez une commande :
                1: Ajouter une caisse au sommet d'une pile
                2: Insérer plusieurs caisses dans une pile
                3: Rechercher la position d'une caisse
                4: Calculer le poids total des caisses dans l'entrepot
                5: Calculer le poids total des caisses dans chaque pile
                0: Terminer

                votre choix :\s""");
        return Integer.parseInt(sc.nextLine());
    }

    static void ajouterUneCaisse(Entrepot e) throws Exception {
        System.out.print("identifiant de la caisse : ");
        String id = sc.nextLine();
        System.out.print("poids de la caisse : ");
        double poids = Double.parseDouble(sc.nextLine());
        System.out.print("Numéro de la pile à laquelle voulez ajouter cette caisse : ");
        int indicePile = Integer.parseInt(sc.nextLine());
        e.ajouterCaisse(new Caisse(id, poids), indicePile);
    }

    static void insererDesCaisses(Entrepot e) throws Exception {
        System.out.println("Numéro de la pile à laquelle voulez insérer des caisses : ");
        int indicePile = Integer.parseInt(sc.nextLine());
        System.out.println("Posistion d'insertion dans la pile : ");
        int position = Integer.parseInt(sc.nextLine());
        System.out.print("nombre de caisses à insérer : ");
        int nbCaisses = Integer.parseInt(sc.nextLine());
        Caisse[] lesCaisses = new Caisse[nbCaisses];
        for (int i = 0; i < nbCaisses; i++) {
            System.out.print("identifiant de la caisse : ");
            String id = sc.nextLine();
            System.out.print("poids de la caisse : ");
            double poids = Double.parseDouble(sc.nextLine());
            lesCaisses[i] = new Caisse(id, poids);
        }
        e.insererCaisses(lesCaisses, indicePile, position);

    }

    static void rechercherPosition(Entrepot e) {
        System.out.print("identifiant de la caisse : ");
        String id = sc.nextLine();
        PositionCaisse pos = e.getPositionCaisse(id);
        if (pos != null) {
            System.out.println("La caisse " + id + " est à la position " + pos.indiceCaisse
                    + " da la pile " + pos.indicePile);
        } else {
            System.out.println("La caisse n'est pas dans la pile");
        }
        System.out.println();
    }

    public static void main(String[] args) {
        // un entrepot de 5 piles d'hauteur maximale 4
        Entrepot e = new Entrepot(5, 4);
        int choix = 0;

        do {
            try {
                choix = choisirOperation();
                switch (choix) {
                    case 0:
                        System.out.println("Au revoir !");
                        break;
                    case 1:
                        ajouterUneCaisse(e);
                        break;
                    case 2:
                        insererDesCaisses(e);
                        break;
                    case 3:
                        rechercherPosition(e);
                        break;
                    case 4:
                        System.out.println("le poids total des caisse présentes dans l'entrepot : " + 
                                     e.poidsTotal() + " kg");
                        break;
                    case 5:
                        double[] lesPoids = e.poidsDesPiles();
                        for (int i = 0; i < lesPoids.length; i++) {
                            System.out.println("Poids de la pile " + i + " : " + lesPoids[i] + " kg");
                        }
                        break;
                    default:
                        System.out.println("le choix " + choix + " n'est pas implémenté");
                }
            } catch (Exception ex) {
                System.err.println("Une erreur est survenue : " + ex.getMessage());
            }
        } while (choix != 0);
    }
}
