#!/bin/bash
#OpenAM shell REST client
#Updates agent in either default or given realm

#pull in settings file
source settings

#check that agent name is passed as an argument
if [ "$1" = "" ]; then
	echo ""
	echo "Agent name missing!"
	echo "Eg $0 myAgent @updates.json <optional_realm>"
	echo ""
	exit
fi

#check that data payload is passed as an argument
if [ "$2" = "" ]; then
	echo ""
	echo "JSON updates payload missing!"
	echo "Eg $0 myAgent @updates.json <optional_realm>"
	echo ""
	exit
fi

DATA=$2

#realm choice
if [ "$3" = "" ]; then

	URL="$PROTOCOL://$OPENAM_SERVER:$OPENAM_SERVER_PORT/openam/json/agents/$1?_prettyPrint=true"

else

	URL="$PROTOCOL://$OPENAM_SERVER:$OPENAM_SERVER_PORT/openam/json/$3/agents/$1?_prettyPrint=true"
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

if [ "$1" != "" ] && [ "$2" != "" ]; then

	echo ""	
	echo "Original Agent:"
	echo "-------------------------------------------------------------------------------------------------------------"
	echo ""
	./get_agent.sh $1 $3
	echo ""
	echo ""
	echo "Updated Agent:"
	echo "-------------------------------------------------------------------------------------------------------------"
	echo ""
	curl -k --request PUT --header "Content-Type: application/json" --header "iplanetDirectoryPro: $USER_AM_TOKEN" --data $DATA $URL
	echo ""
fi



