core.register_chatcommand("setbar", {
	params = "",
	description = "Sets the size of your hotbar. 1 - 16",
	privs = {myextras=false},
	func = function(name, param)
		if param == "" then
			core.chat_send_player(name, "Use a number from 1 - 16")
			return
		end
		if type(tonumber(param)) ~= "number" then
			core.chat_send_player(name, "This is not a number.")
			return
		end
		if tonumber(param) < 1 or tonumber(param) > 16 then
			core.chat_send_player(name, "The number of slots must be between 1 and 16.")
			return
		end
		local player = core.get_player_by_name(name)
		player:hud_set_hotbar_itemcount(tonumber(param))
		player:hud_set_hotbar_image("myextras_hotbar.png")
		core.chat_send_player(name, "Hotbar has been set!")
	end,
})

core.register_chatcommand("speed", {
    params = "<speed> [<player>]",
    description = "Sets a speed for any player. (Standart speed is 1)",
    privs = {server = true},
    
	func = function(name, param)
		local speed = string.match(param, "([^ ]+)") or 1
    	local oname = string.match(param, speed.." (.+)")
    	
    	if oname == nil then
        	core.get_player_by_name(name):set_physics_override({
            	speed = tonumber(speed)
        	})
        	return true, "Your speed is now "..speed
    	else
        	if core.get_player_by_name(oname) == nil then
            	return false, core.colorize("red", "Please, specify an online player.")
        	end
        	core.get_player_by_name(oname):set_physics_override({
            	speed = tonumber(speed)
        	})
        	return true, "Speed of player is now ."..speed
    	end
    end
})
core.register_chatcommand("god", {
    params = "[<name>]",
    description = "Enable/Disabe the god mode.",
    privs = {server = true},
	func = function(name, param)
	
    	local player
    	
    	if param == "" then
        	player = core.get_player_by_name(name)
    	else
        	player = core.get_player_by_name(param)
    	end
    	
    	if player == nil then
        	return false, core.colorize("red", "Player "..param.." not found.")
    	end
    	
    	local ag = player:get_armor_groups()
    	
    	if not ag["immortal"] then
        	ag["immortal"] = 1
        	player:set_armor_groups(ag)
        	if param == "" then
            	return true, core.colorize("yellow", "God mode enabled.")
        	else
            	core.chat_send_player(param, "God mode enabled for you by @1.", name)
            	return true, "God mode enabled for ."..param
        	end
    	else
        	ag["immortal"] = nil
        	player:set_armor_groups(ag)
        	if param == "" then
            	return true, core.colorize("yellow", "God mode disabled.")
        	else
            	core.chat_send_player(param, "God mode disabled for you by "..name)
            	return true, "God mode disabled for "..param
        	end
    	end
	end
})
