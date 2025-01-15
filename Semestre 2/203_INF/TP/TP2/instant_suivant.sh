#!/bin/bash

# lecture de la variable instant : à compléter

# instant est de la forme heure:minute:seconde
# lecture de chaque champ avec la commande cut :
heure=$(echo $instant | cut -d: -f 1)
# a completer pour minute et seconde :

# affichage eventuel de heure minute et seconde pour verifier que tout s'est bien passé. à compléter
echo $heure $minute $seconde 

# ajouter 1 à seconde pour obtenir secondesuiv : à compléter

# ajouter minute et secondesuiv/60 pour obtenir minutesuiv : à compléter

# ajouter heure et minutesuiv/60 pour obtenir heuresuiv : à compléter


# affichage eventuel de heuresuiv minutesuiv et secondesuiv pour verifier que tout s'est bien passé. à compléter


# correction des résultats au changement de minute, d'heure et de jour :
# prendre le reste de secondesuiv par 60 (dans secondesuiv par exemple) 
secondesuiv=$(expr $secondesuiv % 60)
# de même pour minutesuiv : à compléter

# trouver par qui prendre le reste pour heuresuiv : à compléter


# affichage de heuresuiv minutesuiv et secondesuiv pour verifier que tout s'est bien passé.


