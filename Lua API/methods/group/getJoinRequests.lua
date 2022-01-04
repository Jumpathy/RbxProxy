-- // Name: getGroupWall.lua
-- // Description: Gets the group wall of a specified group
-- // Author: @Jumpathy

local pageObject = require(script.Parent.Parent.Parent:WaitForChild("objects"):WaitForChild("page"));

return {
	authentication_required = true,
	call = function(client,api,endpoints,cookie,groupId)
		local args = {groupId};
		return api.promiseModule.async(function(resolve,reject)
			local key = "join_requests";
			local headers = api.handleAuthenticationHeaders({
				cookie = cookie,
				headers = {
					["Content-Type"] = "application/json",
					["urlExtension"] = "?sortOrder=Desc&limit=100";
				}
			},key);
			local pageInitiator = api.request(true,key,headers,nil,unpack(args)):andThen(function(response)
				resolve(pageObject.new(
					response,
					args,
					key,
					api,
					headers,
					function(object)
						object = api.deepCopy(object);
						for _,post in pairs(object["data"]) do
							post["createdParsed"] = api.parseDate(post["created"]);
						end
						return object;
					end
				));
			end):catch(function(err)
				reject(err);
			end)
		end)
	end
}