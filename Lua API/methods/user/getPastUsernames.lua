-- // Name: getPastUsernames.lua
-- // Description: Gets the past usernames of a specified user in a page format
-- // Author: @Jumpathy

local pageObject = require(script.Parent.Parent.Parent:WaitForChild("objects"):WaitForChild("page"));

return {
	authentication_required = false,
	call = function(client,api,endpoints,cookie,userId)
		if(type(userId) ~= "number") then
			userId = userId["UserId"];
		end
		local args = {userId};
		return api.promiseModule.async(function(resolve,reject)
			local key = "past_usernames";
			local headers = {
				["Content-Type"] = "application/json",
				["urlExtension"] = "?sortOrder=Desc&limit=100";
			};
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