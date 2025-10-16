package apotd03;

/**
 * Pile de fragments implémentée à l'aide d'un tableau qui contient les références des fragments
 * empilés. La taille du tableau est fixée par défaut à 10 lors de la création d'une pile de
 * fragments.
 * 
 * Lorsque l'on empile un nouveau fragment la pile est pleine (le nombre de fragments empilés est
 * égal à la taille du tableau), un nouveau tableau de taille plus grande est alloué pour la pile.
 * Les références de fragments dans la pile sont recopiée dans ce nouveau tableau, et on y ajoute et
 * le nouveau fragment est ajouté à son sommet.
 * 
 */
class PileFragments {

    static final int DEFAULT_CAPACITY = 10;

    //------ Attributs ----------------------------------------------------------------

    Fragment[] elements; // le tableau pour stocker les références des fragents empilés
    int nbFragments; // le nombre de fragments que contient la pile (0 si elle est vide)
                     // l'indice du fragment situé en bas de pile est 0
                     // l'indice du fragment situé au sommet de pile est nbFragments - 1


     //------ Constructeurs ------------------------------------------------------------                


    /**
     * Création d'un pile de fragments en fixant sa cpacité initiale
     * @param initialCapacity la capacité initiale de la pile
     */
    PileFragments(int initialCapacity) {
        elements = new Fragment[initialCapacity];
        nbFragments = 0;
    }

    /**
     * Création d'un pile de fragments avec une capacité par défaut (10 ici)
     */
    PileFragments() {
        this(DEFAULT_CAPACITY); // appelle le constructeur PileFragments(int)
    }

    //------ Méthodes ------------------------------------------------------------  

    /**
     * @return true si la pile ne contient aucun Fragment
     */
    boolean estVide() {
        return nbFragments == 0;
    }

    /**
     * Dépile un élément de la pile, c'est a dire retire l'élément situé au sommet de la pile
     * 
     * @return l'élément dépilé si la pile n'est pas vide
     * @throws PileException "Pile vide" si la pile est vide
     */
    Fragment depiler() throws PileException {
        if (estVide()) {
            throw new PileException("Pile vide");
        }
        Fragment f = elements[nbFragments - 1];   // fragment en sommet de pile
        nbFragments--;  // la pile a un élément de moins
        return f;  // renvoie le fragment qui a été dépilé
    }

    /**
     * Empile un Fragment dans la pile
     * 
     * @param f le fragment à empiler
     */
    void empiler(Fragment f) {
        if (nbFragments == elements.length) {
            // le tableau qui représente la pile est plein, il faut un tableau plus
            // pour pouvoir y stocker la référence f

            // allocation d'un tableau plus grand
            Fragment[] newElements = new Fragment[elements.length + DEFAULT_CAPACITY];
            // recopie dans newElements des références stockées dans elements
            for (int i = 0; i < elements.length; i++) {
                newElements[i] = elements[i];
            }
            // remplace elements par newElements
            elements = newElements;
        }

        // on stocke le fragment à empiler au sommet de la pile
        nbFragments++;  
        elements[nbFragments - 1] = f;   
    }
}
