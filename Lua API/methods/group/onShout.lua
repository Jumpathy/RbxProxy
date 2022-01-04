-- // Name: shouted.lua
-- // Description: Group shout event thing lol
-- // Author: @Jumpathy

return {
	authentication_required = false,
	call = function(client,api,endpoints,cookie,groupId)
		local last,handleErrors = nil,function() end;
		local doContinue = true;
		local callbacks = {};
		local bindable = { --> bad fake bindable but I can't modify the signal thing to my needs
			Event = {
				Connect = function(self,callback)
					table.insert(callbacks,callback);
					local ret = {};
					function ret:Disconnect()
						ret.Disconnect = nil;
						table.remove(callbacks,table.find(callbacks,callback));
						if(#callbacks == 0) then
							doContinue = false;
						end
					end
					return ret;
				end
			},
			Fire = function(self,new)
				for _,callback in pairs(callbacks) do
					coroutine.wrap(callback)(new);
				end
			end,
		}
		
		local handleShoutData = function(current,format)
			if(current ~= last) then
				last = current;
				bindable:Fire(format);
			end
		end
		
		coroutine.wrap(function() --> gotta return something man lol
			while(true and doContinue) do --> This doesn't *actually* run every 5 seconds because of the yield provided in the promise below:
				local success,response = api:getGroupShout(groupId):catch(handleErrors):await();
				if(response and response["Body"]) then
					local decoded = api.decode(response["Body"]);
					if(decoded["currentshout"]) then
						handleShoutData(decoded["currentshout"],decoded["fullshout"]);
					end
				end
				api.yield(5);
			end
		end)();
		
		return bindable.Event;
	end
}