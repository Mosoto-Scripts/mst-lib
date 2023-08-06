---@vararg string
local debugMessage = function(...)
    local msg, args = '', {...};
    for i = 1, #args do
        msg = ('%s %s'):format(msg, args[i]);
    end
    print(('%s %s'):format('[DEBUG]', msg));
end
RegisterServerEvent('mst-lib:sendConsoleMessage', debugMessage);

mlib.debug = setmetatable({}, {
    ---@vararg string
    __call = function(_, ...)
        debugMessage(...);
    end
});
return mlib.debug;