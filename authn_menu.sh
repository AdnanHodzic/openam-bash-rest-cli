#!/bin/bash
#OpenAM shell REST client - based on v11 REST API
#Optional interactive front end for using the combined script list
#Simon Moffatt https://github.com/smof/openAM_shell_REST_client

#authn_menu module - run ./interactive.sh to access this

#authn_menu ##########################################################################################################################################################################################
function authn_menu() {

	clear
	echo "OpenAM v11 Shell REST Client - authentication menu"
	echo "----------------------------------------------------------------------------------"
	echo ""
	echo "1: Username & Password (top realm, default chain)"
	echo "2: Username & Password (any realm, any chain)"
	echo "3: Username & Password (any realm, any module)"
	echo "4: Logout"
	echo ""
	echo "5: Get Cookie Domains"
	echo ""
	echo "6: Check Current Token Validity"
	echo "7: Check Any Token Validity"
	echo ""
	echo "8: Get Token Attributes"
	echo ""
	echo "B: Back to main menu"
	echo "----------------------------------------------------------------------------------"
	echo "Select an option:"
	read option

	case $option in

		1)
			authn_user_pw_default
			;;


		2)

			authn_user_pw_any_realm_any_chain
			;;

		3)
			authn_user_pw_any_realm_any_module
			;;

		4)
			log_out
			;;

		5)

			get_cookie_domains
			;;


		6)
			check_current_token
			;;


		7)
			check_any_token
			;;

		8)
			get_token_attributes
			;;

		[b] | [B])
			
			menu
			;;
	
		*)

			authn_menu
			;;
	esac


}
#authn_menu ##########################################################################################################################################################################################

function get_token_attributes() {

	clear
	echo "Enter token to retrieve attributes for:"
	read token
	echo ""
	./get_user_using_token.sh $token
	echo ""
	read -p "Press [Enter] to return to menu"
	authn_menu

}


function check_any_token() {

	clear
	echo "Enter token value to check:"
	read token	
	echo ""
	echo "Is token valid?"
	echo ""
	./valid_token?.sh $token
	echo ""
	read -p "Press [Enter] to return to menu"
	authn_menu

}



function check_current_token() {

	clear
	
	#check to see if .key exists from ./interactive.sh mode
	if [ -e ".token" ]; then
		
		USER_AM_TOKEN=$(cat .token | cut -d "\"" -f 2) #remove start and end quotes	
		echo "The following token value was found:"
		echo ""
		echo "$USER_AM_TOKEN"
		echo ""
		echo "Current token valid?"
		echo ""
		./valid_token?.sh $USER_AM_TOKEN
	
	else

		echo "Token not found in .token file.  Use ./interactive.sh or ./authn_user_pw_default.sh to create"
			
	fi
	
	echo ""
	read -p "Press [Enter] to return to menu"
	authn_menu

}


function get_cookie_domains() {

	clear
	./get_cookie_domains.sh
	echo ""
	read -p "Press [Enter] to return to menu"
	authn_menu

}

function log_out() {

	clear
	./log_out.sh
	echo ""
	read -p "Press [Enter] to return to menu"
	authn_menu

}


#calls ./authn_user_pw_any_realm_any_module
function authn_user_pw_any_realm_any_module() {

	clear
	echo "Enter username:"
	read username
	echo "Enter Password:"
	read -s password
	echo ""
	echo "Enter Realm:"
	read realm
	echo "Enter Module:"
	read module
	echo ""
	./authn_user_pw_any_realm_any_module.sh $username $password $realm $module
	echo ""
	read -p "Press [Enter] to return to menu"
	authn_menu

}


#calls ./authn_user_pw_any_realm_any_chain
function authn_user_pw_any_realm_any_chain() {

	clear
	echo "Enter username:"
	read username
	echo "Enter Password:"
	read -s password
	echo ""
	echo "Enter Realm:"
	read realm
	echo "Enter Chain/Service:"
	read chain
	echo ""
	./authn_user_pw_any_realm_any_chain.sh $username $password $realm $chain
	echo ""
	read -p "Press [Enter] to return to menu"
	authn_menu

}


#calls ./authn_user_pw_default.sh
function authn_user_pw_default() {

	clear
	echo "Enter username:"
	read username
	echo "Enter Password:"
	read -s password

	./authn_user_pw_default.sh $username $password
	echo ""
	read -p "Press [Enter] to return to menu"
	authn_menu

}

######################################################################################################################################################################################################
echo ""
echo "Run ./interactive.sh to access this menu!"
echo ""
