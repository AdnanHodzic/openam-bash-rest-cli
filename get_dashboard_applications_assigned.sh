#!/bin/bash
#OpenAM shell REST client
#Retrieves dashboard applications assigned to user

#pull in settings file
source settings

URL="$PROTOCOL://$OPENAM_SERVER:$OPENAM_SERVER_PORT/openam/json/dashboard/assigned"


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

#USER_AM_TOKEN set in settings
curl --header "iplanetDirectoryPro: $USER_AM_TOKEN" $URL | jq .



