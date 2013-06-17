#!/bin/bash
#OpenAM shell REST client
#Authenticates a user using username and password.  Returns token in JSON

#pull in settings file
source settings

URL="$PROTOCOL://$OPENAM_SERVER:$OPENAM_SERVER_PORT/openam/identity/json/authenticate"
DATA="username=$1&password=$2"

#check that username is passed as an argument
if [ "$1" = "" ]; then
	echo ""
	echo "Username missing!  Eg $0 bjensen Passw0rd"
	echo ""
	exit
fi

#check that password is passed as an argument
if [ "$2" = "" ]; then
	echo ""
	echo "Password missing!  Eg $0 bjensen Passw0rd"
	echo ""
	exit
fi

#check that curl is present
CURL_LOC="$(which curl)"
if [ "$CURL_LOC" = "" ]; then
	echo ""
	echo "Curl not found.  Please install sudo apt-get install curl etc..."
	echo ""
	exit
fi


#check that jq util is present
JQ_LOC="$(which jq)"
if [ "$JQ_LOC" = "" ]; then
	echo ""
   	echo "JSON parser jq not found.  Download from http://stedolan.github.com/jq/download/"
	echo ""
 	exit
fi

echo ""

#./posturl.sh $URL $DATA | jq '.tokenId'
TOKEN=$(./posturl.sh $URL $DATA | jq '.tokenId')

echo ""

if [ "$TOKEN" = null ]; then
	
	echo ""	
	echo "No token returned.  Check username and password"	
	echo ""

else
	
	echo ""
	echo "OpenAM token returned as: $TOKEN"
	#save token in hidden read-only file		
	rm -f .token
	echo $TOKEN > .token
	chmod 400 .token
	echo ""		
	echo "Token saved in read only hidden .token file for later use"
	echo ""

fi



