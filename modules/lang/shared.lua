mlib.lang = function()
    local lang = GetConvar('ox:locale', 'en') or Config.Language or 'en';
    return Config.Languages[lang];
end
return mlib.lang;