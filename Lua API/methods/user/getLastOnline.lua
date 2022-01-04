-- // Name: getLastOnline.lua
-- // Description: Gets the last time the specified user was online
-- // Author: @Jumpathy
-- // Credits: @Autterfly (date parser) (https://devforum.roblox.com/t/made-a-quick-place-that-shows-the-last-online-datetime-of-roblox-users/154423/2)

return {
	authentication_required = false,
	call = function(client,api,endpoints,cookie,userId)
		return api.promiseModule.async(function(resolve,reject)
			api.request(true,"getLastOnline",nil,nil,userId):andThen(function(response)
				response["ParsedLastOnline"] = api.parseDate(response["LastOnline"]);
				resolve(response);
			end):catch(reject);
		end)
	end
}