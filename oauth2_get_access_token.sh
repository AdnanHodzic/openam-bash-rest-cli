#!/bin/bash
#OpenAM shell REST client
#Authenticates user against OAuth2 IdP and returns access/refresh token

#pull in settings file
source settings

#pull in url_encoder
source url_encoder.sh

URL="$PROTOCOL://$OPENAM_SERVER:$OPENAM_SERVER_PORT/openam/oauth2/access_token"
DATA="grant_type=password&username=$1&password=$2&scope=cn$20mail"

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

#check that jq util is present
JQ_LOC="$(which jq)"
if [ "$JQ_LOC" = "" ]; then
 	echo "JSON parser jq not found.  Download from http://stedolan.github.com/jq/download/"
  	exit
fi

curl --request POST --user "$1:$2" --data $DATA $URL  | jq .

