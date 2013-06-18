#!/bin/bash
#OpenAM shell REST client
#Optional interactive front end for using the combined script list

#read version - currently the commit count on the github branch
VERSION=$(cat VERSION)

#check that jq is installed
JQ_LOC=$(which jq)
if [ $JQ_LOC = "" ]; then
	
	echo "JQ not found!  Please download from http://stedolan.github.io/jq/"
	exit
fi

#main menu interface
function menu() { 
	
	clear
	echo "OpenAM Shell REST Client - interactive mode [ver:$VERSION]"
	echo "-----------------------------------------------------"
	echo ""
	echo "1:  Get Authentication Token (token saved for future session use)"
	echo "2:  Check current token is valid"
	echo "3:  Create User"		
	echo "4:  Delete User"
	echo "5:  Update User"	
	echo "6:  Read User"
	echo "7:  Create Realm"
	echo "8:  Read Realm"
	echo "9:  Delete Realm"
	echo "10: Get Dashboard Applications Assigned"
	echo "11: Get Dashboard Applications Available"
	echo "12: Get Dashboard Applications Defined"
	echo "X:  Exit"
	echo ""
	echo "-----------------------------------------------------"
	echo "Select an option:"
	read option

	case $option in

		1)
			auth_username_password
			;;	

		2)
			check_token
			;;

		3)
			create_user
			;;

		4)
			delete_user
			;;
	
		5)
			update_user
			;;

		6)
			get_user_using_uid
			;;

		7)
			create_realm
			;;

		8)
			get_realm
			;;
	
		9)
			delete_realm
			;;
		
		10)
			get_dashboard_applications_assigned
			;;

		11)
			get_dashboard_applications_available
			;;

		12)
			get_dashboard_applications_defined
			;;

		[x] | [X])
				clear	
				echo "Byeeeeeeeeeeeeeeeeeee :)"
				echo ""			
				exit
				;;
		*)

			menu
			;;
	esac

}

#calls get_dashboard_applications_defined.sh
function get_dashboard_applications_defined() {

	clear
	./get_dashboard_applications_defined.sh
	echo ""
	read -p "Press [Enter] to return to menu"
	menu

}


#calls get_dashboard_applications_available.sh
function get_dashboard_applications_available() {

	clear
	./get_dashboard_applications_available.sh
	echo ""
	read -p "Press [Enter] to return to menu"
	menu

}

#calls get_dashboard_applications_assigned.sh
function get_dashboard_applications_assigned() {

	clear
	./get_dashboard_applications_assigned.sh
	echo ""
	read -p "Press [Enter] to return to menu"
	menu

}

#calls get_user_using_uid.sh
function get_user_using_uid() {

	clear
	echo "Enter uid of user to read: Eg jdoe"
	read uid
	echo ""
	./get_user_using_uid.sh $uid
	echo ""
	read -p "Press [Enter] to return to menu"
	menu

}


#calls get_realm.sh
function get_realm() {

	clear
	echo "Enter the name of the realm to read: Eg myRealm"
	read realm
	echo ""
	./get_realm.sh $realm
	echo ""
	read -p "Press [Enter] to return to menu"
	menu

}


#calls delete_realm.sh
function delete_realm() {

	clear
	echo "Enter the name of the realm to delete: Eg myRealm"
	read realm
	echo ""
	./delete_realm.sh $realm

	echo ""
	read -p "Press [Enter] to return to menu"
	menu

}

#calls create_realm.sh
function create_realm() {

	clear
	echo "Enter path to JSON payload for realm creation: Eg myRealm.json"
	read realm_payload
	echo ""

	#check file exists
	if [ -e "$realm_payload" ]; then
		
		realm_payload="@$realm_payload"	
		./create_realm.sh $realm_payload
			
	else

		echo "Payload JSON file $realm_payload not found!"
	
	fi
	
	echo ""
	read -p "Press [Enter] to return to menu"
	menu


}

#calls update_user.sh
function update_user() {

	clear
	echo "Enter userid of user to update: Eg jdoe"
	read userid
	echo ""
	echo "Enter JSON payload file with values to update: Eg updates.json"
	read updates_payload
	echo ""
	echo "Enter optional realm that user belongs to: Eg myRealm"
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
	menu

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
	menu

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



#calls ./authenticate_username_password.sh
function auth_username_password() {

	clear
	echo "Enter OpenAM username:"
	read username
	echo ""
	echo "Enter Password:"
	read -s password
	echo ""
	./authenticate_username_password.sh $username $password
	echo ""
	read -p "Press [Enter] to return to menu"
	menu

}


#calls ./create_user.sh
function create_user() {

	clear
	echo "Enter path to JSON payload file for user creation: Eg. user.json"
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

	fi

	echo ""
	read -p "Press [Enter] to return to menu"
	menu
	
}

#initiate menu
menu
