-- // Name: declineJoinRequests.lua
-- // Description: Declining batch join requests
-- // Author: @Jumpathy

return {
	authentication_required = true,
	call = function(client,api,endpoints,cookie,groupId,...)
		return api.request(true,"decline_joins",api.handleAuthenticationHeaders({
			cookie = cookie,
			headers = {
				["Content-Type"] = "application/json",
				["External"] = {
					["data"] = {
						["UserIds"] = {...}
					}
				}
			},
		},"decline_joins"),nil,groupId);
	end
}