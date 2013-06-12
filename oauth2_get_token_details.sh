#!/bin/bash
#OpenAM shell REST client
#Returns OAuth2 access token details.  Takes token as argument

#pull in settings file
source settings

URL="$PROTOCOL://$OPENAM_SERVER:$OPENAM_SERVER_PORT/openam/oauth2/tokeninfo?access_token=$1"

#check that username is passed as an argument
if [ "$1" = "" ]; then
	echo "Token missing!  Eg $0 f9063e26-3a29-41ec-86de-1d0d68aa85e9"
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

./geturl.sh $URL | jq .

