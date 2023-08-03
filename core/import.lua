local debug_getinfo = debug.getinfo;
mlib = setmetatable({
    name = 'mst-lib',
    context = IsDuplicityVersion() and 'server' or 'client',
}, {
    __newindex = function(self, name, fn)
        rawset(self, name, fn);

        if debug_getinfo(2, 'S').short_src:find('@mst-lib/resource') then
            exports(name, fn);
        end
    end
});