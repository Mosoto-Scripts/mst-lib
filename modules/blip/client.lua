---@param self table
local removeBlip = function(self)
    if DoesBlipExist(self.blip) then
        RemoveBlip(self.blip);
    end
end;

mlib.blip = {
    ---@param id number
    ---@return boolean
    exists = function(id)
        return DoesBlipExist(id) ~= nil;
    end,
    ---@param data table
    ---@return table
    add = function(data)
        local x, y, z in data.coords;
        local blip = AddBlipForCoord(x, y, z);
        SetBlipSprite(blip, data.sprite);
        SetBlipColour(blip, data.color);
        SetBlipScale(blip, data.scale or 0.5);
        SetBlipDisplay(blip, data.display or 2);
        SetBlipAsShortRange(blip, data.shortRange or true);
        BeginTextCommandSetBlipName('STRING');
        AddTextComponentSubstringKeyboardDisplay(data.label);
        EndTextCommandSetBlipName(blip);
        -- Metatable --
        local blipTable = setmetatable({}, {__call = blip});
        blipTable.blip = blip;
        blipTable.remove = removeBlip;
        return blipTable;
    end,
    ---@param data table
    ---@return table
    addForRadius = function(data)
        local x, y, z in data.coords;
        local blip = AddBlipForRadius(x, y, z, data.radius);
        SetBlipColour(blip, data.color);
        SetBlipAlpha(blip, data.alpha);
        -- Metatable --
        local blipTable = setmetatable({}, {__call = blip});
        blipTable.blip = blip;
        blipTable.remove = removeBlip;
        return blipTable;
    end
};
return mlib.blip;