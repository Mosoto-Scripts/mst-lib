local hideCustomTextUI = function()
    -- Here you can add your custom text UI export.
end

---@param msg string
local showCustomTextUI = function(msg)
    -- Here you can add your custom text UI export.
end

---@param msg string
---@param type 'error' | 'success' | 'inform'
---@param title string?
local customNotification = function(msg, type, title)
    -- Here you can add your custom notification export.
end

mlib.ui = {
    ---@param coords vector3
    ---@param msg string
    draw3dtext = function(coords, msg)
        SetTextScale(0.35, 0.35);
        SetTextFont(4);
        SetTextProportional(true);
        SetTextColour(255, 255, 255, 215);
        BeginTextCommandDisplayText("STRING");
        SetTextCentre(true);
        AddTextComponentSubstringKeyboardDisplay(msg);
        SetDrawOrigin(coords.x, coords.y, coords.z, 0);
        EndTextCommandDisplayText(0.0, 0.0);
        local factor = (string.len(msg)) / 370;
        DrawRect(0.0, 0.0 + 0.0125, 0.017 + factor, 0.03, 0, 0, 0, 75);
        ClearDrawOrigin();
    end,
    hideTextUI = function()
        if Config.TextUI == 'ox' then
            lib.hideTextUI();
        elseif Config.TextUI == 'okok' then
            exports['okokTextUI']:Close();
        elseif Config.TextUI == 'luke' then
            TriggerEvent('luke_textui:HideUI');
        elseif Config.TextUI == 'cd' then
            TriggerEvent('cd_drawtextui:HideUI');
        elseif Config.TextUI == 'framework' then
            if Config.Framework == 'ESX' then
                Framework.HideUI();
            elseif Config.Framework == 'QBCore' then
                exports['qb-core']:HideText();
            elseif Config.Framework == 'OX' then
                lib.hideTextUI();
            end
        else
            hideCustomTextUI();
        end
    end,
    ---@param msg string
    showTextUI = function(msg)
        if Config.TextUI == 'ox' then
            lib.showTextUI(msg);
        elseif Config.TextUI == 'okok' then
            exports['okokTextUI']:Open(msg, 'darkblue', 'right');
        elseif Config.TextUI == 'luke' then
            TriggerEvent('luke_textui:ShowUI', msg);
        elseif Config.TextUI == 'cd' then
            TriggerEvent('cd_drawtextui:ShowUI', 'show', msg);
        elseif Config.TextUI == 'framework' then
            if Config.Framework == 'ESX' then
                Framework.TextUI(msg, 'info');
            elseif Config.Framework == 'QBCore' then
                exports['qb-core']:DrawText(msg);
            elseif Config.Framework == 'OX' then
                lib.showTextUI(msg);
            end
        else
            showCustomTextUI(msg);
        end
    end,
    ---@param msg string
    ---@param type 'error' | 'success' | 'inform'
    ---@param title string?
    showNotify = function(msg, type, title)
        if Config.Notifications == 'ox' then
            lib.notify({
                title = title,
                description = msg,
                type = type
            });
        elseif Config.Notifications == 'okok' then
            local newType = type == 'inform' and 'info' or type;
            exports['okokNotify']:Alert(title, msg, 5000, newType);
        elseif Config.Notifications == 'mythic' then
            exports['mythic_notify']:DoHudText(type, msg, 5000);
        elseif Config.Notifications == 'framework' then
            if Config.Framework == 'ESX' then
                Framework.ShowNotification(msg);
            elseif Config.Framework == 'QBCore' then
                local newType = type == 'inform' and 'primary' or type;
                Framework.Functions.Notify(msg, newType);
            elseif Config.Framework == 'OX' then
                lib.notify({
                    title = title,
                    description = msg,
                    type = type
                });
            end
        else
            customNotification(msg, type, title);
        end
    end
};
RegisterNetEvent('mst-lib:showNotify', mlib.ui.showNotify);

return mlib.ui;