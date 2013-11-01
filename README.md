OpenAM v11 Shell REST Client
============================
<br/>
A set of Bash wrapper scripts that use curl, to access the OpenAM (www.forgerock.com/openam) RESTful interface.  Note this package only works on v11 of OpenAM.
<br/>
<br/>
<b>To use, it's recommended to run ./interactive.sh for the menu driven front end.  Performs token retrieval and storage for reuse.</b>
<br/>
<br/>
<b>Requirements</b>
<br/>
<br/>
The scripts were tested with jq v1.2 (required for JSON prettifying), curl v7.22.0 and OpenAM v11
<br/>
Use as-is, no warranty implied. Leave this readme and any attribution in place. Simon Moffatt, 2013 
<br/>
<br/>
<b>Note these are my tools and in no way officially supported by Forgerock. They are publicly available as a community contribution.</b>
<br/>
<br/>
<b>CONTENTS</b>
<br/>
<b>interactive</b> - an interactive menu driven CLI to access all scripts
<br/>
<br/>
<b>AUTHENTICATION</b>
<br/>
<b>authn_user_pw_default</b> - authenticates to top realm and default chain
<br/>
<b>authn_user_pw_any_realm_any_chain</b> - authenticates to any realm any service
<br/>
<b>authn_user_pw_any_realm_any_module</b> - authenticates to any realm any module
<br/>
<b>log_out</b> - logs out current user
<br/>
<b>valid_token?</b> - checks if given token is valid
<br>
<b>get_user_using_token</b> - returns user attributes associated with given token
<br/>
<b>get_cookie_domain</b> - returns cookie domains
<br/>
<br/>
<b>AGENTS</b>
<br/>
<b>get_agents</b> - returns all agents for given realm
<br/>
<b>get_agent</b> - returns full attributes for given agent
<br/>
<b>create_agent</b> - creates agent with given JSON file payload
<br/>
<b>delete_agent</b> - deletes given agent
<br/>
<b>update_agent</b> - updates given agent with values from JSON payload
<br/>
<br/>
<b>REALMS</b>
<br/>
<b>get_realm</b> - returns details on given realm
<br/>
<b>update_realm</b> - updates given realm with values from JSON payload
<br/>
<b>create_realm</b> - creates realm with values from given JSON payload
<br/>
<b>delete_realm</b> - deletes given realm
<br/>
<br/>
<b>OAUTH2</b>
<br/>
<b>oauth2_get_access_token_pw_grant</b> - returns access/refresh token for given user/pw combination for OAuth2 client, password and scope
<br/>
<b>oauth2_get_access_token_details</b> - returns token details
<br/>
<br/>
<b>DASHBOARDS</b>
<br/>
<b>get_dashboard_applications_available</b> - returns dashboard apps available
<br/>
<b>get_dashboard_applications_assigned</b> - returns dashboard apps assigned
<br/>
<b>get_dashboard_applications_defined</b> - returns dashboard apps defined
<br/>
<br/>
<b>TEMPLATES</b>
<br/>
Various JSON files that could be used to create/update objects.


