-- // Name: http.lua
-- // Description: HTTP request handler
-- // Author: @Jumpathy
-- // Credits: @evaera (promises) 

local http,internal = {},{};
local httpService = game:GetService("HttpService");
local promise = require(script:WaitForChild("promise"));

local encode = function(...)
	return httpService:JSONEncode(...);
end

function http.encode(query)
	return game:GetService("HttpService"):UrlEncode(query);
end

function http.request(method,url,headers,body)
	return promise.async(function(resolve,reject)
		local success,response = pcall(httpService.RequestAsync,httpService,{
			Url = url,
			Method = method,
			Headers = headers,
			Body = (body ~= nil and ((type(body) == "table" and encode(body) or body)) or nil)
		});
		if(success and (response.StatusCode == 200)) then
			resolve(response);
		else
			reject(response);
		end
	end)
end

return http;