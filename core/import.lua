local debug_getinfo = debug.getinfo;
mlib = setmetatable({
    name = 'king-lib',
    context = IsDuplicityVersion() and 'server' or 'client',
}, {
    __newindex = function(self, name, fn)
        rawset(self, name, fn);

        if debug_getinfo(2, 'S').short_src:find('@king-lib/resource') then
            exports(name, fn);
        end
    end
});