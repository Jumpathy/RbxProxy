-- // Name: getFollowings.lua
-- // Description: Gets the list of people the specified user is following
-- // Author: @Jumpathy

local pageObject = require(script.Parent.Parent.Parent:WaitForChild("objects"):WaitForChild("page"));

return {
	authentication_required = false,
	call = function(client,api,endpoints,cookie,userId)
		local args = {userId}
		return api.promiseModule.async(function(resolve,reject)
			local key = "getFollowings";
			local pageInitiator = api.request(true,key,{
				["urlExtension"] = "?sortOrder=Desc&limit=100";
			},nil,unpack(args)):andThen(function(response)
				resolve(pageObject.new(
					response,
					args,
					key,
					api
				));
			end):catch(function(err)
				reject(err);
			end)
		end)
	end
}