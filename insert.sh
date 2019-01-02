#!/bin/bash
if [ "$#" -ne 3 ]; then
	echo "Error: Takes three arguements."
elif [ ! -d "$1" ]; then
	echo "Error: Directory does not exist."
elif [ ! -e "$1"/"$2".csv ]; then
	echo "Error: Table does not exist."
else
	./P.sh $1
	columns=$(head -n1 "$1"/"$2".csv | grep -o "," | wc -l)
	values=$(echo $3 | grep -o "," | wc -l)
	if [ $columns != $values ]; then
		echo "Error: number of columns in tuple does not match schema."
	else
		echo $3 >> "$1"/"$2".csv
		echo "OK: tuple inserted"
	fi
	./V.sh $1	
fi
