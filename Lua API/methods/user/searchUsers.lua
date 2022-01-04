-- // Name: getPastUsernames.lua
-- // Description: Gets the past usernames of a specified user in a page format
-- // Author: @Jumpathy

local pageObject = require(script.Parent.Parent.Parent:WaitForChild("objects"):WaitForChild("page"));

return {
	authentication_required = false,
	call = function(client,api,endpoints,cookie,query)
		query = api.urlEncode(query);
		return api.promiseModule.async(function(resolve,reject)
			local key = "search_users";
			local headers = {
				["Content-Type"] = "application/json",
				["urlExtension"] = "?keyword=" .. query .. "&sortOrder=Desc&limit=100";
			};
			local pageInitiator = api.request(true,key,headers,nil):andThen(function(response)
				resolve(pageObject.new(
					response,
					{},
					key,
					api,
					headers,
					nil,
					function(extension)
						return "?keyword=" .. query .. "&" .. extension:sub(2,#extension);
					end
				));
			end):catch(function(err)
				reject(err);
			end)
		end)
	end
}