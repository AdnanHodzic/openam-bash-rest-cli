#!/bin/bash
#OpenAM shell REST client
#Retrieves new access token from refresh token

#pull in settings file
source settings

#pull in url_encoder
source url_encoder.sh

#check that client ID is passed as an argument
if [ "$1" = "" ]; then
	echo ""
	echo "Client ID missing!  Eg $0 clientID clientPW scope refreshToken optionalRealm"
	echo ""
	exit
fi

#check that client password is passed as an argument
if [ "$2" = "" ]; then
	echo ""
	echo "Client PW missing!  Eg $0 clientID clientPW scope refreshToken optionalRealm"
	echo ""
	exit
fi

#check that scope as an argument
if [ "$3" = "" ]; then
	echo ""
	echo "Scope missing!  Eg $0 clientID clientPW scope refreshToken optionalRealm"
	echo ""
	exit
fi

#check that refresh token is passed as an argument
if [ "$4" = "" ]; then
	echo ""
	echo "Refresh token missing!  Eg $0 clientID clientPW scope refreshToken optionalRealm"
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


CLIENT=$1
CLIENT_PASSWORD=$2
SCOPE=$3
REFRESH_TOKEN=$4
REALM=$5

DATA="grant_type=refresh_token&refresh_token=$REFRESH_TOKEN&scope=$SCOPE"

URL="$PROTOCOL://$OPENAM_SERVER:$OPENAM_SERVER_PORT/openam/oauth2/access_token?_prettyPrint=true"

#check if realm was passed in to alter url
if [ "$5" != "" ]; then
	
	URL="$URL&realm=$5"
fi

echo ""
curl -k --request POST --user "$CLIENT:$CLIENT_PASSWORD" --data $DATA $URL | jq .
echo ""

