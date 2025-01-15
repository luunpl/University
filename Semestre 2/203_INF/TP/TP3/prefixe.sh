#!/bin/bash

for f in *.sh 
do
	prefixe=$(basename $f .sh)
	nouveau_f=$prefixe.ploum
	echo nom complet : $f
	echo prefixe : $prefixe
	echo avec un nouveau suffixe : $nouveau_f
done
