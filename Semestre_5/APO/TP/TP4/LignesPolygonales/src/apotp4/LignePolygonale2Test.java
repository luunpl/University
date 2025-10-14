package apotp4;

import java.util.Scanner;

public class LignePolygonale2Test {

    static Scanner sc = new Scanner(System.in);

    public static void main(String[] args) throws IllegalOperationException {

        LignePolygonale2 ligne1 = new LignePolygonale2(0.0, 0.0, 10.0, 0.0);
        System.out.println("Ligne 1 : " + ligne1); // affiche la ligne polygonale, 
        // pour cela écrivez la méthode toString,  en effet System.out.println(ligne1); 
        // est équivalent à System.out.println(ligne1.toString());

        LignePolygonale2 ligne2 = new LignePolygonale2(0.0, 0.0, 10.0, 0.0);
        System.out.println("Ligne 2 : " + ligne2); 

        LignePolygonale2 laLigne = ligne1;

        int reponse =0;
        do {
            
            try {
                System.out.println("\n----------------------------------------");
                System.out.println("la ligne courante est " + ((laLigne == ligne1) ? "Ligne 1" : "Ligne 2") + "\n");
                reponse = chosirOperation();
                switch (reponse) {
                    case 1 :
                        System.out.println(laLigne);
                        break;
                    case 2 :
                        System.out.println("nombre de sommets de la ligne : " + laLigne.getNbSommets());
                        System.out.println("longueur de la ligne : " + laLigne.getLongueur());
                        break;
                    case 3 :
                        System.out.println("origne de la ligne : " + laLigne.getOrigine());
                        System.out.println("extremité de la ligne : " + laLigne.getExtremite());
                        break;
                    case 4 :
                        System.out.print("entrer un numéro de sommet : ");
                        int  noSommet = Integer.parseInt(sc.nextLine());
                        System.out.println("le sommet " + noSommet + " est : " + laLigne.getSommet(noSommet));
                        break;
                    case 5 :
                        System.out.println("entrez l'abscisse (x) du sommet à ajouter ");
                        double x = Double.parseDouble(sc.nextLine());
                        System.out.println("entrez l'ordonnée (y) du sommet à ajouter ");
                        double y = Double.parseDouble(sc.nextLine());
                        laLigne.ajouterSommet(x, y);
                        System.out.println("sommet ajouté");
                        break;
                    case 6 :
                        System.out.print("entrer le numéro du sommet à supprimer : ");
                        int  no = Integer.parseInt(sc.nextLine());
                        laLigne.supprimerSommet(no);
                        System.out.println("le sommet " + no+ " a été supprimé");
                        break;
                    case 7 :
                        System.out.println("entrez l'abscisse (x) du sommet à rechercher ");
                        double x1 = Double.parseDouble(sc.nextLine());
                        System.out.println("entrez l'ordonnée (y) du sommet à rechercher ");
                        double y1 = Double.parseDouble(sc.nextLine());
                        if ( laLigne.contient(new Point(x1, y1)) ) {
                            System.out.println("La ligne contient ce point");
                        } else {
                            System.out.println("La ligne ne contient pas ce point");
                        }
                        System.out.println("sommet ajouté");
                        break;
                    case 8 :
                        if (laLigne == ligne1) {
                            laLigne = ligne2;
                        }
                        else {
                            laLigne = ligne1;
                        }
                        break;
                    case 9 :
                        if (ligne1.egale(ligne2)) {
                            System.out.println("les deux ligne ont les mêmes somemts");
                        }
                        else {
                            System.out.println("les deux lignes diffèrent d'au moins un sommet");
                        }
                        break;
                    case 0 :
                        System.out.println("\nAu revoir\n");
                        break;
                    default :
                        System.out.println("\nnuméro d'opération incorrect\n");
                }
            } catch (NumberFormatException e) {
                System.out.println("valeur incorrecte. Saisissez un nombre");
            } catch (IllegalOperationException e) {
                System.out.println("Opération impossible");
                System.out.println(e.getMessage());
            }
            catch (IndexOutOfBoundsException e) {
                System.out.println(e.getMessage());
            }

        } while (reponse != 0);

    }

    static int chosirOperation() {
        // """ ... """ permet de faire des String sur plusieurs lignes (Text Blocks) sans utiliser
        // de \n, disponilbe depuis Java 15
        System.out.println("""
                Choisissez une opération
                1 : afficher la ligne polygonale
                2 : afficher le nombre de sommets et la longueur de la ligne
                3 : afficher l'origine et l'extrémité de la ligne
                4 : afficher un sommet de la ligne
                5 : ajouter un sommet à la ligne
                6 : supprimer un sommet de la ligne
                7 : rechercher si la ligne a un sommet identique à un point donné
                8 : changer de ligne
                9 : comparer les deux lignes
                0 : terminer le programme
                    """);

        System.out.print("Votre choix : ");
        return Integer.parseInt(sc.nextLine());
    }
}
