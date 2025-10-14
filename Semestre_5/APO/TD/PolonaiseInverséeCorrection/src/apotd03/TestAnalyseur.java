package apotd03;

class TestAnalyseur {
    public static void main(String[] args) {
        String[] expressions = {
            "3 5 +",    // 8
            "10 2 -",   // 8
            "4 6 *",    // 24
            "8 2 /",    // 4
            "5 1 2",    // Invalid: missing operator
            "7 +",      // Invalid: missing operand
            "9 3 / 2 *", // 6
            "1 2 + 4 * 3 +", // 15
            "33 4z +",
        };
        Analyseur analyseur = new Analyseur();
        for (String expression : expressions) {
            System.out.println("Evaluating: " + expression);
            try {
                int resultat = analyseur.eval(expression);
                System.out.println("Result: " + resultat);
            } catch (Exception e) {
                System.err.println("Error: " + e.getMessage());
            }
        }
    }
}
