#!/bin/bash
#OpenAM shell REST client - based on v11 REST API
#Optional interactive front end for using the combined script list
#Simon Moffatt https://github.com/smof/openAM_shell_REST_client

#agemt_menu module - run ./interactive.sh to access this

#user_menu ##########################################################################################################################################################################################
function agent_menu() {

	clear
	echo "OpenAM v11 Shell REST Client - agent menu"
	echo "----------------------------------------------------------------------------------"
	echo ""
	echo "0: Get Agents"
	echo "1: Get Agent"
	echo "2: Create Agent"
	echo "3: Delete Agent"
	echo "4: Update Agent"
	echo ""
	echo "B: Back to main menu"
	echo "----------------------------------------------------------------------------------"
	echo "Select an option:"
	read option

	case $option in

		0)
			get_agents
			;;

		1)
			get_agent
			;;
		
		2)
			create_agent
			;;
	
		3)
			delete_agent
			;;

		4)
			update_agent
			;;
		

		[b] | [B])
			
			menu
			;;
	
		*)

			agent_menu
			;;
	esac


}
#user_menu ##########################################################################################################################################################################################

#calls get_agents.sh
function get_agents() {

	clear
	echo "Enter optional realm for agent search (leave blank for top level realm):"
	read realm
	./get_agents.sh $realm | jq '.result'
	echo ""
	read -p "Press [Enter] to return to menu"
	agent_menu


}


#calls get_agent.sh
function get_agent() {

	clear
	echo "Enter realm where agent resides (leave blank for top level realm):"
	read realm
	echo ""
	echo "The following agents exist in this realm:"
	echo ""
	./get_agents.sh $realm | jq '.result'
	echo ""
	echo "Enter name of agent to get details on:"
	read agent
	echo ""
	./get_agent.sh $agent $realm
	echo ""
	read -p "Press [Enter] to return to menu"
	agent_menu

}



#calls update_agent.sh
function update_agent() {

	clear
	echo "Enter name of agent to update:"
	read agent
	echo ""
	echo "The following JSON files exist in this directory:"
	echo ""
	ls *.json
	echo ""
	echo "Enter filename with values to update: Eg updates.json"
	read updates_payload
	echo ""
	echo "Enter optional realm that agent belongs to: Eg myRealm (leave blank for top level realm)"
	read realm

	#check that updates file exists
	if [ -e "$updates_payload" ]; then
	
		updates_payload="@$updates_payload"
		./update_agent.sh $agent $updates_payload $realm
		
	else
		echo ""
		echo "Updates JSON file $updates_payload not found!"
		
	fi

	echo ""
	read -p "Press [Enter] to return to menu"
	agent_menu

}

#calls delete_agent.sh
function delete_agent() {

	clear
	echo "Enter name of realm where agent resides (leave blank for top level realm):"
	read realm
	echo ""
	echo "The following agents exist in this realm:"
	echo ""
	./get_agents.sh $realm | jq '.result'
	echo ""
	echo "Enter name of agent to delete:"
	read agent
	echo ""
	./delete_agent.sh $agent $realm
	echo ""
	read -p "Press [Enter] to return to menu"
	agent_menu

}



#calls ./create_agent.sh
function create_agent() {

	clear
	echo "The following JSON payloads exist in this directory:"
	echo ""
	ls *.json
	echo ""
	echo "Enter filename for create agent payload. Eg. agent.json"
	read create_agent_payload
	echo ""
	echo "Enter optional realm to create agent: Eg. myRealm"
	read realm

	#check that payload file actually exists
	if [ -e "$create_agent_payload" ]; then

		create_agent_payload="@$create_agent_payload"
		./create_agent.sh $create_agent_payload $realm		

	else

		echo "File not found: $create_agent_payload"

	fi

	echo ""
	read -p "Press [Enter] to return to menu"
	agent_menu
	
}


###########################################################################################################################################################################################################
echo ""
echo "Run ./interactive.sh to access this menu!"
echo ""
