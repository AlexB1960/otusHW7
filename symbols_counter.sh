#!/bin/bash

#set -x
dir_path="$PWD/"
file=""
search=""

while [[ $# -gt 0 ]]; do
	case $1 in
		--file)
			file=$2
			if [[ ! -f $file ]]; then
				echo "Error: file $file does not exist"
				exit 1
			fi
			shift
			shift
			;;
		--search)
			search=$2
			shift
			shift
			;;
		*)
			shift
			shift
			;;
	esac

done

if [[ ($file == "") || ($search == "") ]]; then
	echo "Error: not enough parameters. 2 parameters are required: --file --search"
	exit 1
fi

if [[ $( grep -c $search $file ) == 0 ]]; then
	echo "Не найдено ни одного совпадения в файле $dir_path$file"
else
	echo $( grep -c $search $file )
fi
