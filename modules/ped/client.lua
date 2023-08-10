---@param data table
---@return table
mlib.ped = function(data)
    local model = GetHashKey(data.model);
    local x, y, z in data.coords;
    local r = data.rotation;
    -- Ped Creation --
    lib.requestModel(model);
    local ped = CreatePed(4, model, x, y, z, r, false, true);
    SetBlockingOfNonTemporaryEvents(ped, true);
    SetPedDiesWhenInjured(ped, false);
    SetPedCanPlayAmbientAnims(ped, true);
    SetPedCanRagdollFromPlayerImpact(ped, false);
    SetEntityInvincible(ped, true);
    FreezeEntityPosition(ped, true);
    SetModelAsNoLongerNeeded(model);
    -- Metatable --
    local pedTable = setmetatable({}, {__call = ped});
    pedTable.ped = ped;
    pedTable.remove = function(self)
        DeletePed(self.ped);
    end
    return pedTable;
end
return mlib.ped;