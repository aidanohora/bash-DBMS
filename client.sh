#!/bin/bash

# trap ctrl_c and call ctrl_c()
trap ctrl_c INT

function ctrl_c(){
	echo " Disconnecting..."
	if [ -e /tmp/"$pipestring" ]; then
		rm /tmp/"$pipestring"
	fi
	exit 0
}

if [ "$#" -ne 1 ]; then
	echo "Error: Invalid number of arguements for user id."
else
	id=$1
	halfpipe='.pipe'
	pipestring="$1$halfpipe"
	mkfifo /tmp/"$pipestring"
	while true; do
		if [ ! -e /tmp/server.pipe ]; then
			echo "Error: Server is offline. Exiting..."
			rm /tmp/"$pipestring"
			exit 0
		fi
		read userinput
		if [ "$userinput" == exit ]; then
			echo "Disconnecting..."
			rm /tmp/"$pipestring"
			exit 0
		fi
		read -ra inputarray <<< "$userinput"
		reqcommand="${inputarray[0]}"
		cmnd="${inputarray[1]}"
		arrlen=${#inputarray[@]}
		if [ "$reqcommand" == req ] && [ "$arrlen" -gt 1 ]; then
			newarr=("${inputarray[@]/$reqcommand}")
			newstring=$( echo "${newarr[@]}" )
			echo "req $id $newstring" > /tmp/server.pipe
			if [ $cmnd == select ] || [ $cmnd == selectbynumber ]; then
			       cat /tmp/$id.pipe
		        else
				read output < /tmp/$id.pipe
				echo $output
			fi		
		else
			echo "Error: Request is not properly formed."
		fi
	done
fi			
