-- // Name: getOutfits.lua
-- // Description: Gets the outfits of the specified user
-- // Author: @Jumpathy

return {
	authentication_required = false,
	call = function(client,api,endpoints,cookie,userId)
		return api.request("data","getOutfits",nil,nil,userId);
	end
}