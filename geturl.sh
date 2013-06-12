#!/bin/bash
#OpenAM Shell REST Client
#Wrapper for quickly calling curl to perform a GET against OpenAM

#check that URL is passed as an argument
if [ "$1" = "" ]; then
	echo "Argument missing.  Requires URL"
	exit
fi

#check that curl is present
CURL_LOC="$(which curl)"
if [ "$CURL_LOC" = "" ]; then
	echo "Curl not found.  Please install sudo apt-get install curl etc..."
	exit
fi

URL=$1

curl --request GET $URL


