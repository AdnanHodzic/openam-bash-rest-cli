#!/bin/bash
#OpenAM shell REST client - based on v11 REST API
#Optional interactive front end for using the combined script list
#Simon Moffatt https://github.com/smof/openAM_shell_REST_client

#imports
source authn_menu.sh 
source user_menu.sh
source realm_menu.sh
source authz_menu.sh
source oauth2_menu.sh
source dash_menu.sh
source agent_menu.sh

#jq is used for some further json parsing
JQ_LOC="$(which jq)"
if [ "$JQ_LOC" = "" ]; then
	echo ""
	echo "JQ JSON parser not found.  Please install - http://stedolan.github.io/jq/download/"
	echo ""
	exit
fi


#main menu interface #################################################################################################################################################################################
function menu() { 
	
	clear
	echo "OpenAM v11 Shell REST Client - interactive mode"
	echo "----------------------------------------------------------------------------------"
	echo ""
	echo "1: Authentication"	
	echo "2: User Management"
	echo "3: Realm Management"
	echo "4: Agent Management"
	echo "5: Authorization"
	echo "6: OAuth2"
	echo "7: Dashboards"
	echo ""
	echo "X: Exit"
	echo "C: Configure OpenAM Server Settings"
	echo "----------------------------------------------------------------------------------"
	echo "Select an option:"
	read option

	case $option in

		1)
			authn_menu
			;;	

		2)
			user_menu
			;;

		3)
			realm_menu
			;;

		4)
			agent_menu
			;;

		5)
			authz_menu
			;;
	
		6)
			oauth2_menu
			;;

		7)
			dash_menu
			;;


		[x] | [X])
				clear	
				echo "Byeeeeeeeeeeeeeeeeeee :)"
				echo ""			
				exit
				;;
	
		[c] | [C])

			config
			;;

		*)

			menu
			;;
	esac

}
#main menu interface #################################################################################################################################################################################


#config settings #####################################################################################################################################################################################
function config() {

	clear
	chmod 600 settings
	nano settings
	chmod 400 settings
	menu
}
#config settings #####################################################################################################################################################################################


#initiate menu
menu
