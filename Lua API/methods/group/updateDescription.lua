-- // Name: updateDescription.lua
-- // Description: Updating specified group description
-- // Author: @Jumpathy

return {
	authentication_required = true,
	call = function(client,api,endpoints,cookie,groupId,description)
		return api.request(true,"group_description",api.handleAuthenticationHeaders({
			cookie = cookie,
			headers = {
				["Content-Type"] = "application/json",
				["External"] = { --> The extenal variable means it's placed outside of the headers on the server when it's requested
					["data"] = api.encode({
						["description"] = description
					})
				}
			},
		},"group_description"),nil,groupId);
	end
}