---@param src number
---@param hideNames boolean?
---@return table
local getPlayerIds = function(src, hideNames)
    local identifiers, formatedIds = GetPlayerIdentifiers(src), {};
    for _, id in pairs(identifiers) do
        local idLabel = string.sub(id, 1, string.find(id, ':') - 1);
        local idValue = id;
        if hideNames then
            idLabel = string.sub(id, 1, string.find(id, ':') - 1);
            idValue = string.sub(id, string.find(id, ':') + 1);
        end
        formatedIds[idLabel] = idValue;
    end
    return formatedIds;
end

local defaultImg = GetConvar('mst:logImage', 'https://media.discordapp.net/attachments/928709330562347098/1139278189986840686/Mosoto_Scripts_Logo_Ready.png?width=910&height=910');
local webhook = GetConvar('mst:logWebhook', '');

mlib.log = {
    ---@param data table
    discord = function(data)
        local url = data.webhook or data.url or webhook;
        if not url then error('Webhook not set'); end;
        local information = {
            {
                color = data.color or '37023', -- https://www.mathsisfun.com/hexadecimal-decimal-colors.html
                author = {
                    icon_url = data.icon or data.icon_url or defaultImg,
                    name = GetCurrentResourceName()
                },
                title = data.title,
                description = data.description,
                footer = {text = os.date('%d/%m/%Y [%X]')}
            }
        };
        local jsonData = json.encode({username = GetCurrentResourceName(), embeds = information});
        PerformHttpRequest(url, function() end, 'POST', jsonData, {['Content-Type'] = 'application/json'});
    end,
    ---@param src number
    ---@param data table
    discordWithPlayerData = function(src, data)
        src = src or source;
        if data.player then
            local playerIds = '\n';
            -- Player Identifiers Handler --
            local playerRawIds = getPlayerIds(src, true);
            for index, _ in pairs({'steam', 'license', 'discord'}) do
                if playerRawIds[index] then
                    local idx = index:sub(1, 1):upper()..index:sub(2):lower();
                    local id = playerRawIds[index];
                    playerIds = ('%s \n **%s:** %s'):format(playerIds, idx, id);
                end
            end
            data.description = ('%s %s'):format(playerIds, data.description);
        end
        mlib.discord(data);
    end
};
RegisterServerEvent('mst-lib:server:discordLog', mlib.log.discordWithPlayerData);

return mlib;