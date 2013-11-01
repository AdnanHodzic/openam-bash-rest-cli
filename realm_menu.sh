#!/bin/bash
#OpenAM shell REST client - based on v11 REST API
#Optional interactive front end for using the combined script list
#Simon Moffatt https://github.com/smof/openAM_shell_REST_client

#realm_menu module - run ./interactive.sh to access this

#user_menu ##########################################################################################################################################################################################
function realm_menu() {

	clear
	echo "OpenAM v11 Shell REST Client - realm menu"
	echo "----------------------------------------------------------------------------------"
	echo ""
	echo "1: Get Realm"
	echo "2: Create Realm"
	echo "3: Delete Realm"
	echo "4: Update Realm"
	echo ""
	echo "B: Back to main menu"
	echo "----------------------------------------------------------------------------------"
	echo "Select an option:"
	read option

	case $option in

		1)

			get_realm
			;;

		2)

			create_realm
			;;
	
		3)
			delete_realm
			;;

		4)
			update_realm	
			;;

		[b] | [B])
			
			menu
			;;
	
		*)

			realm_menu
			;;
	esac


}
#realm_menu ##########################################################################################################################################################################################

function update_realm() {

	clear
	echo "Enter realm name to update:"
	read realm
	echo ""
	echo "The following JSON payloads exist in this directory:"
	echo ""
	ls *.json
	echo ""
	echo "Enter filename that contains updates:"
	read json_payload
	./update_realm.sh $realm "@$json_payload"
	read -p "Press [Enter] to return to menu"
	realm_menu

}


function delete_realm() {

	clear
	echo "Enter realm name to delete:"
	read realm
	echo ""
	./delete_realm.sh $realm
	read -p "Press [Enter] to return to menu"
	realm_menu


}

function create_realm() {

	clear
	echo "The following JSON payloads exist in this directory:"
	echo ""
	ls *.json
	echo ""
	echo "Enter filename:"
	read json_payload
	echo ""
	./create_realm.sh "@$json_payload"
	read -p "Press [Enter] to return to menu"
	realm_menu

}


function get_realm() {

	clear
	echo "Enter realm name:"
	read realm
	echo ""
	./get_realm.sh $realm
	read -p "Press [Enter] to return to menu"
	realm_menu

}


###########################################################################################################################################################################################################
echo ""
echo "Run ./interactive.sh to access this menu!"
echo ""
