if not GetResourceState('mst-lib'):find('start') then
	error('^mst-lib should be started before this resource.^0', 2);
end

local LoadResourceFile = LoadResourceFile;
local context = IsDuplicityVersion() and 'server' or 'client';
local noop = function() end;

---@param self table
---@param module string
local loadModule = function(self, module)
    local dir = ('modules/%s'):format(module);
	local chunk = LoadResourceFile('mst-lib', ('%s/%s.lua'):format(dir, context));
	local shared = LoadResourceFile('mst-lib', ('%s/shared.lua'):format(dir));
    if shared then
		chunk = (chunk and ('%s\n%s'):format(shared, chunk)) or shared;
	end if chunk then
		local fn, err = load(chunk, ('@@mst-lib/%s/%s.lua'):format(module, context));
		if not fn or err then
			return error(('\n^1Error importing module (%s): %s^0'):format(dir, err), 3);
        end

        local result = fn();
        self[module] = result or noop;
        return self[module];
	end
end

---@param self table
---@param index string
---@vararg any
---@return any
local callMetaTable = function(self, index, ...)
    local module = rawget(self, index);
	if not module then
        self[index] = noop;
		module = loadModule(self, index);
		if not module then
			local function method(...)
				return exports['mst-lib'][index](nil, ...);
            end if not ... then
				self[index] = method;
			end
			return method;
		end
	end
	return module;
end

mlib = setmetatable({
    name = 'mst-lib',
	context = context
}, {
	__index = callMetaTable,
	__call = callMetaTable,
});