#!/bin/bash

#set -x

url=""
url_regexp="^https?://([^/]+)"
browser=""
version=""
version_regexp="^[1-9]"
comand="mvn clean test"

while [[ $# -gt 0 ]]; do
	case $1 in
		--baseURL)
			url=$2
			if [[ $url =~ $url_regexp ]]; then
				shift
				shift
			else
				echo "Error: url is not correct"
				exit 1
			fi
			;;
		--browserName)
			browser=$2
			browser=${browser,,}
			if [[ ($browser != "chrome") && ($browser != "firefox") && ($browser != "edge") && ($browser != "remotechrome" ) ]]; then
				echo "Error: browser $browser is not supported"
                                exit 1
			fi
			shift
			shift
			;;
		--browserVersion)
			version=$2
			if [[ $version =~ $version_regexp ]]; then
				shift
				shift
			else
				echo "Error: browserVersion must begin with number"
				exit 1
			fi
			;;
		*)
			shift
			shift
			;;
	esac
done

if [[ $browser != "" ]]; then
	comand=$comand" -DbrowserName="$browser
fi

if [[ $version != "" ]]; then
	comand=$comand" -DbrowserVersion="$version
fi

if [[ $url != "" ]]; then
	comand=$comand" -DbaseURL="$url
fi

echo $comand
$comand
