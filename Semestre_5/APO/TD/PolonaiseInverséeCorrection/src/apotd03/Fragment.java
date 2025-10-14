package apotd03;

/**
 * Fragment produit par le "parser" de l'analyseur qui découpe
 * la châine correspondant à l'expression à analyser en sous-chaînes
 * qui sont sit un opérateur, soit un nombre.
 */
class Fragment {
    TypeFragment type;  // le type du Fragment OP ou NUM
    String valeur;      // la "valeur" du fragment sous forme de chaîne de caractères

    /**
     * Constructeur
     * @param type    type du fragment
     * @param valeur  valeur du fragment
     */
    Fragment(TypeFragment type, String valeur) {
        this.type = type;
        this.valeur = valeur;
    }
}
