#!/bin/bash
#OpenAM shell REST client - based on v11 REST API
#Optional interactive front end for using the combined script list
#Simon Moffatt https://github.com/smof/openAM_shell_REST_client

#user_menu module - run ./interactive.sh to access this

#user_menu ##########################################################################################################################################################################################
function user_menu() {

	clear
	echo "OpenAM v11 Shell REST Client - user menu"
	echo "----------------------------------------------------------------------------------"
	echo ""
	echo "1: Get user by UID"
	echo "2: Create User"
	echo "3: Delete User"
	echo "4: Update User"
	echo ""
	echo "B: Back to main menu"
	echo "----------------------------------------------------------------------------------"
	echo "Select an option:"
	read option

	case $option in

		1)
			get_user_using_uid
			;;
		
		2)
			create_user
			;;
	
		3)
			delete_user
			;;

		4)
			update_user
			;;
		

		[b] | [B])
			
			menu
			;;
	
		*)

			user_menu
			;;
	esac


}
#user_menu ##########################################################################################################################################################################################

#calls get_user_using_uid.sh
function get_user_using_uid() {

	clear
	echo "Enter uid of user to read: Eg jdoe"
	read uid
	echo ""
	echo "Enter optional realm of user (leave blank for top level realm):"
	read realm
	echo ""
	./get_user_using_uid.sh $uid $realm
	echo ""
	read -p "Press [Enter] to return to menu"
	user_menu

}



#calls update_user.sh
function update_user() {

	clear
	echo "Enter userid of user to update: Eg jdoe"
	read userid
	echo ""
	echo "The following JSON files exist in this directory:"
	echo ""
	ls *.json
	echo ""
	echo "Enter filename with values to update: Eg updates.json"
	read updates_payload
	echo ""
	echo "Enter optional realm that user belongs to: Eg myRealm (leave blank for top level realm)"
	read realm

	#check that updates file exists
	if [ -e "$updates_payload" ]; then
	
		updates_payload="@$updates_payload"
		./update_user.sh $userid $updates_payload $realm
		
	else
		echo ""
		echo "Updates JSON file $updates_payload not found!"
		
	fi

	echo ""
	read -p "Press [Enter] to return to menu"
	user_menu

}

#calls delete_user.sh
function delete_user() {

	clear
	echo "Enter username of user to delete: Eg jdoe"
	read username
	echo ""
	echo "Enter optional realm. Eg myRealm"
	read realm
	./delete_user.sh $username $realm
	echo ""
	read -p "Press [Enter] to return to menu"
	user_menu

}

#calls ./valid_token?.sh
function check_token() {
	
	clear
	#check that token file exists
	if [ -e ".token" ]; then
	
		TOKEN=$(cat .token | cut -d "\"" -f 2) #remove start and end quotes
		VALID=$(./valid_token?.sh $TOKEN | jq '.boolean') #call shell client for validating token
		echo ""
		echo "Current token in .token file is valid?: $VALID"
		echo ""
		read -p "Press [Enter] to return to menu"
		menu

	else
		echo ".token file not found!"
		echo "Authenticate with username and password to create"
		echo ""
		read -p "Press [Enter] to return to menu"
		menu
	fi

}





#calls ./create_user.sh
function create_user() {

	clear
	echo "The following JSON payloads exist in this directory:"
	echo ""
	ls *.json
	echo ""
	echo "Enter filename for create user payload. Eg. user.json"
	read create_user_payload
	echo ""
	echo "Enter optional realm to create user: Eg. myRealm"
	read realm

	#check that payload file actually exists
	if [ -e "$create_user_payload" ]; then

		create_user_payload="@$create_user_payload"
		./create_user.sh $create_user_payload $realm		

	else

		echo "File not found: $create_user_payload"
		echo ""
		read -p "Press [Enter] to return to menu"
		user_menu

	fi

	echo ""
	read -p "Press [Enter] to return to menu"
	user_menu
	
}


###########################################################################################################################################################################################################
echo ""
echo "Run ./interactive.sh to access this menu!"
echo ""
