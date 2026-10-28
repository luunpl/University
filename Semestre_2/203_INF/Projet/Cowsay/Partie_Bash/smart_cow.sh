#!/bin/bash

clear
expression=$1
resultat=$(bc <<<"$expression") # On utilise une commande bc (Basic Calculator) pour resoudre cette question
cowsay -e $resultat $expression # Option -e nous permet de changer les yeux du cow en 1er arg et dire le 2e arg
