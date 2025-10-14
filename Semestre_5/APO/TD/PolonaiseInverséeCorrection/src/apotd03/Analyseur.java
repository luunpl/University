package apotd03;

class Analyseur {
    /**
     * Évalue une expression en notation polonaise inversée (NPI)
     * 
     * @param expr expression en NPI sous forme de chaîne de caractères
     * @return le résultat de l'évaluation
     * 
     * @throws ParseException "Parsing Error" si l'expression ne peut pas être parsée car elle
     *         contient un caractère non valide
     * 
     * @throws EvalException avec les messages suivants selon les cas
     * 
     *         - "Not enough operands" si l'expression est incorrecte (manque d'opérandes)
     * 
     *         - "Too many operands" si l'expression est incorrecte (trop d'opérandes)
     * 
     *         - "Division by zero" si une division par zéro est tentée
     */
    int eval(String expr) throws ParseException, EvalException {


        // découpe l'expression en fragments
        Fragment[] fragments = parse(expr);

        PileFragments pileOperandes = new PileFragments(); // pile où seront empilés les fragments
                                                           // de type NUM, et les résultats de
                                                           // calculs intrermédiaires
         try {
                                                 

        for (Fragment f : fragments) {
            if (f.type == TypeFragment.NUM) {
                pileOperandes.empiler(f);
            } else { // f.type == TypeFragment.OP le fragment est un opérateur

                // dépile les deux fragments en sommet de pile qui serviront d'opérande
                Fragment f2 = pileOperandes.depiler();
                Fragment f1 = pileOperandes.depiler();
  

                int operande2 = this.entier(f2.valeur);
                int operande1 = this.entier(f1.valeur);
                int resultatOperation = 0;
                // effectuer l'opération définie par l'opérateur
                switch (f.valeur) {
                    case "+":
                        resultatOperation = operande1 + operande2;
                        break;
                    case "-":
                        resultatOperation = operande1 - operande2;
                        break;
                    case "/":
                        if (operande2 == 0) {
                            throw new EvalException("Division by zero");
                        }
                        resultatOperation = operande1 / operande2;
                        break;
                    case "*":
                        resultatOperation = operande1 * operande2;
                        break;
                    // default:
                    // throw new Exception("Unknown operator");
                    // inutile car parse a verifié que les operateurs sont corrects
                }

                // empile le résultat de l'operation sous la forme de fragment
                // String.valueOf(resultatOperation) convertit en String l'entier resultatOperation
                pileOperandes
                        .empiler(new Fragment(TypeFragment.NUM, String.valueOf(resultatOperation)));

            } // end else
        } // end for

        // lorsque l'on a traité tous les fragments, la pile ne doit contenir qu'un seul
        // élement le résultat final

        Fragment fragmentResultat = pileOperandes.depiler();
        if (!pileOperandes.estVide()) {
            throw new EvalException("Too many operands");
        }
        int resultat = entier(fragmentResultat.valeur);
        return resultat;
        
         } catch (PileException ex) {
            // on a essayé de faire un dépiler sur une pile vide
            // on traduit cela en une EvalException indiquant qu'il manque un opérande
            throw new EvalException("Not enough operands");
         }
    }

    /**
     * Analyse lexicale, découpage en fragments selon les opérateurs + - * / Version avec expression
     * régulière
     * 
     * @param expr expression sous forme de chaîne de caractères
     * @return un tableau de fragments
     * @throws Exception "Unknown operator" si l'expression contient un opérateur non reconnu
     */
    Fragment[] parse(String expr) throws ParseException {

        Fragment[] lesFragments = new Fragment[expr.length()]; // au plus il y a autant
        // de fragments que de caractères dans l'expression

        int nbFragments = 0; // le nombre de fragments trouvés
        int i = 0; // indice de parcours de la chaine
        Fragment fragment; // le fragment identifié
        while (i < expr.length()) {

            // sauter les espaces
            while (i < expr.length() && expr.charAt(i) == ' ') {
                i++;
            }
            if (i < expr.length()) {
                // le caractère courant n'est pas un espace
                char c = expr.charAt(i);
                if (c == '+' || c == '-' || c == '*' || c == '/') {
                    // c est un opérateur
                    fragment = new Fragment(TypeFragment.OP, Character.toString(expr.charAt(i)));
                    i++; // le caractère à été traité ne pas oublié de passer au caractère suivant
                } else if (Character.isDigit(c)) {
                    // c est un chiffre
                    String num = "";
                    while (i < expr.length() && Character.isDigit(expr.charAt(i))) {
                        num += expr.charAt(i);
                        i++;
                    }
                    fragment = new Fragment(TypeFragment.NUM, num);
                } else {
                    // le caractère n'est pas un espace, un opérateur ou un chiffre, il est invalide
                    throw new ParseException("Parsing error, invalid char : " + c + "'");
                }
                // si on arrive ici on est passé dans l'un des deux premiers cas, un fragment a été
                // créé
                lesFragments[nbFragments] = fragment;
                nbFragments++;

            }
        }
        // le parcours de la chaîne expr est terminé, on peut retourné les tableau des fragments
        // trouvés. Mais avant il faut ajuster la taille du tableau lesFragments au nombre de
        // fragments trouvés
        Fragment[] newTab = new Fragment[nbFragments];
        for (int j = 0; j < nbFragments; j++) {
            newTab[j] = lesFragments[j];
        }
        return newTab;
        // on aurait pu faire plus conçis en utilsant la méthode copyOf de la calsse Array
        // définie dans le package java.util.
        //
        // return Arrays.copyOf(lesFragments, nbFragments);

    }


    /**
     * Renvoie la valeur entière d'une chaîne de caractères représentant un entier naturel au format
     * décimal.
     * 
     * @param s chaîne de caractères représentant un entier naturel au format décimal
     * @return la valeur entière correspondante
     */
    int entier(String s) {
        int n = 0;
        for (int i = 0; i < s.length(); i++) {
            char c = s.charAt(i);
            if (c < '0' || c > '9') {
                throw new NumberFormatException("Invalid integer format"); // mais dans le cas
                // présent vu la manière dont parse est écrite cela peut pas arriver
                // vous remarquerez que NumberFormatException est une classe d'exception
                // prédéfinie dans Java, c'est une sous classe de RuntimeException et il
                // n'ya donc pas l'obligation de les déclarer.
            }
            n = n * 10 + (c - '0');
        }
        return n;

        // remarque on pourrait être beaucoup plus conçis et utiliser la méthode parseInt de la
        // classe Integer
        //
        // return Integer.parseInt(s);
        //
        // elel aussi peut lancer une NumberFormatException si la châine n'est pas un nombre
        // mais vous faire programmer vous même cette conversion présente l'intérêt de vous faire
        // manipuler les structures algorithmique de base.

    }
}
