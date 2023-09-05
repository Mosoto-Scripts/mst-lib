---@class PedData
---@field model string | number
---@field coords vector3
---@field rotation number
---@field freeze boolean?

---@param data PedData
---@return table
mlib.ped = function(data)
    local model, c = joaat(data.model), data.coords;
    local x, y, z, r = c.x, c.y, c.z, data.rotation;
    -- Ped Creation --
    lib.requestModel(model);
    local ped = CreatePed(4, model, x, y, z, r, false, true);
    SetBlockingOfNonTemporaryEvents(ped, true);
    SetPedDiesWhenInjured(ped, false);
    SetPedCanPlayAmbientAnims(ped, true);
    SetPedCanRagdollFromPlayerImpact(ped, false);
    SetEntityInvincible(ped, true);
    if data.freeze or data.freeze == nil then
        FreezeEntityPosition(ped, true);
    end
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