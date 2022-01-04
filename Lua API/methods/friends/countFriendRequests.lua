-- // Name: countFriends.lua
-- // Description: Gets the friend count of the specified user
-- // Author: @Jumpathy

return {
	authentication_required = true,
	call = function(client,api,endpoints,cookie,headers)
		return api.request("count","friendRequestCount",api.handleAuthenticationHeaders({cookie = cookie,headers = {
			["Content-Type"] = "application/json"
		},},"friendRequestCount"),nil,"");
	end
}