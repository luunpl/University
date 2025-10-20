# Instructions pour compiler et exécuter 

Avant toute chose ouvrir un terminal et vous placer dans le répertoire **Bataille1Correction**. Ensuite pour compiler et exécuter votre code, effectuez les commandes suivantes :


- pour compiler

```bash
javac -d bin -classpath bin src/bataille/LeNomDeLaClasse.java
```

Par exemple pour compiler **Joueur.java**

```bash
javac -d bin -classpath bin src/bataille/Joueur.java
```



- pour exécuter 

```bash
java -classpath bin bataille.LenomDeLaClasse
```

Par exemple pour exécuter l'interface graphique **BatailleGUI.java**

```bash
java -classpath bin bataille.BatailleGUI
```

