#!/bin/bash
#OpenAM shell REST client
#Gets singe user in either default or given realm

#pull in settings file
source settings

#check that token of user with create entitlements is passed as an argument
if [ "$1" = "" ]; then
	echo ""	
	echo "Token missing!  Requires token of user with create rights"
	echo "Eg $0 AQIC5w...2NzEz* jdoe <optional_realm>"
	echo ""
	exit
fi

#check that data payload is passed as an argument
if [ "$2" = "" ]; then
	echo ""
	echo "UID missing!"
	echo "Eg $0 AQIC5w...2NzEz* jdoe <optional_realm>"
	echo ""
	exit
fi

DATA=$2

#realm choice
if [ "$3" = "" ]; then

	URL="$PROTOCOL://$OPENAM_SERVER:$OPENAM_SERVER_PORT/openam/json/users/$2"

else

	URL="$PROTOCOL://$OPENAM_SERVER:$OPENAM_SERVER_PORT/openam/json/$3/users/$2"
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

curl --request GET --header "iplanetDirectoryPro: $1" $URL | jq .



