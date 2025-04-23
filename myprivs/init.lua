
core.register_privilege("myprivs_levels", "Lets person set level of privlege people have")
core.register_privilege("myprivs_levels_super", "Lets person set level of privlege people have plus the super level")

core.register_chatcommand("myprivs_commands", {
	privs = {myprivs_levels = true},
	func = function(name, param)
		core.chat_send_player(name,"Available commands - /admin, /mod, /helper, /norm, /punish, /unpunish, silence, /ghost")
		return true
	end,
})

core.register_chatcommand("super_admin", {
	params = "",
	description = "Super Administrator",
	privs={myprivs_levels_super=true},
	func = function(name, param)
		if core.get_player_by_name(param) then
		core.set_player_privs(param, {})
		local privs=core.get_player_privs(param)
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
			privs.areas=true
			privs.myprivs_levels=true
			privs.myadminextras=true
			core.set_player_privs(param,privs)
			core.chat_send_player(param, "You are now a Super Admin")
			core.chat_send_player(name, param .. " is now a Super Admin")
			return true
		end
end})

core.register_chatcommand("admin", {
	params = "",
	description = "Administrator",
	privs={myprivs_levels=true},
	func = function(name, param)
		if core.get_player_by_name(param) then
		core.set_player_privs(param, {})
		local privs=core.get_player_privs(param)
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
			privs.areas=true
			privs.myprivs_levels=true
			privs.myadminextras=true
			core.set_player_privs(param,privs)
			core.chat_send_player(param, "You are now an Admin")
			core.chat_send_player(name, param .. " is now an Admin")
			return true
		end
end})

core.register_chatcommand("mod", {
	params = "",
	description = "Moderator",
	privs={myprivs_levels=true},
	func = function(name, param)
		if core.get_player_by_name(param) then
		core.set_player_privs(param, {})
		local privs=core.get_player_privs(param)
			privs.shout=true
			privs.interact=true
			privs.home=true
			privs.teleport=true
			privs.fast=true
			privs.fly=true
			privs.basic_privs=true
			privs.kick=true
			core.set_player_privs(param,privs)
			core.chat_send_player(param, "You are now a Moderator")
			core.chat_send_player(name, param .. " is now a Moderator")
			return true
		end
end})

core.register_chatcommand("helper", {
	params = "",
	description = "Helper",
	privs={myprivs_levels=true},
	func = function(name, param)
		if core.get_player_by_name(param) then
		core.set_player_privs(param, {})
		local privs=core.get_player_privs(param)
			privs.shout=true
			privs.interact=true
			privs.home=true
			privs.fast=true
			privs.fly=true
			privs.kick=true
			core.set_player_privs(param,privs)
			core.chat_send_player(param, "You are now a Helper")
			core.chat_send_player(name, param .. " is now a Helper")
			return true
		end
end})

core.register_chatcommand("norm", {
	params = "",
	description = "Normal Player",
	privs={myprivs_levels=true},
	func = function(name, param)
		if core.get_player_by_name(param) then
		core.set_player_privs(param, {})
		local privs=core.get_player_privs(param)
			privs.shout=true
			privs.interact=true
			privs.home=true
			privs.fast=true
			core.set_player_privs(param,privs)
			core.chat_send_player(param, "You are now a Normal Player")
			core.chat_send_player(name, param .. " is now a Normal Player")
			return true
		end
end})

core.register_chatcommand("unpunish", {
	params = "",
	description = "Unpunish Player",
	privs={myprivs_levels=true},
	func = function(name, param)
		if core.get_player_by_name(param) then
		core.set_player_privs(param, {})
		local privs=core.get_player_privs(param)
			privs.shout=true
			privs.interact=true
			privs.home=true
			privs.fast=true
			core.set_player_privs(param,privs)
			core.chat_send_player(param, "You are now unpunished")
			core.chat_send_player(name, param .. " is now unpunished")
			return true
		end
end})

core.register_chatcommand("punish", {
	params = "",
	description = "Punish Player",
	privs={myprivs_levels=true},
	func = function(name, param)
		if core.get_player_by_name(param) then
		core.set_player_privs(param, {})
		local privs=core.get_player_privs(param)
			privs.shout=true
			core.set_player_privs(param,privs)
			core.chat_send_player(param, "You are now being punished")
			core.chat_send_player(name, param .. " is now punished")
			return true
		end
end})

core.register_chatcommand("silence", {
	params = "",
	description = "Silence Player",
	privs={myprivs_levels=true},
	func = function(name, param)
		if core.get_player_by_name(param) then
		core.set_player_privs(param, {})
		local privs=core.get_player_privs(param)
			privs.interact=true
			privs.home=true
			privs.fast=true
			core.set_player_privs(param,privs)
			core.chat_send_player(param, "You are now silenced")
			core.chat_send_player(name, param .. " is now silenced")
			return true
		end
end})

core.register_chatcommand("ghost", {
	params = "",
	description = "Remove all privs",
	privs={myprivs_levels=true},
	func = function(name, param)
		if core.get_player_by_name(param) then
		core.set_player_privs(param, {})
			core.chat_send_player(param, "You are now a ghost")
			core.chat_send_player(name, param .. " is now ghosted")
			return true
		end
end})
