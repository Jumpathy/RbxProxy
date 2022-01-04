-- // Name: exile.lua
-- // Description: Exiles specified user from group
-- // Author: @Jumpathy

return {
	authentication_required = true,
	call = function(client,api,endpoints,cookie,player,groupId)
		if(type(player) ~= "number") then
			player = player.UserId;
		end
		return api.request(true,"exile_user",api.handleAuthenticationHeaders({cookie = cookie,headers = {
				["Content-Type"] = "application/json"
		},},"exile_user"),nil,groupId,player);
	end
}