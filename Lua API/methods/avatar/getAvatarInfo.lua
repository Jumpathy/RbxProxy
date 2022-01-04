-- // Name: getAvatarInfo.lua
-- // Description: Gets the avatar information in an array format for the specified user
-- // Author: @Jumpathy

return {
	authentication_required = false,
	call = function(client,api,endpoints,cookie,userId)
		return api.request("data","getAvatarInfo",nil,nil,userId);
	end
}