-- // Name: getAuditLogs.lua
-- // Description: Gets the audit logs of a specified group
-- // Author: @Jumpathy

local pageObject = require(script.Parent.Parent.Parent:WaitForChild("objects"):WaitForChild("page"));

return {
	authentication_required = true,
	call = function(client,api,endpoints,cookie,groupId)
		local args = {groupId};
		return api.promiseModule.async(function(resolve,reject)
			local key = "audit_logs";
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
					headers
					));
			end):catch(function(err)
				reject(err);
			end)
		end)
	end
}