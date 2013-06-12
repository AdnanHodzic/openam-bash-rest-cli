#!/bin/bash
#OpenAM Shell REST Client
#Wrapper for quickly calling curl to perform a POST against OpenAM

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

#check that data is passed as an argument
if [ "$2" = "" ]; then

	curl --request POST $URL

else
	DATA="$2"
	curl --request POST --data $DATA $URL

fi

