#!/bin/bash
#OpenAM shell REST client - based on v11 REST API
#Optional interactive front end for using the combined script list
#Simon Moffatt https://github.com/smof/openAM_shell_REST_client

#dash_menu module - run ./interactive.sh to access this

#dash_menu ##########################################################################################################################################################################################
function dash_menu() {

	clear
	echo "OpenAM v11 Shell REST Client - dashboard menu"
	echo "----------------------------------------------------------------------------------"
	echo ""
	echo "1: Get Dashboard Applications Defined"
	echo "2: Get Dashboard Applications Available"
	echo "3: Get Dashboard Applications Assigned"
	echo ""
	echo "B: Back to main menu"
	echo "----------------------------------------------------------------------------------"
	echo "Select an option:"
	read option

	case $option in

		1)
			get_dashboard_applications_defined
			;;
		
		2)
			get_dashboard_applications_available
			;;
	
		3)
			get_dashboard_applications_assigned
			;;
		

		[b] | [B])
			
			menu
			;;
	
		*)

			dash_menu
			;;
	esac


}
#dash_menu ##########################################################################################################################################################################################

#calls get_dashboard_applications_defined.sh
function get_dashboard_applications_defined() {

	clear
	./get_dashboard_applications_defined.sh
	echo ""
	read -p "Press [Enter] to return to menu"
	dash_menu

}


#calls get_dashboard_applications_available.sh
function get_dashboard_applications_available() {

	clear
	./get_dashboard_applications_available.sh
	echo ""
	read -p "Press [Enter] to return to menu"
	dash_menu

}

#calls get_dashboard_applications_assigned.sh
function get_dashboard_applications_assigned() {

	clear
	./get_dashboard_applications_assigned.sh
	echo ""
	read -p "Press [Enter] to return to menu"
	dash_menu

}


###########################################################################################################################################################################################################
echo ""
echo "Run ./interactive.sh to access this menu!"
echo ""
