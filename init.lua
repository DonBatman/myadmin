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

