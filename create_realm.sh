#!/bin/bash
#OpenAM shell REST client
#Creates new realm based on JSON payload attributes

#pull in settings file
source settings

#check that data payload is passed as an argument
if [ "$1" = "" ]; then
	echo ""
	echo "Data payload missing!"
	echo "Eg $0 @realm.json"
	echo ""
	exit
fi

DATA=$1
URL="$PROTOCOL://$OPENAM_SERVER:$OPENAM_SERVER_PORT/openam/json/realms/?_action=create"


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

#check to see if .key exists from ./interactive.sh mode
if [ -e ".token" ]; then
		
	USER_AM_TOKEN=$(cat .token | cut -d "\"" -f 2) #remove start and end quotes

else

	echo "Token file not found.  Create using ./authenticate_username_password.sh or use ./interactive.sh mode"
	exit
fi

curl --request POST --header "Content-Type: application/json" --header "iplanetDirectoryPro: $USER_AM_TOKEN" --data $DATA $URL | jq .



