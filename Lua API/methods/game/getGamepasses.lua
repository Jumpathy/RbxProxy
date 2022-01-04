-- // Name: getGamepasses.lua
-- // Description: Gets the gampeasses of a specified game in a page format
-- // Author: @Jumpathy

local pageObject = require(script.Parent.Parent.Parent:WaitForChild("objects"):WaitForChild("page"));

return {
	authentication_required = false,
	call = function(client,api,endpoints,cookie,placeId)
		return api.promiseModule.async(function(resolve,reject)
			client.game:getGameInformation(placeId):andThen(function(result)
				local universeId = result["UniverseId"];
				local key = "get_passes";
				local headers = {
					["Content-Type"] = "application/json",
					["urlExtension"] = "?sortOrder=Desc&limit=100";
				};
				local pageInitiator = api.request(true,key,headers,nil,universeId):andThen(function(response)
					resolve(pageObject.new(
						response,
						{},
						key,
						api,
						headers,
						nil
					));
				end):catch(function(err)
					reject(err);
				end)
			end):catch(reject);
		end)
	end
}