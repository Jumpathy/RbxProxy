-- // Name: deleteWallPost.lua
-- // Description: Deletes a specified post from the group wall
-- // Author: @Jumpathy

return {
	authentication_required = true,
	call = function(client,api,endpoints,cookie,groupId,userId)
		if(type(userId) ~= "number") then
			userId = userId["UserId"];
		end
		return api.request(true,"delete_user_posts",api.handleAuthenticationHeaders({cookie = cookie,headers = {
			["Content-Type"] = "application/json"
		},},"delete_user_posts"),nil,groupId,userId);
	end
}