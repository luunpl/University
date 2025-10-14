class Caisse {
    final String id;     // chaine non vide
    final double poids;  // poids en kilogramme

    /**
     * Creation d'une caisse 
     * @param  id l'id de la caisse
     * @param poids le poids de la caisse  en 
     * 
     * @throws IllegalArgumentException si la caisse à un poids négatif ou nul
     */
    Caisse(String id, double poids) {
        if (poids  <= 0) {
            throw new IllegalArgumentException("poids incorrect");
        }
        this.id = id;
        this.poids = poids;
    }

    public String toString() {
        return "[" + id + " : " + poids + "]";
    }
}

