#!/bin/bash
if [ "$#" -eq 0 ]; then
	echo Error: no parameter
elif [ -d "$1" ]; then
	echo Error: DB already exists
else
	mkdir $1
	./P.sh "$1"	
	echo "OK: database created" 
	./V.sh "$1"
fi
