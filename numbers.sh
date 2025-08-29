#!/bin/bash

#set -x
num=$#
if [[ $num == 0 ]]; then
	echo "Not any parameter. Number between 2 and 99 is required as parameter"
	exit 1
fi
num=$1
if [[ $num -lt 2 || $num -gt 99 ]]; then
	echo "Number must be between 2 and 99"
	exit 1
fi

mult=1
sum=0
i=1

(( i = $num / 2 ))
j=1
while [[ $j -le $i ]] do
	(( mult *= $j ))
	(( j += 1 ))
done

if [[ $( expr $num % 2 ) -gt 0 ]]; then
	(( i += 1 ))
fi
(( i += 1 ))
while [[ $i -le $num ]] do
	(( sum += $i ))
	(( i += 1 ))
done
echo "mult: $mult"
echo "sum: $sum"
