-- // Name: acceptJoinRequests.lua
-- // Description: Accepting specified join requests
-- // Author: @Jumpathy

return {
	authentication_required = true,
	call = function(client,api,endpoints,cookie,groupId,...)
		return api.request(true,"accept_joins",api.handleAuthenticationHeaders({
			cookie = cookie,
			headers = {
				["Content-Type"] = "application/json",
				["External"] = {
					["data"] = {
						["UserIds"] = {...}
					}
				}
			},
		},"accept_joins"),nil,groupId);
	end
}