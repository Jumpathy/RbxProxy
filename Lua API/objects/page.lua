-- // Name: page.lua
-- // Description: Wraps a roblox page object into an interactable object-oriented-programming (oop) table.
-- // Author: @Jumpathy

local page = {};

local readOnly = function(tbl) --> Hacky method lol
	local proxy = {};
	for k,v in pairs(tbl) do
		rawset(proxy,k,v);
	end
	setmetatable(tbl,{
		__newindex = function(t,k,v)
			rawset(proxy,k,v);
			rawset(t,k,v);
		end,
	})
	setmetatable(proxy,{
		__newindex = function(t,k,v)
			error("Attempt to write to a readonly table"); --> This is done so somebody doesn't do something stupid and break the whole system
			-- tbl[k] = v;
		end,
		__index = function(t,k)
			return tbl[k];
		end,
	})
	return proxy;
end

function page.new(firstPage,arguments,endpoint,api,headers,manage,parseExtensions)
	parseExtensions = parseExtensions or function(a) return a; end
	manage = manage or function(a) return a end;
	headers = headers or {headers = {}};
	headers.headers = headers.headers or {};
	
	local object,internal,pageCursors,pages = {},{},{},{manage(firstPage)};
	internal.currentPage = manage(firstPage);
	internal.pageKey = 1;
	
	local handle = function(newHeaders)
		if(headers) then
			headers.headers.urlExtension = newHeaders.urlExtension;
			return headers
		else
			return newHeaders;
		end
	end
	
	function object:getCurrentPage()
		return manage(pages[internal.pageKey])["data"];
	end
	
	function object:getPreviousPage()
		internal.pageKey = math.clamp(internal.pageKey - 1,1,math.huge);
		return manage(pages[internal.pageKey])["data"];
	end

	function object:advanceToNextPage()
		return api.promiseModule.async(function(resolve,reject)
			if(internal.currentPage.nextPageCursor ~= nil) then
				if(pages[internal.pageKey + 1] == nil) then
					local cursor = internal.currentPage.nextPageCursor;
					local nextPage = api.request(true,endpoint,handle({
						["urlExtension"] = parseExtensions("?sortOrder=Desc&limit=100&cursor="..cursor);
					}),nil,unpack(arguments)):andThen(function(response)
						table.insert(pages,response.data);
						internal.pageKey = table.find(pages,response.data);
						pageCursors[cursor] = response;
						internal.currentPage = pageCursors[cursor];
						resolve(manage(response)["data"]);
					end):catch(function(err)
						reject(err);
					end)
				else
					resolve(manage(pages[internal.pageKey])["data"]);
				end
			else
				reject("[No next page found]");
			end
		end)
	end

	return readOnly(object);
end

return page;