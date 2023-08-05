---@return frameworkName
local getFrameworkAutomatically = function()
    local framework, state = nil, GetResourceState;
    if state('es_extended'):find('start') then
        framework = 'ESX';
    elseif state('qb-core'):find('start') then
        framework = 'QBCore';
    elseif state('l2s-core'):find('start') then
        framework = 'L2S';
    elseif state('ox_core'):find('start') then
        framework = 'OX';
    end
    return framework;
end

---@type frameworkName
local frameworkName = lib.waitFor(getFrameworkAutomatically);

---@return table | function?
local loadFramework = function()
    if frameworkName == 'ESX' then
        return exports['es_extended']:getSharedObject();
    elseif frameworkName == 'QBCore' then
        return exports['qb-core']:GetCoreObject();
    elseif frameworkName == 'L2S' then
        frameworkName = 'QBCore';
        return exports['l2s-core']:GetCoreObject();
    elseif frameworkName == 'OX' then
        local file = 'imports/server.lua';
        local import = LoadResourceFile('ox_core', file);
        local chunk = assert(load(import, ('@@ox_core/%s'):format(file)));
        chunk();
    end if Config.FrameworkPrint then
        print(('Framework: %s'):format(frameworkName));
    end
end

mlib.framework = setmetatable({}, {
    __call = loadFramework
});
mlib.framework.load = loadFramework;

---@return frameworkName
---@diagnostic disable-next-line: duplicate-set-field
mlib.framework.name = function()
    return frameworkName;
end;
return mlib.framework;