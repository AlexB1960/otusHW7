#!/bin/bash

#set -x

url=""
url_regexp="^https?://([^/]+)"
browser=""
comand="mvn clean test"

while [[ $# -gt 0 ]]; do
	case $1 in
		--url)
			url=$2
			if [[ $url =~ $url_regexp ]]; then
				shift
				shift
			else
				echo "Error: url is not correct"
				exit 1
			fi
			;;
		--browser)
			browser=$2
			browser=${browser,,}
			if [[ ($browser != "chrome") && ($browser != "firefox") && ($browser != "edge") ]]; then
				echo "Error: browser $browser is not supported"
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

if [[ $browser != "" ]]; then
	comand=$comand" -Dbrowser="$browser
fi

if [[ $url != "" ]]; then
	comand=$comand" -Dbase.url="$url
fi

echo $comand
$comand
