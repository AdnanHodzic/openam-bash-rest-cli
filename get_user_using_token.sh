#!/bin/bash
#OpenAM shell REST client
#Retrieves user attributes for valid token

#pull in settings file
source settings

#check that token is passed as an argument
if [ "$1" = "" ]; then
	echo "Token missing!  Eg $0 AQIC5wM2LY4SfcxvdvHOXjtC_eWSs2RB54tgvgK8SuYi7aQ.*AAJTSQACMDE."
	exit
fi

#check that curl is present
CURL_LOC="$(which curl)"
if [ "$CURL_LOC" = "" ]; then
	echo "Curl not found.  Please install sudo apt-get install curl etc..."
	exit
fi

#build url
URL="$PROTOCOL://$OPENAM_SERVER:$OPENAM_SERVER_PORT/openam/identity/attributes?_prettyPrint=true"
DATA="subjectid=$1"

#call url
./posturl.sh $URL $DATA


