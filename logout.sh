#!/bin/bash
#OpenAM shell REST client
#Logs out an authenticated user

#pull in settings file
source settings

URL="$PROTOCOL://$OPENAM_SERVER:$OPENAM_SERVER_PORT/openam/identity/$FORMAT/logout"
DATA="subjectid=$1"

#check that token is passed as an argument
if [ "$1" = "" ]; then
	echo "Token missing!  Eg $0 QIC5wM2LY4SfcxvdvHOXjtC_eWSs2RB54tgvgK8SuYi7aQ"
	exit
fi

#check that curl is present
CURL_LOC="$(which curl)"
if [ "$CURL_LOC" = "" ]; then
	echo "Curl not found.  Please install sudo apt-get install curl etc..."
	exit
fi


if [ "$FORMAT" = "json" ]; then

	#check that jq util is present
	JQ_LOC="$(which jq)"
	if [ "$JQ_LOC" = "" ]; then
	   	echo "JSON parser jq not found.  Download from http://stedolan.github.com/jq/download/"
   	exit
	fi

	./posturl.sh $URL $DATA | jq .

else
	#check that xmllint util is present
	XML_LOC="$(which jq)"
	if [ "$XML_LOC" = "" ]; then
	   	echo "XMLLINT parser XML not found."
	   	exit
	fi	

	echo ""
	./posturl.sh $URL $DATA > response.xml
	echo ""
	xmllint --format response.xml
	echo ""

fi
