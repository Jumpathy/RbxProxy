-- // Name: getRoleInformation.lua
-- // Description: Get rank info
-- // Author: @Jumpathy

return {
	authentication_required = false,
	call = function(client,api,endpoints,cookie,groupId,rankId)
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
					api.request("false","get_roleData",{
						["Content-Type"] = "application/json",
						["urlExtension"] = "?ids=" .. roleId
					},nil):andThen(function(response)
						resolve(response["data"][1]);
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