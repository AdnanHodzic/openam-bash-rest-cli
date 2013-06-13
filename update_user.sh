#!/bin/bash
#OpenAM shell REST client
#Updates user in either default or given realm

#pull in settings file
source settings

#check that uid is passed as an argument
if [ "$1" = "" ]; then
	echo ""
	echo "UID missing!"
	echo "Eg $0 jdoe @updates.json <optional_realm>"
	echo ""
	exit
fi

#check that data payload is passed as an argument
if [ "$2" = "" ]; then
	echo ""
	echo "JSON updates payload missing!"
	echo "Eg $0 jdoe @updates.json <optional_realm>"
	echo ""
	exit
fi

DATA=$2

#realm choice
if [ "$3" = "" ]; then

	URL="$PROTOCOL://$OPENAM_SERVER:$OPENAM_SERVER_PORT/openam/json/users/$1"

else

	URL="$PROTOCOL://$OPENAM_SERVER:$OPENAM_SERVER_PORT/openam/json/$3/users/$1"
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

if [ "$1" != "" ] && [ "$2" != "" ]; then

	#USER_AM_TOKEN from settings.
	echo ""	
	echo "Original User:"
	echo "-------------------------------------------------------------------------------------------------------------"
	echo ""
	./get_user_using_uid.sh $1 $3
	echo ""
	echo ""
	echo "Updated User:"
	echo "-------------------------------------------------------------------------------------------------------------"
	echo ""
	curl --request PUT --header "Content-Type: application/json" --header "iplanetDirectoryPro: $USER_AM_TOKEN" --data $DATA $URL | jq .

fi



