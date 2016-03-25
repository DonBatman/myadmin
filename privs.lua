
minetest.register_privilege("myadmin_levels", "Lets person set level of privlege people have")
minetest.register_privilege("myadmin_levels_super", "Lets person set level of privlege people have plus the super level")

minetest.register_chatcommand("myadmin_commands", {
	privs = {myadmin_levels = true},
	func = function(name, param)
		minetest.chat_send_player(name,"Available commands - /admin, /mod, /helper, /norm, /punish, /unpunish, silence, /ghost")
		return true
	end,
})

minetest.register_chatcommand("super_admin", {
	params = "",
	description = "Super Administrator",
	privs={myadmin_levels_super=true},
	func = function(name, param)
		if minetest.get_player_by_name(param) then
		minetest.set_player_privs(param, {})
		local privs=minetest.get_player_privs(param)
			privs.shout=true
			privs.interact=true
			privs.home=true
			privs.give=true
			privs.teleport=true
			privs.bring=true
			privs.fast=true
			privs.fly=true
			privs.noclip=true
			privs.privs=true
			privs.basic_privs=true
			privs.kick=true
			privs.ban=true
			privs.myadmin_levels=true
			privs.tps_magicchests=true
			minetest.set_player_privs(param,privs)
			minetest.chat_send_player(param, "You are now a Super Admin")
			minetest.chat_send_player(name, param .. " is now a Super Admin")
			return true
		end
end})

minetest.register_chatcommand("admin", {
	params = "",
	description = "Administrator",
	privs={myadmin_levels=true},
	func = function(name, param)
		if minetest.get_player_by_name(param) then
		minetest.set_player_privs(param, {})
		local privs=minetest.get_player_privs(param)
			privs.shout=true
			privs.interact=true
			privs.home=true
			privs.teleport=true
			privs.bring=true
			privs.fast=true
			privs.fly=true
			privs.noclip=true
			privs.basic_privs=true
			privs.kick=true
			privs.ban=true
			privs.myadmin_levels=true
			privs.tps_magicchests=true
			minetest.set_player_privs(param,privs)
			minetest.chat_send_player(param, "You are now an Admin")
			minetest.chat_send_player(name, param .. " is now an Admin")
			return true
		end
end})

minetest.register_chatcommand("mod", {
	params = "",
	description = "Moderator",
	privs={myadmin_levels=true},
	func = function(name, param)
		if minetest.get_player_by_name(param) then
		minetest.set_player_privs(param, {})
		local privs=minetest.get_player_privs(param)
			privs.shout=true
			privs.interact=true
			privs.home=true
			privs.teleport=true
			privs.fast=true
			privs.fly=true
			privs.basic_privs=true
			privs.kick=true
			minetest.set_player_privs(param,privs)
			minetest.chat_send_player(param, "You are now a Moderator")
			minetest.chat_send_player(name, param .. " is now a Moderator")
			return true
		end
end})

minetest.register_chatcommand("helper", {
	params = "",
	description = "Helper",
	privs={myadmin_levels=true},
	func = function(name, param)
		if minetest.get_player_by_name(param) then
		minetest.set_player_privs(param, {})
		local privs=minetest.get_player_privs(param)
			privs.shout=true
			privs.interact=true
			privs.home=true
			privs.fast=true
			privs.fly=true
			privs.kick=true
			minetest.set_player_privs(param,privs)
			minetest.chat_send_player(param, "You are now a Helper")
			minetest.chat_send_player(name, param .. " is now a Helper")
			return true
		end
end})

minetest.register_chatcommand("norm", {
	params = "",
	description = "Normal Player",
	privs={myadmin_levels=true},
	func = function(name, param)
		if minetest.get_player_by_name(param) then
		minetest.set_player_privs(param, {})
		local privs=minetest.get_player_privs(param)
			privs.shout=true
			privs.interact=true
			privs.home=true
			privs.fast=true
			minetest.set_player_privs(param,privs)
			minetest.chat_send_player(param, "You are now a Normal Player")
			minetest.chat_send_player(name, param .. " is now a Normal Player")
			return true
		end
end})

minetest.register_chatcommand("unpunish", {
	params = "",
	description = "Unpunish Player",
	privs={myadmin_levels=true},
	func = function(name, param)
		if minetest.get_player_by_name(param) then
		minetest.set_player_privs(param, {})
		local privs=minetest.get_player_privs(param)
			privs.shout=true
			privs.interact=true
			privs.home=true
			privs.fast=true
			minetest.set_player_privs(param,privs)
			minetest.chat_send_player(param, "You are now unpunished")
			minetest.chat_send_player(name, param .. " is now unpunished")
			return true
		end
end})

minetest.register_chatcommand("punish", {
	params = "",
	description = "Punish Player",
	privs={myadmin_levels=true},
	func = function(name, param)
		if minetest.get_player_by_name(param) then
		minetest.set_player_privs(param, {})
		local privs=minetest.get_player_privs(param)
			privs.shout=true
			minetest.set_player_privs(param,privs)
			minetest.chat_send_player(param, "You are now being punished")
			minetest.chat_send_player(name, param .. " is now punished")
			return true
		end
end})

minetest.register_chatcommand("silence", {
	params = "",
	description = "Silence Player",
	privs={myadmin_levels=true},
	func = function(name, param)
		if minetest.get_player_by_name(param) then
		minetest.set_player_privs(param, {})
		local privs=minetest.get_player_privs(param)
			privs.interact=true
			privs.home=true
			privs.fast=true
			minetest.set_player_privs(param,privs)
			minetest.chat_send_player(param, "You are now silenced")
			minetest.chat_send_player(name, param .. " is now silenced")
			return true
		end
end})

minetest.register_chatcommand("ghost", {
	params = "",
	description = "Remove all privs",
	privs={myadmin_levels=true},
	func = function(name, param)
		if minetest.get_player_by_name(param) then
		minetest.set_player_privs(param, {})
			minetest.chat_send_player(param, "You are now a ghost")
			minetest.chat_send_player(name, param .. " is now ghosted")
			return true
		end
end})
