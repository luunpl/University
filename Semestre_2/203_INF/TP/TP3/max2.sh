#!/bin/bash

if [ $1 -gt $2 ]
then
	echo $1 est plus grand que $2  
elif [ $1 -lt $2 ]
then 
	echo $2 est plus grand que $1  
else
	echo les deux entiers $1 et $2 sont egaux
fi

