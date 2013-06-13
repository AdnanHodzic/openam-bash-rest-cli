#!/bin/bash
#OpenAM shell REST client
#Updates existing realm based on JSON payload attributes

#pull in settings file
source settings

#check that realm name is passed as an argument
if [ "$2" = "" ]; then
	echo ""
	echo "Realm name missing!"
	echo "Eg $0 myRealm @realm_updates.json"
	echo ""
	exit
fi

#check that data payload is passed as an argument
if [ "$2" = "" ]; then
	echo ""
	echo "Data payload missing!"
	echo "Eg $0 myRealm @realm_updates.json"
	echo ""
	exit
fi

DATA=$2
URL="$PROTOCOL://$OPENAM_SERVER:$OPENAM_SERVER_PORT/openam/json/realms/$1"


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


echo ""
echo "Original configuration for realm: $1"
echo "-----------------------------------------------------------------------------------"
./get_realm.sh $1
echo ""
echo "Updatead configuration realm: $1"
echo "-----------------------------------------------------------------------------------"
echo ""
#ADMIN_TOKEN set in settings
curl --request PUT --header "Content-Type: application/json" --header "iplanetDirectoryPro: $USER_AM_TOKEN" --data $DATA $URL | jq .



