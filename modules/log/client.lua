mlib.log = {
    ---@param data table
    discordClient = function(data)
        TriggerServerEvent('mst-lib:server:discordLog', data);
    end
};
return mlib.log;