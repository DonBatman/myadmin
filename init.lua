local modpath = minetest.get_modpath("myadmin")
local input = io.open(modpath.."/settings.txt", "r")

myadmin = {}

if input then

	dofile(modpath.."/settings.txt")
	input:close()


end


dofile(minetest.get_modpath("myadmin").."/tools.lua")
dofile(minetest.get_modpath("myadmin").."/spawn.lua")
dofile(minetest.get_modpath("myadmin").."/chat.lua")
dofile(minetest.get_modpath("myadmin").."/privs.lua")
dofile(minetest.get_modpath("myadmin").."/curse.lua")
dofile(minetest.get_modpath("myadmin").."/extras.lua")
dofile(minetest.get_modpath("myadmin").."/start.lua")
dofile(minetest.get_modpath("myadmin").."/underworld.lua")
dofile(minetest.get_modpath("myadmin").."/guest.lua")
dofile(minetest.get_modpath("myadmin").."/npip.lua")

minetest.after(10,
	function(params)
		minetest.chat_send_all(myadmin.server_message)
	end
)
