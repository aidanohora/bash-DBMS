#!/bin/bash
if [ "$#" -ne 3 ]; then
	echo "Error: Takes three arguements."
elif [ ! -d "$1" ]; then
	echo "Error: Directory does not exist."
elif [ -e "$1"/"$2".csv ]; then
	echo "Error: Table already exists."
else
	./P.sh $1
	touch "$1"/"$2".csv
	echo "$3" > "$1"/"$2".csv
	echo "OK: table created"
	./V.sh $1
fi
