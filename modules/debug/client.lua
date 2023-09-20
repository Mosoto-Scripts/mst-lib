mlib.debug = setmetatable({}, {
    ---@param message string
    __call = function(_, message)
        TriggerServerEvent('mst-lib:sendConsoleMessage', message);
    end
});
return mlib.debug;