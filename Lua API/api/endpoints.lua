-- // Name: endpoints.lua
-- // Description: API endpoints and data such as methods and authentication required
-- // Author: @Jumpathy

return {
	--[[
	This was used in the beginning to handle authentication, but the web proxy server now 
	handles this to limit the http request count.
	
		["token"] = {
			url = internal.baseUrl .. "/authentication/csrf",
			authenticationRequired = true,
			method = "GET"
		},
	]]
	
	["get_name"] = {
		url = "users.roblox.com/v1/users/%s/",
		authenticationRequired = false,
		method = "GET",
	},
	
	["friend_request_count"] = {
		url = "friends.roblox.com/v1/user/friend-requests/count",
		authenticationRequired = true,
		method = "GET"
	},
	
	-- USER:
	
	["getUserInfo"] = {
		url = "users.roblox.com/v1/users/%s/",
		authenticationRequired = false,
		method = "GET"
	},
	
	["getLastOnline"] = {
		url = "api.roblox.com/users/%s/onlinestatus",
		authenticationRequired = false,
		method = "GET",
		contentType = nil
	},
	
	["past_usernames"] = {
		url = "users.roblox.com/v1/users/%s/username-history",
		authenticationRequired = false,
		method = "GET",
		contentType = "application/json"
	},
	
	["search_users"] = {
		url = "users.roblox.com/v1/users/search",
		authenticationRequired = false,
		method = "GET",
		contentType = "application/json"
	},
	
	-- FRIENDS:
	
	["getFriends"] = {
		url = "friends.roblox.com/v1/users/%s/friends",
		authenticationRequired = true,
		method = "GET",
		contentType = nil
	},
	
	["friendCount"] = {
		url = "friends.roblox.com/v1/users/%s/friends/count",
		authenticationRequired = false,
		method = "GET",
		contentType = nil
	},
	
	["friendRequestCount"] = {
		url = "friends.roblox.com/v1/user/friend-requests/count",
		authenticationRequired = true,
		method = "GET",
		contentType = "application/json"
	},
	
	["getFollowers"] = {
		url = "friends.roblox.com/v1/users/%s/followers",
		authenticationRequired = false,
		method = "GET",
		contentType = "application/json"
	},

	["getFollowings"] = {
		url = "friends.roblox.com/v1/users/%s/followings",
		authenticationRequired = false,
		method = "GET",
		contentType = "application/json"
	},
	
	-- AVATAR:
	
	["getOutfits"] = {
		url = "avatar.roblox.com/v1/users/%s/outfits",
		authenticationRequired = false,
		method = "GET",
		contentType = nil
	},
	
	["getAvatarInfo"] = {
		authenticationRequired = false,
		url = "avatar.roblox.com/v1/users/%s/avatar",
		method = "GET",
		contentType = nil
	},
	
	-- GROUPS:
	
	["modify_rank_permissions"] = {
		url = "groups.roblox.com/v1/groups/%s/roles/%s/permissions",
		authenticationRequired = true,
		method = "PATCH",
		contentType = "application/json"
	},
	
	["get_roleData"] = {
		url = "groups.roblox.com/v1/roles",
		authenticationRequired = false,
		method = "GET",
		contentType = "application/json"
	},
	
	["create_roleset"] = {
		url = "groups.roblox.com/v1/groups/%s/rolesets/create",
		authenticationRequired = true,
		method = "POST",
		contentType = "application/json"
	},
	
	["join_requests"] = {
		url = "groups.roblox.com/v1/groups/%s/join-requests",
		authenticationRequired = true,
		method = "GET",
		contentType = "application/json"
	},
	
	["accept_joins"] = {
		url = "groups.roblox.com/v1/groups/%s/join-requests",
		authenticationRequired = true,
		method = "POST",
		contentType = "application/json"
	},

	["decline_joins"] = {
		url = "groups.roblox.com/v1/groups/%s/join-requests",
		authenticationRequired = true,
		method = "DELETE",
		contentType = "application/json"
	},
	
	["audit_logs"] = {
		url = "groups.roblox.com/v1/groups/%s/audit-log",
		authenticationRequired = true,
		method = "GET",
		contentType = "application/json"
	},
	
	["get_users"] = {
		url = "groups.roblox.com/v1/groups/%s/users",
		authenticationRequired = true,
		method = "GET",
		contentType = "application/json"
	},

	["delete_post"] = {
		url = "groups.roblox.com/v1/groups/%s/wall/posts/%s",
		authenticationRequired = true,
		method = "DELETE",
		contentType = "application/json"
	},
	
	["delete_user_posts"] = {
		url = "groups.roblox.com/v1/groups/%s/wall/users/%s/posts",
		authenticationRequired = true,
		method = "DELETE",
		contentType = "application/json"
	},
	
	["group_shout"] = {
		url = "groups.roblox.com/v1/groups/%s/status",
		authenticationRequired = true,
		method = "PATCH",
		contentType = "application/json"
	},
	
	["group_description"] = {
		url = "groups.roblox.com/v1/groups/%s/description",
		authenticationRequired = true,
		method = "PATCH",
		contentType = "application/json"
	},
	
	["get_group_rankId"] = {
		url = "groups.roblox.com/v1/groups/%s/roles",
		authenticationRequired = false,
		method = "GET",
		contentType = nil
	},
	
	["group_rank"] = {
		url = "groups.roblox.com/v1/groups/%s/users/%s",
		authenticationRequired = true,
		method = "PATCH",
		contentType = "application/json"
	},
	
	["exile_user"] = {
		url = "groups.roblox.com/v1/groups/%s/users/%s",
		authenticationRequired = true,
		method = "DELETE",
		contentType = "application/json"
	},
	
	["group_wall"] = {
		url = "groups.roblox.com/v1/groups/%s/wall/posts",
		authenticationRequired = true,
		method = "GET",
		contentType = "application/json"
	},
	
	["group_info"] = {
		url = "groups.roblox.com/v1/groups/%s",
		authenticationRequired = false,
		method = "GET",
		contentType = "application/json"
	},
	
	-- GAME:
	
	["update_developer_product"] = {
		url = "develop.roblox.com/v1/universes/%s/developerproducts/%s/update",
		authenticationRequired = true,
		method = "POST",
		contentType = "application/json"
	},
	
	["universe_id"] = {
		url = "www.roblox.com/places/api-get-details",
		authenticationRequired = false,
		method = "GET",
		contentType = "application/json"
	},
	
	["create_product"] = {
		url = "develop.roblox.com/v1/universes/%s/developerproducts",
		authenticationRequired = true,
		method = "POST",
		contentType = "application/json"
	},
	
	["get_passes"] = {
		url = "games.roblox.com/v1/games/%s/game-passes",
		authenticationRequired = true,
		method = "GET",
		contentType = "application/json"
	},
	
	-- INTERNAL METHODS: (NOT ACCESSIBLE VIA API)
	
	["get_products"] = {
		url = "api.roblox.com/developerproducts/list",
		authenticationRequired = false,
		method = "GET",
		contentType = "application/json"
	},
	
	["currently_authenticated"] = {
		url = "users.roblox.com/v1/users/authenticated",
		authenticationRequired = true,
		method = "GET",
		contentType = "application/json"
	}
}