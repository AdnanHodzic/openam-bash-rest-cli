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
	echo "2: Get Token Details"
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
			oauth2_get_token_details
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

#calls oauth2_get_access_token_pw_grant
function oauth2_get_access_token_pw_grant() {

	clear
	#clear down previous token files
	rm -f .oauth2_access_token
	rm -f .oauth2_refresh_token
	rm -f .oauth2_response.json

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

	./oauth2_get_access_token_pw_grant.sh $username $password $client_id $client_password $scope $realm

	echo ""
	read -p "Press [Enter] to return to menu"
	oauth2_menu

}


#calls oauth2_get_token_details
function oauth2_get_token_details() {

	clear
	echo "Enter OAUTH2 access token to get details for:"
	read access_token
	echo ""
	./oauth2_get_token_details.sh $access_token
	
	echo ""
	read -p "Press [Enter] to return to menu"
	oauth2_menu	
	
}

###########################################################################################################################################################################################################
echo ""
echo "Run ./interactive.sh to access this menu!"
echo ""
