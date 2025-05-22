#!/bin/bash

# Initialisation de la suite
a=0
b=1
while [ $b -le $1 ]; do
    clear
    cowsay $b
    sleep 1
    # Calculer le nombre suivant
    temp=$b
    b=$(($a + $b))
    a=$temp
done
