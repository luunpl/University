#!/bin/bash

read instant

heure=$(echo $instant | cut -d: -f 1)
minute=$(echo $instant | cut -d: -f 2)
seconde=$(echo $instant | cut -d: -f 3)

# echo $heure $minute $seconde 

secondesuivbrute=$(expr $seconde + 1)
minutesuivbrute=$(expr $minute + $secondesuivbrute / 60)
heuresuivbrute=$(expr $heure + $minutesuivbrute / 60)
# echo $heuresuivbrute $minutesuivbrute $secondesuivbrute 

secondesuiv=$(expr $secondesuivbrute % 60)
minutesuiv=$(expr $minutesuivbrute % 60)
heuresuiv=$(expr $heuresuivbrute % 24)
echo $heuresuiv:$minutesuiv:$secondesuiv 

