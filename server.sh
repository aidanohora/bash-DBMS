#!/bin/bash

#trap ctrl-c and call ctrl_c()
trap ctrl_c INT

function ctrl_c() {
	echo " Shutting down..."
	rm /tmp/server.pipe
	exit 0
}


mkfifo /tmp/server.pipe
while true; do
	read input < /tmp/server.pipe
	read -ra inputarray <<< "$input"
	id="${inputarray[1]}"
	cmnd="${inputarray[2]}"
	arrlen=${#inputarray[@]}
	if [ "$cmnd" == create_database ] && [ "$arrlen" == 4 ]; then
		./create_database.sh "${inputarray[3]}" >> /tmp/$id.pipe &
	elif [ "$cmnd" == create_table ] && [ "$arrlen" == 6 ]; then
		./create_table.sh "${inputarray[3]}" "${inputarray[4]}" "${inputarray[5]}" >> /tmp/$id.pipe &
	elif [ "$cmnd" == insert ] && [ "$arrlen" == 6 ]; then
		./insert.sh "${inputarray[3]}" "${inputarray[4]}" "${inputarray[5]}" >> /tmp/$id.pipe &
	elif [ "$cmnd" == select ] && [ "$arrlen" == 6 ]; then
		./select.sh "${inputarray[3]}" "${inputarray[4]}" "${inputarray[5]}" >> /tmp/$id.pipe &
	elif [ "$cmnd" == select ] && [ "$arrlen" == 5 ]; then
		./select.sh "${inputarray[3]}" "${inputarray[4]}" >> /tmp/$id.pipe &
	elif [ "$cmnd" == selectbynumber ] && [ "$arrlen" == 6 ]; then
		./selectbynumber.sh "${inputarray[3]}" "${inputarray[4]}" "${inputarray[5]}" >> /tmp/$id.pipe &
	elif [ "$cmnd" == selectbynumber ] && [ "$arrlen" == 5 ]; then
	       ./selectbynumber.sh "${inputarray[3]}" "${inputarray[4]}" >> /tmp/$id.pipe &	
	elif [ "$cmnd" == shutdown ]; then
		if [ "${inputarray[3]}" == "a37hf" ]; then
			echo "The server will now shutdown." > /tmp/$id.pipe
			rm /tmp/server.pipe
			echo "Remote shutdown command authorised: Shutting down..."
			exit 0
		else
			echo "Error: Command not authorised." > /tmp/$id.pipe
		fi
	else
		echo "Error: bad request" > /tmp/$id.pipe
	fi
done
