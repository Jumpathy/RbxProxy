-- // Name: createRank.lua
-- // Description: Creating rolesets:tm:
-- // Author: @Jumpathy

return {
	authentication_required = true,
	call = function(client,api,endpoints,cookie,groupId,config)
		config = config or {};
		local name,description,rank,useGroupFunds = config.name,config.description,config.rank,config.useGroupFunds;
		print(name,description,rank,useGroupFunds,"o")
		assert((name and description and rank and (useGroupFunds ~= nil)),"One or more of your values are missing.");
		return api.request(true,"create_roleset",api.handleAuthenticationHeaders({
			cookie = cookie,
			headers = {
				["Content-Type"] = "application/json",
				["External"] = {
					["data"] = {
						name = name,
						description = description,
						rank = rank,
						usingGroupFunds = useGroupFunds
					}
				}
			},
		},"create_roleset"),nil,groupId);
	end
}