-- // Name: api.lua
-- // Description: This module handles requests and user input
-- // Author: @Jumpathy
-- // Credits: @evaera (promises)

local api = {};
local http,endpoints,promiseModule,customWait = require(script:WaitForChild("http")),require(script:WaitForChild("endpoints")),require(script:WaitForChild("http"):WaitForChild("promise")),require(script:WaitForChild("yield"))

api.promiseModule = promiseModule;

local fetchFrom = function(url,start)
	local ret = {};
	for i = 1,#url:split("/") do
		if(i >= start and (#url:split("/")[i] ~= 0)) then
			table.insert(ret,url:split("/")[i]);
		end
	end
	return ret;
end

local merge = function(arr1,arr2)
	local ret = arr1;
	for k,v in pairs(arr2) do
		arr1[k] = v;
	end
	return ret;
end

function api.decode(json)
	return game:GetService("HttpService"):JSONDecode(json);
end

function api.encode(txt)
	return game:GetService("HttpService"):JSONEncode(txt);
end

function api.base64encode(data) --> 100,000% did not steal this from stackoverflow im just pro
	local alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
	return((data:gsub(".", function(x) 
		local r,b = "",x:byte();
		for i = 8,1,-1 do
			r = r .. (b%2 ^i- b%2 ^ (i-1) > 0 and "1" or "0"); 
		end
		return r;
	end).."0000"):gsub("%d%d%d?%d?%d?%d?", function(x)
		if(#x < 6) then 
			return("");
		end
		local c = 0;
		for i = 1,6 do 
			c += (x:sub(i,i) == "1" and 2 ^ (6 - i) or 0);
		end
		return alphabet:sub(c+1,c+1);
	end));
end

function api.parseDate(date)
	local Y,M,D,H,Mi,S = date:match('(%d+)%-(%d+)%-(%d+)T(%d+):(%d+):(%d+)');
	return {year = Y,month = M,day = D,hour = H,minute = Mi,second = S};
end

function api.dateToTime(date)
	local parsed1 = api.parseDate(date);
	local dictionary = {
		year = parsed1.year,
		month = parsed1.month,
		day = parsed1.day
	}
	
	local addon = (parsed1.hour * 3600) + (parsed1.minute * 60) + (parsed1.second);
	return os.time(dictionary) + addon;
end

function api.handleAuthenticationHeaders(headers,endpoint)
	local subHeaders = headers["headers"] or {};
	local cookie = headers["cookie"];
	local endpointData = endpoints[endpoint];
	if(endpointData.authenticationRequired) then
		subHeaders["authenticate"] = "true";
		subHeaders["authentication"] = cookie;
	end
	return subHeaders;
end

function api.deepCopy(array)
	local copies = {};
	local copy;
	if(type(array) == "table") then
		if(copies[array]) then
			copy = copies[array]
		else
			copy = {}
			copies[array] = copy
			for orig_key,orig_value in next,array,nil do
				copy[api.deepCopy(orig_key,copies)] = api.deepCopy(orig_value,copies);
			end
			setmetatable(copy,api.deepCopy(getmetatable(api.deepCopy),copies))
		end
	else
		copy = array
	end
	return copy;
end

function api.query(...)
	local query = {...};
	local ret = "?";
	
	for i = 1,#query do
		local name = query[i][1];
		local value = http.encode(query[i][2]);
		ret = ret .. name .. "=" .. value .. (i < #query and "&" or "");
	end
	
	return ret;
end

function api.yield(len)
	return customWait(len);
end

function api.urlEncode(query)
	return http.encode(query);
end

function api:getGroupShout(id)
	return http.request("GET",endpoints.baseUrl .. "/shoutchanged/" .. id,{});
end

function api.request(autoDecode,endpoint,headers,body,...)
	local fill = {...};
	local url = string.format(endpoints[endpoint].url,unpack(fill or {}));
	local proxyUrl = endpoints.baseUrl .. "/request?url=" .. api.base64encode(url) .. "&method=" .. endpoints[endpoint].method;
	local promise = http.request("POST",proxyUrl,{
		["Content-Type"] = (endpoints[endpoint].contentType)
	},headers);
	if(autoDecode ~= api) then --> This code automatically decodes body info etc
		return promiseModule.async(function(resolve,reject)
			promise:andThen(function(resp)
				local body = api.decode(resp.Body);
				local key = (autoDecode ~= true and autoDecode);
				resolve(key ~= nil and body[key] or body);
			end):catch(function(err)
				reject(err);
			end)
		end)
	else
		return promise;
	end
end

return api;