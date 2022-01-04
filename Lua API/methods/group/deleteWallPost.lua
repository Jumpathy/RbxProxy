-- // Name: deleteWallPost.lua
-- // Description: Deletes a specified post from the group wall
-- // Author: @Jumpathy

return {
	authentication_required = true,
	call = function(client,api,endpoints,cookie,groupId,postId)
		if(type(postId) == "table") then
			postId = postId["id"];
		end
		return api.request(true,"delete_post",api.handleAuthenticationHeaders({cookie = cookie,headers = {
			["Content-Type"] = "application/json"
		},},"delete_post"),nil,groupId,postId);
	end
}