-- // Name: rank.lua
-- // Description: Group ranking system by finding the specified roleset ID for the rank you provided and then updating the specified user
-- // Author: @Jumpathy

return {
	authentication_required = true,
	call = function(client,api,endpoints,cookie,player,groupId,rankId)
		if(type(player) ~= "number") then
			player = player.UserId;
		end
		-- Flow: Rank -> Roleset Id > Rank user to roleset id 
		return api.promiseModule.async(function(resolve,reject)
			api:request("get_group_rankId",nil,nil,groupId):andThen(function(response)
				response.Body = api.decode(response.Body);
				local roleId;
				for _,role in pairs(response.Body.roles) do
					if(role.rank == rankId) then
						roleId = role.id;
					end
				end
				if(roleId) then
					api.request(true,"group_rank",api.handleAuthenticationHeaders({
						cookie = cookie,headers = {
							["Content-Type"] = "application/json",
							["External"] = {["data"] = api.encode({["roleId"] = roleId})}
						},},"group_rank"),nil,groupId,player):andThen(function(response)
						resolve(response);
					end):catch(function(err)
						reject(err);
					end)
				else
					reject("[failed to get roleId, invalid rank?]");
				end
			end):catch(function(err)
				reject(err);
			end)
		end)
	end
}