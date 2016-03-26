local servername = "My Server"

local f = assert(io.open(minetest.get_modpath("myadmin").."/rules.txt", "r"))
local the_text = f:read("*all")
	f:close()


minetest.register_on_joinplayer(function(player)

	if minetest.get_player_privs(player:get_player_name()).mysoundblocks ~= true then

		minetest.show_formspec(player:get_player_name(), "start_screen",

			"size[12,9;]"..
			"bgcolor[#0E1AD8;true]"..
			"textarea[0.5,0.5;11.5,8;name;;"..the_text.."]"..
			"label[4,7.5;Do you agree to follow the rules?]"..
			"button_exit[2,8;3,2;yes;YES]"..
			"button_exit[7,8;3,2;no;NO]")
	end

	minetest.register_on_player_receive_fields(function(player, start_screen, fields)
		local pname = player:get_player_name()

		if fields["yes"] then

			minetest.set_player_privs(pname, {shout,interact,home,fast})
			minetest.chat_send_player(pname, "Welcome to "..servername.." "..pname..". Have fun!")

		elseif fields["no"] then

			minetest.kick_player(pname, "You need to agree to the rules to play!")

		end

	end)

end)


