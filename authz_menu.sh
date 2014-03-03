#!/bin/bash
#OpenAM shell REST client - based on v11 REST API
#Optional interactive front end for using the combined script list
#Simon Moffatt https://github.com/smof/openAM_shell_REST_client

#authz_menu module - run ./interactive.sh to access this

#authz_menu ##########################################################################################################################################################################################
function authz_menu() {

	clear
	echo "OpenAM v11 Shell REST Client - authorization menu"
	echo "----------------------------------------------------------------------------------"
	echo ""
	echo "1: Get URL Policy Decision (currently authenticated user)"
	echo "2: Get URL Policy Decision (any authenticated user)"
	echo ""
	echo "B: Back to main menu"
	echo "----------------------------------------------------------------------------------"
	echo "Select an option:"
	read option

	case $option in

		1)
			get_policy_decision_current_user
			;;
			
		2)
			get_policy_decision_any_user
			;;

		[b] | [B])
			
			menu
			;;
	
		*)

			authz_menu
			;;
	esac


}
#authz_menu ##########################################################################################################################################################################################

function get_policy_decision_current_user() {
	
	clear
	echo "URL to be checked (Eg http://app.example.com:8080/myApp/secret.html):"
	read url
	echo ""
	./get_policy_decision_current_user.sh "$url"
	echo ""
	read -p "Press [Enter] to return to menu"
	authz_menu

	
}


function get_policy_decision_any_user() {
	
	clear
	echo "URL to be checked (Eg http://app.example.com:8080/myApp/secret.html):"
	read url
	echo ""
	echo "Enter TokenId to check against:"
	read token
	echo ""
	./get_policy_decision_any_user.sh "$url" $token
	echo ""
	read -p "Press [Enter] to return to menu"
	authz_menu

	
}



###########################################################################################################################################################################################################
echo ""
echo "Run ./interactive.sh to access this menu!"
echo ""
