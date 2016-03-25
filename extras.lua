minetest.register_privilege("myadmin_extras", "Need to use the extras")

minetest.register_chatcommand("setbar", {
	params = "",
	description = "Sets the size of your hotbar. 1 - 16",
	privs = {myadmin_extras=true},
	func = function(name, param)
		if param == "" then
			minetest.chat_send_player(name, "Use a number from 1 - 16")
			return
		end
		if type(tonumber(param)) ~= "number" then
			minetest.chat_send_player(name, "This is not a number.")
			return
		end
		if tonumber(param) < 1 or tonumber(param) > 16 then
			minetest.chat_send_player(name, "The number of slots must be between 1 and 16.")
			return
		end
		local player = minetest.get_player_by_name(name)
		player:hud_set_hotbar_itemcount(tonumber(param))
		player:hud_set_hotbar_image("")
	end,
})
