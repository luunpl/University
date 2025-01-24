#!/bin/bash

# Avant chaque fonction, on utilise la commande clear pour reinitialiser le terminal

for ((i = 1; i <= 10; i++)); do
    clear
    cowsay $i
    sleep 1
done
