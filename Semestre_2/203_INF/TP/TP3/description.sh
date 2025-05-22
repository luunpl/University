#!/bin/bash

for FILE in * 
do
	if  [ -f $FILE ]
	then
		if [ -x $FILE ]
		then
			echo "$FILE est un fichier executable"
		else
			echo "$FILE est un fichier non executable"
		fi
	fi
	if [ -d $FILE ]
	then
		echo $FILE est un repertoire
	fi
done
