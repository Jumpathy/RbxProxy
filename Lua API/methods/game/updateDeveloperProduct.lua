-- // Name: updateDeveloperProduct.lua
-- // Description: Updating specified developer products
-- // Author: @Jumpathy

return {
	authentication_required = true,
	call = function(client,api,endpoints,cookie,placeId,productId,new)
		new = new or {};
		local name,description,price = new["name"],new["description"],new["price"];
		assert((name and description and price),"Missing 1 or more values");
		return api.promiseModule.async(function(resolve,reject)
			client.game:getGameInformation(placeId):andThen(function(result)
				api.request(true,"update_developer_product",api.handleAuthenticationHeaders({
					cookie = cookie,
					headers = {
						["Content-Type"] = "application/json",
						["External"] = { --> The extenal variable means it's placed outside of the headers on the server when it's requested
							["data"] = {
								["Name"] = name,
								["Description"] = description,
								["PriceInRobux"] = price
							}
						}
					},
				},"update_developer_product"),nil,result["UniverseId"],productId):andThen(resolve):catch(reject);
			end):catch(reject);
		end)
	end
}