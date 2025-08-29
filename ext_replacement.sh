#!/bin/bash

dir_path="$PWD/"
#set -x

ext=""
rep=""
file=""
files=()
files_num=0

while [[ $# -gt 0 ]]; do
	case $1 in
		--extension)
			ext=$2
			shift
			shift
			;;
		--replacement)
			rep=$2
			shift
			shift
			;;
		--file)
			file=$2
			files+=($file)
			(( files_num += 1 ))
			if [ ! -f $file ]; then
				echo "Error: file $file does not exist"
				exit 1
			fi
			shift
			shift
			;;
		*)
			shift
			shift
			;;
	esac
done

if [[ ($ext == "") || ($rep == "") || ($file == "") ]]; then
	echo "Wrong number of parameters. 3 parameters are required: --file --extension --replacement"
	exit 1
fi

while [[ $files_num -gt 0 ]]; do
	file=${files[$files_num-1]}
	if [[ ${files[$files_num-1]} == *.$ext ]] then
		file_new_name=$(echo "${file/$ext/$rep}")
		if [[ $file != $file_new_name ]]; then
			mv "$file" "$file_new_name"
			echo "$dir_path$file_new_name"
		fi
		(( files_num -= 1 ))
        else
		echo "$dir_path$file"
		(( files_num -= 1 ))
	fi
done
