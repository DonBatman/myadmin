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
		player:hud_set_hotbar_image("")
		core.chat_send_player(name, "Hotbar has been set!")
	end,
})
