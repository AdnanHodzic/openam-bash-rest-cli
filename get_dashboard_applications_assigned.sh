#!/bin/bash
#OpenAM shell REST client
#Retrieves dashboard applications assigned to user
#Add the user's OpenAM token in the settings file that you wish to query.  Retrieve the token using ./authentiate_username_password.sh

#pull in settings file
source settings

URL="$PROTOCOL://$OPENAM_SERVER:$OPENAM_SERVER_PORT/openam/json/dashboard/assigned?_prettyPrint=true"


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

#USER_AM_TOKEN set in settings
curl -k --header "iplanetDirectoryPro: $USER_AM_TOKEN" $URL



