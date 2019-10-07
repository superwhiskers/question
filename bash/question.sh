#!/bin/bash

# implementation of the question function in bash
function question() {
	valid=(${2//,\ / })
	
	while true; do
		echo $1
		if [ "${#valid[@]}" != 0 ]; then
			echo -n "($(local IFS=", "; shift; echo "$1")): "
		else
			echo -n ": "
		fi
		
		read input
		
		if [ "${#valid[@]}" == 0 ]; then
			eval "$3=$input"
			return
		fi
		
		for (( i=0; i<${#valid[@]}; i++ )); do
			if [ "$input" == "${valid[$i]}" ]; then
				eval "$3=$input"
				return
			fi
		done
		
		echo "\"$input\" is not a valid answer"
	done
}

output=''
question "foo" "bar, baz" output
