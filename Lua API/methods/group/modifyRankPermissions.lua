-- // Name: modifyRankPermissions.lua
-- // Description: Change rank permissions
-- // Author: @Jumpathy

return {
	authentication_required = true,
	call = function(client,api,endpoints,cookie,groupId,rankId,new)
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
					api.request(true,"modify_rank_permissions",api.handleAuthenticationHeaders({
						cookie = cookie,headers = {
							["Content-Type"] = "application/json",
							["External"] = {["data"] = {
								["permissions"] = new
							}}
						},},"modify_rank_permissions"),nil,groupId,roleId):andThen(function(response)
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