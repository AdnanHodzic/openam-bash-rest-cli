OpenAM Shell REST Client
====================
<br/>
Basic set of Bash wrapper scripts that use curl access the OpenAM (www.forgerock.com/openam) RESTful interface.
<br/>
Edit the settings file with server and port values for OpenAM instance.
<br/>
<br/>
<b>Requirements</b>
<br/>
The scripts were tested with jq v1.2 (required for JSON prettifying), xmllint using libxml version 20708 (for XML prettifying) and curl v7.22.0. 
<br/>
Use as-is, no warranty implied. Leave this readme and any attribution in place. Simon Moffatt, 2013 
<br/>
Note these are my tools and in no way officially supported by Forgerock. They are publicly available as a community contribution.
<br/>
<br/>
<b>CONTENTS</b>
<br/>
<b>authenticate_username_password</b> - authenticates user and returns token id.  Takes username as arg1, password as arg2
<br/>
<b>authorized?</b> - checks whether user is authorized against URI.  Takes URI as arg 1, token as arg2.
<br/>
<b>logout</b> - logs out user. Takes token as arg1
<br/>
<b>get_user_using_token</b> - returns user attributes for given token as arg 1
<br/>
<b>valid_token?</b> - checks whether given token is value.  Takes token as arg 1
<br/>
<b>oauth2_get_access_token</b> - oauth2 authentication returning access token.  Takes username as arg 1, password as arg 2 
<br/>
<b>oauth2_get_token_details</b> - oauth2 token details query.  Takes token as arg 1
<br/>
<b>create_user</b> - creates user identity in optional realm.  Takes token of admin as arg 1, JSON payload arg 2 and optional realm as optional arg 3
<br/>
<b>get_user_using_uid</b> - returns JSON of user object using uid.  Takes token of admin as arg 1, uid arg 2, realm as optional arg 3
