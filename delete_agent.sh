#!/bin/bash
#OpenAM shell REST client
#Deletes agent in either default or given realm

#pull in settings file
source settings

#check that name is passed as an argument
if [ "$1" = "" ]; then
	echo ""
	echo "Agent name missing!"
	echo "Eg $0 myAgent <optional_realm>"
	echo ""
	exit
fi

#realm choice
if [ "$2" = "" ]; then

	URL="$PROTOCOL://$OPENAM_SERVER:$OPENAM_SERVER_PORT/openam/json/agents/$1?_prettyPrint=true"

else

	URL="$PROTOCOL://$OPENAM_SERVER:$OPENAM_SERVER_PORT/openam/json/$2/agents/$1?_prettyPrint=true"
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

	echo "Token file not found.  Create using ./authn_user_pw_default.sh or use ./interactive.sh mode"
	exit
fi

echo ""
curl -k --request DELETE --header "iplanetDirectoryPro: $USER_AM_TOKEN" $URL
echo ""
