#!/bin/bash
#OpenAM shell REST client
#Get agents in either default or given realm

#pull in settings file
source settings

#realm choice
if [ "$1" = "" ]; then

	URL="$PROTOCOL://$OPENAM_SERVER:$OPENAM_SERVER_PORT/openam/json/agents/?_queryID=*&_prettyPrint=true"

else

	URL="$PROTOCOL://$OPENAM_SERVER:$OPENAM_SERVER_PORT/openam/json/$1/agents/?_queryID=*&_prettyPrint=true"
fi

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

	echo "Token not found in .token file.  Use ./interactive.sh or ./authn_user_pw_default to create"
	exit
fi

echo ""
curl -k --request GET --header "iplanetDirectoryPro: $USER_AM_TOKEN" $URL
echo ""




