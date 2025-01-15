#!/bin/bash

X=144725

./instant_suivant.sh < $X.entree > $X.ma_sortie
diff $X.sortie $X.ma_sortie

if [ $? -eq 0 ]
then
	echo tout va bien pour le test $X
else
	echo tout va mal pour le test $X
fi
