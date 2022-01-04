-- // Name: createDeveloperProduct.lua
-- // Description: Creates developer products:tm:
-- // Author: @Jumpathy

-- Flow: PlaceId -> UniverseId -> Request Product Creation -> Get developer products with the new product's ID (this is because Roblox doesn't return a valid product id when you create one jwthw4tkjwjke)

return { --> Cancer code below
	authentication_required = true,
	call = function(client,api,endpoints,cookie,placeId,details)
		details = details or {};
		local name,description,price = details.name,details.description,details.price;
		assert((name ~= nil and description ~= nil and price ~= nil),"[failed to provide all 3 values]");
		return api.promiseModule.async(function(resolve,reject)
			local parse = function(developerProduct)
				local ret = {};
				ret["description"] = developerProduct.Description;
				ret["productId"] = developerProduct.ProductId;
				ret["name"] = developerProduct.Name;
				ret["price"] = developerProduct.PriceInRobux;
				return ret;
			end
			client.game:getGameInformation(placeId):andThen(function(result)
				local universeId = result["UniverseId"];
				api.request(true,"create_product",api.handleAuthenticationHeaders({
					cookie = cookie,
					headers = {
						["Content-Type"] = "application/json",
						["urlExtension"] = api.query(
							{"name",name},
							{"description",description},
							{"priceInRobux",price}
						);
					},
				},"create_product"),nil,universeId):andThen(function(response)
					api.request(true,"get_products",{
						["urlExtension"] = string.format("?placeId=%s&page=%s",placeId,1);
					},nil,placeId,1):andThen(function(resp)
						for _,product in pairs(resp["DeveloperProducts"]) do
							if(product.DeveloperProductId == response.id) then
								resolve(parse(product));
								return;
							end
						end
						reject("[failed to find]");
					end):catch(reject);
				end):catch(reject);
			end):catch(function(err)
				reject(err);
			end)
		end)
	end
}