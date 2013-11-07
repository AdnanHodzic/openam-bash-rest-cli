#!/bin/bash
#OpenAM shell REST client
#Deletes OAuth2 access token.

#pull in settings file
source settings

URL="$PROTOCOL://$OPENAM_SERVER:$OPENAM_SERVER_PORT/openam/oauth2/token/$1?_prettyPrint=true"

#check that username is passed as an argument
if [ "$1" = "" ]; then
	echo ""
	echo "Token missing!  Eg $0 f9063e26-3a29-41ec-86de-1d0d68aa85e9"
	echo ""
	exit
fi

./delete_url.sh $URL
