#!/bin/bash
#OpenAM shell REST client - based on v11 REST API
#Optional interactive front end for using the combined script list
#Simon Moffatt https://github.com/smof/openAM_shell_REST_client

#oauth2_menu module - run ./interactive.sh to access this

#oauth2_menu ##########################################################################################################################################################################################
function oauth2_menu() {

	clear
	echo "OpenAM v11 Shell REST Client - OAUTH2 menu"
	echo "----------------------------------------------------------------------------------"
	echo ""
	echo "1: Get Access Token - password grant"
	echo "2: Get Stored Access Token Details"
	echo "3: Refresh Stored Access Token"
	echo ""
	echo "B: Back to main menu"
	echo "----------------------------------------------------------------------------------"
	echo "Select an option:"
	read option

	case $option in

		1)
			oauth2_get_access_token_pw_grant
			;;
		
		2)
			oauth2_get_stored_token_details
			;;			
		
		3)

			oauth2_refresh_stored_access_token
			;;

		[b] | [B])
			
			menu
			;;
	
		*)

			oauth2_menu
			;;
	esac


}
#oauth2_menu ##########################################################################################################################################################################################


function oauth2_refresh_stored_access_token() {

	clear

	#check if .oauth2_refresh_token file exists
	if [ -e ".oauth2_refresh_token" ]; then

		refresh_token=$(cat .oauth2_refresh_token | cut -d "\"" -f 2)
		echo "Enter OAuth2 client ID:"
		read client
		echo ""
		echo "Enter Oauth2 client password:"
		read -s client_pw
		echo ""
		echo "Enter scope:"
		read scope
		echo ""
		echo "Enter optional realm (leave blank for top level realm):"
		read realm
		echo ""

		#call url and store response
		RESPONSE=$(./oauth2_refresh_access_token.sh $client $client_pw $scope $refresh_token $realm)
		ACCESS_TOKEN=$(echo $RESPONSE | jq '.access_token')		

		#print response
		echo ""
		echo $RESPONSE |  jq .
		echo ""

		#store new refresh token in hidden file
		rm -rf .oauth2_access_token

		if [ "$ACCESS_TOKEN" != "null" ] ; then

		 	echo $ACCESS_TOKEN > .oauth2_access_token
			echo "Access Token stored in .oauth2_refresh_token"
			chmod 400 .oauth2_access_token
		fi
	else
		echo ""
		echo ".oauth2_refresh_token file not found!"	
	
	fi

	echo ""
	read -p "Press [Enter] to return to menu"
	oauth2_menu
}



function oauth2_delete_access_token() {

	clear
	echo "Enter OAuth2 Access Token to Delete:"
	read oauth2_token
	echo ""	
	./oauth2_delete_access_token.sh $oauth2_token
	echo ""
	read -p "Press [Enter] to return to menu"
	oauth2_menu

}



#calls oauth2_get_access_token_pw_grant
function oauth2_get_access_token_pw_grant() {

	clear

	#get user input
	echo "Enter Realm (leave blank for top level realm):"
	read realm
	echo ""
	echo "Enter username:"
	read username
	echo ""
	echo "Enter user password:"
	read -s password
	echo ""
	echo ""
	echo "Enter OAuth2 client ID:"
	read client_id
	echo ""
	echo "Enter OAuth2 client Password:"
	read -s client_password
	echo ""
	echo "Enter scope:"
	read scope
	echo ""

	#call url and store response
	RESPONSE=$(./oauth2_get_access_token_pw_grant.sh $username $password $client_id $client_password $scope $realm)
	ACCESS_TOKEN=$(echo $RESPONSE | jq '.access_token')
	REFRESH_TOKEN=$(echo $RESPONSE | jq '.refresh_token')
	SCOPE=$(echo $RESPONSE | jq '.scope')

	#print response to screen	
	echo ""
	echo $RESPONSE |  jq .
	echo ""

	#store response values in hidden files if they exist in response
	rm -rf .oauth2_access_token .oauth2_refresh_token .oauth2_scope

	if [ "$ACCESS_TOKEN" != "null" ] ; then 
	
	echo $ACCESS_TOKEN > .oauth2_access_token
	chmod 400 .oauth2_access_token
	echo "Access Token stored in .oauth2_access_token"

	fi

	if [ "$REFRESH_TOKEN" != "null" ] ; then

	 	echo $REFRESH_TOKEN > .oauth2_refresh_token
		echo "Refresh Token stored in .oauth2_refresh_token"
		chmod 400 .oauth2_refresh_token

	fi

	if [ "$SCOPE" != "null" ] ; then

		echo $SCOPE > .oauth2_scope
		echo "Scope stored in .oauth2_scope"
		chmod 400 .oauth2_scope
	fi

	echo ""
	read -p "Press [Enter] to return to menu"
	oauth2_menu

}


#calls oauth2_get_token_details
function oauth2_get_stored_token_details() {

	clear
	if [ -e .oauth2_access_token ]; then
		
		#pull in access token from hidden file and remove " quotes add start and end
		ACCESS_TOKEN=$(cat .oauth2_access_token | cut -d "\"" -f 2)
		echo ""
		./oauth2_get_token_details.sh $ACCESS_TOKEN
	
	else

		echo ""
		echo ".oauth2_access_token file not found!"
	fi
	
	echo ""
	read -p "Press [Enter] to return to menu"
	oauth2_menu	
	
}

###########################################################################################################################################################################################################
echo ""
echo "Run ./interactive.sh to access this menu!"
echo ""
