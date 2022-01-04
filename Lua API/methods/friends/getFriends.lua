-- // Name: getFriends.lua
-- // Description: Gets the friends list of the specified user
-- // Author: @Jumpathy

return {
	authentication_required = false,
	call = function(client,api,endpoints,cookie,userId)
		return api.request("data","getFriends",nil,nil,userId);
	end
}