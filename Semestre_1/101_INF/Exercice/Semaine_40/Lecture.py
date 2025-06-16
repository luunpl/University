"""
Ecrire un programme qui commence par demander à l'utilisateur un nombre avec "Nombre max de lettres ?", puis qui demande répétitivement une lettre à l'utilisateur en affichant "Lettre :" jusqu'à ce que:

soit le nombre max. de lettres soit atteint,
soit l'utilisateur tape "stop" à la place de la lettre attendue.
Le programme doit finir en affichant le mot obtenu par la concaténation de toutes les lettres données par l'utilisateur.

Note: on ne demande pas de vérifier que l'utilisateur ne tape qu'une seule lettre à chaque fois.

Exemple 1
Nombre max de lettres ? 3
Lettre : a
Lettre : b
Lettre : c
abc

Exemple 2
Nombre max de lettres ? 4
Lettre : a
Lettre : b
Lettre : stop
ab

Exemple 3
Nombre max de lettres ? 0

Exemple 4
Nombre max de lettres ? 5
Lettre : stop
"""

x = int(input('Nombre max de lettres ?'))
y = 1
mot = ""
if x != 0:
    while y <= x:
        Lettre = str(input('Lettre : '))
        if Lettre != 'stop':
            mot = mot + Lettre
        else:
            break
        y += 1
print(mot)
