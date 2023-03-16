fx_version 'adamant'
games { 'gta5' }

author 'Monster Dev Team'
description 'MST-treasurechest | Script Free | Treasure chest system | https://discord.gg/monsterscript'

shared_scripts { 
	'config.lua',
}


client_script {
	'@PolyZone/client.lua',
	'client/*.lua'
}


server_script 'server/*.lua'



ui_page "html/index.html"

files {
	"html/index.html",
	"html/style.css",
	"html/index.js",
	"html/reset.css",
	"html/imgs/*.png"
}
