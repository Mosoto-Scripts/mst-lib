fx_version 'cerulean';
game 'gta5';
lua54 'yes';

author 'mosotoscripts.com';
description 'Feature-rich FiveM library.';
version '1.1.0';

client_scripts {
    'core/testing/**/client.lua',
    'core/testing/**/client/*.lua'
};

server_scripts {
    'core/testing/**/server.lua',
    'core/testing/**/server/*.lua'
};

shared_scripts {
    '@ox_lib/init.lua',
    'core/import.lua',
    'core/testing/**/shared/*.lua',
    'core/testing/**/shared.lua'
};

files {
    'import.lua',
    'modules/**/client.lua',
    'modules/**/shared.lua'
}
dependency 'ox_lib';