--[[
! This code is not originally made by me, I just modified it to fit my needs.
! I would give a creadit, but I don't know who made it. If you know, please let me know so I can give a creadit.
]]--

local default = [[
    ^1New update available now!^0
    Resource: ^5%s^0
    Current Version: ^5%s^0
    New Version: ^5%s^0
    Notes: ^5%s^0
    ^5Download it now on your keymaster.fivem.net^0
]];
local updateMsg = GetConvar('mst:updateMsg', default);

---@param owner string
---@param repo string?
---@param file string?
local checkVersion = function(owner, repo, file)
    local rsc = GetCurrentResourceName();
    repo, file = repo or rsc, ('%s.txt'):format(file) or 'fxmanifest.lua';
    local version = GetResourceMetadata(rsc, 'version', 0);
    Wait(4000);

    ---@param cd string
    local function ToNumber(cd)
        return tonumber(cd);
    end

    local link = ('https://raw.githubusercontent.com/%s/%s/master/%s'):format(owner, repo, file);

    ---@param result string
    PerformHttpRequest(link, function(_, result, _)
        if not result then
            return error('Something is wrong with the version check. Probably a GitHub issue.');
        end result = json.decode(result:sub(1, -2));
        if ToNumber(result.version:gsub('%.', '')) > ToNumber(version:gsub('%.', '')) then
            local symbols = '^3';
            for _ = 1, 26 + #rsc do
                symbols = symbols..'=';
            end
            symbols = symbols..'^0';
            print(symbols);
            print(updateMsg:format(rsc, version, result.version, result.notes));
            print(symbols);
        end
    end, 'GET');
end

mlib.version = setmetatable({}, {
    __call = function(_, owner, repo, file)
        checkVersion(owner, repo, file);
    end
});
mlib.version.check = checkVersion;

return mlib.version;