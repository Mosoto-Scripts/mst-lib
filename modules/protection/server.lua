---@type integer, integer
local maxTriggers, timeToClear = 10, 1;

---@type table
local eventTriggers = {};

---@param event string
mlib.protect = function(event)
    if eventTriggers[event] then
        eventTriggers[event] += 1;
    else
        eventTriggers[event] = 1;
    end

    CreateThread(function()
        Wait(timeToClear * (60 * 1000));
        eventTriggers[event] -= 1;
    end);

    if eventTriggers[event] > maxTriggers then
        error(('Event %s has been triggered too many times!'):format(event));
    end
end