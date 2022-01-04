-- // Name: getGameInformation.lua
-- // Description: Gets the universe id & other information of the specified place id
-- // Author: @Jumpathy

return {
	authentication_required = false,
	call = function(client,api,endpoints,cookie,placeId)
		return api.request(true,"universe_id",{
			["urlExtension"] = "?assetId=" .. placeId;
		},nil);
	end
}