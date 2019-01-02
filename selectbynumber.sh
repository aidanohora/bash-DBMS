#!/bin/bash
if [ "$#" -lt 2 ]; then
	echo "Error: parameters problem."
elif [ ! -d "$1" ]; then
	echo "Error: Directory does not exist."
elif [ ! -e "$1"/"$2".csv ]; then
	echo "Error: Table does not exist."
else
	./P.sh "$1"
	row1=$(head -n1 "$1"/"$2".csv)
	IFS="," read -r -a par3array <<< "$3"
	IFS="," read -r -a row1array <<< "$row1"
	fieldno=1
	rowlength=${#row1array[@]}
	rowlength=$((rowlength-1))
	for i in $(seq 0 $rowlength); do
		row1array[$i]="$fieldno"
		fieldno=$((fieldno+1))
	done
	row1string="${row1array[@]}"
	if [ "$#" -eq 3 ]; then 
		for i in "${par3array[@]}"; do
			check=0
			if [[ $row1string != *"$i"* ]]; then
				echo "Error: Column does not exist."
			else
				check=1
			fi
		done
		if [[ $check == 1 ]]; then
			echo "start_result"
			file="$1"/"$2".csv
			while IFS= read -r line
			do
				echo $line | cut -d, -f$3 
			done <"$file"
			echo "end_result"
		fi
	else
		echo "start_result"
		file="$1"/"$2".csv
		while IFS= read -r line
		do
			echo $line
		done <"$file"
		echo "end_result"
	fi
	./V.sh $1
fi
