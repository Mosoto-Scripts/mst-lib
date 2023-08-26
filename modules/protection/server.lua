---@type integer, integer
local maxTriggers, timeToClear = 10, 1;

---@type table
local triggers = {};

---@param index string
mlib.protect = function(index)
    if triggers[index] then
        triggers[index] += 1;
    else
        triggers[index] = 1;
    end

    CreateThread(function()
        Wait(timeToClear * (60 * 1000));
        triggers[index] -= 1;
    end);

    if triggers[index] > maxTriggers then
        error(('index %s has been triggered too many times!'):format(index));
    end
end