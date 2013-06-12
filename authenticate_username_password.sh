#!/bin/bash
#OpenAM shell REST client
#Authenticates a user using username and password.  Returns token in JSON

#pull in settings file
source settings

URL="$PROTOCOL://$OPENAM_SERVER:$OPENAM_SERVER_PORT/openam/identity/$FORMAT/authenticate"
DATA="username=$1&password=$2"

#check that username is passed as an argument
if [ "$1" = "" ]; then
	echo "Username missing!  Eg $0 bjensen Passw0rd"
	exit
fi

#check that password is passed as an argument
if [ "$2" = "" ]; then
	echo "Password missing!  Eg $0 bjensen Passw0rd"
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
