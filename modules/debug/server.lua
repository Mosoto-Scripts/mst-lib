---@param message string
local debugMessage = function(message)
    local msg = type(message) == 'string' and message or message[1];
    if type(message) == 'table' then
        for i = 1, #message do
            msg = ('%s %s'):format(msg, message[i]);
        end
    end
    print(msg);
end
RegisterServerEvent('mst-lib:sendConsoleMessage', debugMessage);

mlib.debug = setmetatable({}, {
    ---@param message string
    __call = function(_, message)
        debugMessage(message);
    end
});
return mlib.debug;