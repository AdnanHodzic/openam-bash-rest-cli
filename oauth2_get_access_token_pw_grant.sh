#!/bin/bash
#OpenAM shell REST client
#Authenticates user against OAuth2 IdP and returns access/refresh token

#pull in settings file
source settings

#pull in url_encoder
source url_encoder.sh

#check that username is passed as an argument
if [ "$1" = "" ]; then
	echo ""
	echo "Username missing!  Eg $0 username password clientID clientPassword"
	echo ""
	exit
fi

#check that password is passed as an argument
if [ "$2" = "" ]; then
	echo ""
	echo "Password missing!  Eg $0 username password clientID clientPassword"
	echo ""
	exit
fi

#check that client ID is passed as an argument
if [ "$3" = "" ]; then
	echo ""
	echo "Client ID missing!  Eg $0 username password clientID clientPassword"
	echo ""
	exit
fi

#check that client password is passed as an argument
if [ "$4" = "" ]; then
	echo ""
	echo "Client password missing!  Eg $0 username password clientID clientPassword"
	echo ""
	exit
fi

#check that scope as an argument
if [ "$5" = "" ]; then
	echo ""
	echo "Scope missing!"
	echo "Eg $0 username password clientID clientPassword cn%20mail"
	echo "Eg $0 username password clientID clientPassword uid"
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

USERNAME=$1
PASSWORD=$2
CLIENT=$3
CLIENT_PASSWORD=$4
SCOPE=$5

#DATA="grant_type=password&username=$1&password=$2&scope=uid"

DATA="grant_type=password&username=$USERNAME&password=$PASSWORD&scope=$SCOPE"

URL="$PROTOCOL://$OPENAM_SERVER:$OPENAM_SERVER_PORT/openam/oauth2/access_token"

curl --request POST --user "$CLIENT:$CLIENT_PASSWORD" --data $DATA $URL  | jq .


