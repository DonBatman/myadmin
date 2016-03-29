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

if myadmin.guest then
	dofile(minetest.get_modpath("myadmin").."/guest.lua")
end

if myadmin.names_per_ip then
	dofile(minetest.get_modpath("myadmin").."/npip.lua")
end

minetest.register_on_joinplayer(function(player)
	minetest.after(5,function()
		minetest.chat_send_player(player:get_player_name(), "Welcome "..player:get_player_name().."!")
	end)
end)

