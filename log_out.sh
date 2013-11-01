#!/bin/bash
#OpenAM shell REST client
#Logs user out

#pull in settings file
source settings

#check that curl is present
CURL_LOC="$(which curl)"
if [[ "$CURL_LOC" = "" ]]; then
	echo ""
	echo "Curl not found.  Please install sudo apt-get install curl etc..."
	echo ""
	exit
fi

#create url
URL="$PROTOCOL://$OPENAM_SERVER:$OPENAM_SERVER_PORT/openam/json/sessions/?_action=logout&_prettyPrint=true"	

#check to see if .key exists from ./interactive.sh mode
if [ -e ".token" ]; then
		
	USER_AM_TOKEN=$(cat .token | cut -d "\"" -f 2) #remove start and end quotes

else

	echo "Token not found in .token file.  Use ./interactive.sh or ./authn_user_pw_default"
	exit
fi

#call url
echo ""
curl -k --request POST --header "iplanetDirectoryPro: $USER_AM_TOKEN" $URL 

#remove token file
rm -f .token
echo ""
echo ""
echo "Local .token storage file also removed"

