fx_version 'cerulean';
game 'gta5';
lua54 'yes';

author 'mosotoscripts.com';
description 'Feature-rich FiveM library.';
version '0.0.1';

client_scripts {
    'core/rsc/**/client.lua',
    'core/rsc/**/client/*.lua'
};

server_scripts {
    'core/rsc/**/server.lua',
    'core/rsc/**/server/*.lua'
};

shared_scripts {
    '@ox_lib/init.lua',
    'core/import.lua',
    'core/rsc/**/shared/*.lua',
    'core/rsc/**/shared.lua'
};
dependency 'ox_lib';