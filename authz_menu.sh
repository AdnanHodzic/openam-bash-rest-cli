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
	echo "To be implemented..."
	echo ""
	echo "B: Back to main menu"
	echo "----------------------------------------------------------------------------------"
	echo "Select an option:"
	read option

	case $option in


		[b] | [B])
			
			menu
			;;
	
		*)

			authz_menu
			;;
	esac


}
#authz_menu ##########################################################################################################################################################################################


###########################################################################################################################################################################################################
echo ""
echo "Run ./interactive.sh to access this menu!"
echo ""
