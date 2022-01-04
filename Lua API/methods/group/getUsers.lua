-- // Name: getUsers.lua
-- // Description: Gets the users of a specified group
-- // Author: @Jumpathy

local pageObject = require(script.Parent.Parent.Parent:WaitForChild("objects"):WaitForChild("page"));

return {
	authentication_required = false,
	call = function(client,api,endpoints,cookie,groupId)
		local args = {groupId};
		return api.promiseModule.async(function(resolve,reject)
			local key = "get_users";
			local headers = {
				["Content-Type"] = "application/json",
				["urlExtension"] = "?sortOrder=Desc&limit=100";
			}
			local pageInitiator = api.request(true,key,headers,nil,unpack(args)):andThen(function(response)
				resolve(pageObject.new(
					response,
					args,
					key,
					api,
					headers
					));
			end):catch(function(err)
				reject(err);
			end)
		end)
	end
}