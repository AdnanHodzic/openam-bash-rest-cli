#!/bin/bash
#OpenAM shell REST client
#Gets singe user in either default or given realm

#pull in settings file
source settings

#check that uid is passed as an argument
if [ "$1" = "" ]; then
	echo ""
	echo "UID missing!"
	echo "Eg $0 jdoe <optional_realm>"
	echo ""
	echo "Also add admin authN token in settings"
	exit
fi

#realm choice
if [ "$2" = "" ]; then

	URL="$PROTOCOL://$OPENAM_SERVER:$OPENAM_SERVER_PORT/openam/json/users/$1"

else

	URL="$PROTOCOL://$OPENAM_SERVER:$OPENAM_SERVER_PORT/openam/json/$2/users/$1"
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

#ADMIN_TOKEN is set in settings
curl --request GET --header "iplanetDirectoryPro: $ADMIN_TOKEN" $URL | jq .



