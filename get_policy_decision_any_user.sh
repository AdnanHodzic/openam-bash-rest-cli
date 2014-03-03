#!/bin/bash
#OpenAM shell REST client
#Gets basic URL Policy Decision using any provided token

#pull in settings file
source settings
source url_encoder.sh


#check that uid is passed as an argument
if [ "$1" = "" ]; then
	echo ""
	echo "URL missing!"
	echo "Eg $0 http://app.example.com:8080/myApp/secret.html <optional_realm>"
	echo ""
	exit
fi

if [ "$2" = "" ]; then
	echo ""
	echo "Token missing!"
	echo "Eg $0 http://app.example.com:8080/myApp/secret.html TokenId"
	echo ""
	exit
fi

URL_TO_CHECK=$(encode_url $1)
USER_AM_TOKEN=$2

#check that curl is present
CURL_LOC="$(which curl)"
if [ "$CURL_LOC" = "" ]; then
	echo ""
	echo "Curl not found.  Please install sudo apt-get install curl etc..."
	echo ""
	exit
fi

#Set URL
URL="$PROTOCOL://$OPENAM_SERVER:$OPENAM_SERVER_PORT/openam/identity/authorize?subjectid=$USER_AM_TOKEN&uri=$URL_TO_CHECK"

echo ""
curl --request GET $URL
echo ""




