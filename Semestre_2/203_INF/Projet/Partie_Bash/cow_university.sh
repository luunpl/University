#!/bin/bash

# On cree une fonction est_premier pour checker si un nombre est premier
est_premier() {
    num=$1
    # Les cas inferieurs a 2 ne sont pas des entiers premiers
    if [ $num -lt 2 ]; then
        return 1
    fi
    # Les autres cas
    i=2
    while [ $i -lt $num ]; do
        if [ $((num % i)) -eq 0 ]; then
            return 1
        fi
        i=$(expr $i + 1)
    done
    return 0
}


n=$1
for ((num = 2; num < n; num++)); do
    clear
    if est_premier $num; then
        cowsay $num
        sleep 1           # Cette fois sleep doit etre dans le boucle sinon le temps mort devient grand quand n augmente
    fi
    
done
