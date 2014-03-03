#!/bin/bash
#OpenAM shell REST client
#Gets basic URL Policy Decision using previously saved token

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

URL_TO_CHECK=$(encode_url $1)


#check that curl is present
CURL_LOC="$(which curl)"
if [ "$CURL_LOC" = "" ]; then
	echo ""
	echo "Curl not found.  Please install sudo apt-get install curl etc..."
	echo ""
	exit
fi


#check to see if .key exists from ./interactive.sh mode
if [ -e ".token" ]; then
		
	USER_AM_TOKEN=$(cat .token | cut -d "\"" -f 2) #remove start and end quotes

else

	echo "Token not found in .token file.  Use ./interactive.sh or ./authn_user_pw_default.sh to create"
	exit
fi


#realm choice
if [ "$2" = "" ]; then

	URL="$PROTOCOL://$OPENAM_SERVER:$OPENAM_SERVER_PORT/openam/identity/authorize?subjectid=$USER_AM_TOKEN&uri=$URL_TO_CHECK"

else

	URL="$PROTOCOL://$OPENAM_SERVER:$OPENAM_SERVER_PORT/openam/identity/authorize?subjectid=$USER_AM_TOKEN&uri=$URL_TO_CHECK"
	
fi

echo ""
curl --request GET $URL
echo ""




