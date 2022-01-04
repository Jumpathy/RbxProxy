-- // Name: shout.lua
-- // Description: Updating specified group shouts
-- // Author: @Jumpathy

return {
	authentication_required = true,
	call = function(client,api,endpoints,cookie,groupId,message)
		return api.request(true,"group_shout",api.handleAuthenticationHeaders({
			cookie = cookie,
			headers = {
				["Content-Type"] = "application/json",
				["External"] = { --> The extenal variable means it's placed outside of the headers on the server when it's requested
					["data"] = api.encode({
						["message"] = message
					})
				}
			},
		},"group_shout"),nil,groupId);
	end
}