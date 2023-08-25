fx_version 'cerulean';
game 'gta5';
lua54 'yes';

author 'mosotoscripts.com';
description 'Feature-rich FiveM library.';
version '1.1.1';

client_scripts {
    'core/**/client.lua',
    'core/**/client/*.lua'
};

server_scripts {
    'core/**/server.lua',
    'core/**/server/*.lua'
};

shared_scripts {
    '@ox_lib/init.lua',
    'core/import.lua',
    'core/**/shared/*.lua',
    'core/**/shared.lua'
};

files {
    'import.lua',
    'modules/**/client.lua',
    'modules/**/shared.lua'
}

files {
    'import.lua',
    'modules/**/client.lua',
    'modules/**/shared.lua'
}
dependency 'ox_lib';