-- // Name: yield.lua
-- // Description: Custom wait function that's more efficient and accurate
-- // Author: @PysephDEV

local clock = os.clock;
local yield = coroutine.yield;
local c_running = coroutine.running;
local c_resume = coroutine.resume;
local yields = {};

game:GetService("RunService").Stepped:Connect(function()
	local clock = clock();
	for index,data in next,yields do
		local spent = clock - data[1];
		if(spent >= data[2]) then
			yields[index] = nil;
			c_resume(data[3],spent,clock);
		end
	end
end)

return function(limit)
	limit = (type(limit) ~= "number" or limit < 0) and 0 or limit;
	table.insert(yields,{clock(),limit,c_running()});
	return yield()
end