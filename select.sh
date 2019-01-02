#!/bin/bash
if [ "$#" -lt 2 ]; then
	echo "Error: Parameters problem."
elif [ ! -d "$1" ]; then
	echo "Error: Directory does not exist."
elif [ ! -e "$1"/"$2".csv ]; then
	echo "Error: Table does not exist."
else
	./P.sh $1
	row1=$(head -n1 "$1"/"$2".csv)
	IFS="," read -r -a par3array <<< "$3"
	IFS="," read -r -a row1array <<< "$row1"
	par3length=${#par3array[@]}
	printstring=""
	icounter=1
	for i in "${par3array[@]}"
       	do	
		jcounter=1
		parname="${i,,}"
		for j in "${row1array[@]}" 
		do	
			rowname="${j,,}"
			if [ $parname == $rowname ] && [ $icounter == $par3length ]; then
				printstring="$printstring$jcounter"
			elif [ $parname == $rowname ]; then
				printstring=" $printstring$jcounter,"
			
			fi
			jcounter=$((jcounter+1))
		done
		icounter=$((icounter+1))
	done
	if [ "$printstring" == "" ] && [ "$#" -eq 3 ]; then
		echo "Error: Column names not found."
	else
		echo "start_result"
		file="$1"/"$2".csv
		while IFS= read -r line
		do
			if [ "$#" -eq 3 ]; then
				echo $line | cut -d, -f$printstring
			else
				echo $line
			fi
		done <"$file"
		echo "end_result"
	fi
	./V.sh $1
fi

