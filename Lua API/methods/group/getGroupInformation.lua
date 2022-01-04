-- // Name: getGroupInformation.lua
-- // Description: Gets the specified group's information
-- // Author: @Jumpathy

return {
	authentication_required = false,
	call = function(client,api,endpoints,cookie,group_id)
		return api.request(true,"group_info",{["Content-Type"] = "application/json"},nil,group_id);
	end
}