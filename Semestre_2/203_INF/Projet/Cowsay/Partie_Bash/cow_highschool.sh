#!/bin/bash

for ((i = 1; i <= $1; i++)); do
    clear
    carre=$(($i * $i))
    cowsay $carre
    sleep 1
done
