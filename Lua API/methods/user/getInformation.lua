-- // Name: getInformation.lua
-- // Description: Gets user information found on their profiles
-- // Author: @Jumpathy

return {
	authentication_required = false,
	call = function(client,api,endpoints,cookie,userId)		
		return api.promiseModule.async(function(resolve,reject)
			api.request(true,"getUserInfo",nil,nil,userId):andThen(function(response)
				response["createdParsed"] = api.parseDate(response["created"]);
				resolve(response);
			end):catch(reject);
		end)
	end
}