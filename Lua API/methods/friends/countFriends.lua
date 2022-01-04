-- // Name: countFriends.lua
-- // Description: Gets the friend count of the specified user
-- // Author: @Jumpathy

return {
	authentication_required = true,
	call = function(client,api,endpoints,cookie,userId)
		return api.request("count","friendCount",nil,nil,userId);
	end
}