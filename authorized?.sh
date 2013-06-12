#!/bin/bash
#OpenAM shell REST client
#Checks current is authorized to access a given URI

#pull in settings file
source settings

#pull in encode url script
source url_encoder.sh

#check that URI is passed as an argument
if [ "$1" = "" ]; then
	echo "URI missing!  Eg $0 http://server.example.com:80/resource FJSJ3453KKS...."
	exit
fi

#check that token is passed as an argument
if [ "$2" = "" ]; then
	echo "Token missing!  Eg $0 http://server.example.com:80/resource FJSJ3453KKS...."
	exit
fi

#encode the URI
RESOURCE_URI=$(encode_url $1)

URL="$PROTOCOL://$OPENAM_SERVER:$OPENAM_SERVER_PORT/openam/identity/$FORMAT/authorize?uri=$RESOURCE_URI&subjectid=$2"

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

	./posturl.sh $URL | jq .

else
	#check that xmllint util is present
	XML_LOC="$(which jq)"
	if [ "$XML_LOC" = "" ]; then
	   	echo "XMLLINT parser XML not found."
	   	exit
	fi	
	echo ""
	./posturl.sh $URL > response.xml
	echo ""
	xmllint --format response.xml
	echo ""

fi

