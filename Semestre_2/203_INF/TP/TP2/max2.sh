#!/bin/bash
echo "Saisissez deux entiers"
read n1
read n2
if [ $n1 -gt $n2 ]
then
	max=$n1
else
	max=$n2
fi
echo Le plus grand des deux entiers $n1 et $n2 est $max

