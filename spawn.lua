if myadmin.spawn1_name  then
	if myadmin.spawn1_name ~= false then
		s1n = myadmin.spawn1_name
		s1 = myadmin.spawn1
	end

	if myadmin.spawn2_name ~= false then
		s2n = myadmin.spawn2_name
		s2 = myadmin.spawn2
	end

	if myadmin.spawn3_name ~= false then
		s3n = myadmin.spawn3_name
		s3 = myadmin.spawn3
	end

	if myadmin.spawn4_name ~= false then
		s4n = myadmin.spawn4_name
		s4 = myadmin.spawn4
	end

	if myadmin.spawn5_name ~= false then
		s5n = myadmin.spawn5_name
		s5 = myadmin.spawn5
	end
else
	return
end


minetest.register_on_chat_message(function(name, message, playername, player)
	if s1n ~= false then
		local cmd = "/"..s1n
		if message:sub(0, #cmd) == cmd then
			if message == '/'..s1n then
				local player = minetest.get_player_by_name(name)
				minetest.chat_send_player(player:get_player_name(), "Teleporting to "..s1n)
				player:setpos(s1)
				return true
			end
		end
	end

	if s2n ~= false then
		local cmd = "/"..s2n
		if message:sub(0, #cmd) == cmd then
			if message == '/'..s2n then
				local player = minetest.get_player_by_name(name)
				minetest.chat_send_player(player:get_player_name(), "Teleporting to "..s2n)
				player:setpos(s2)
				return true
			end
		end
	end

	if s3n ~= false then
		local cmd = "/"..s3n
		if message:sub(0, #cmd) == cmd then
			if message == '/'..s3n then
				local player = minetest.get_player_by_name(name)
				minetest.chat_send_player(player:get_player_name(), "Teleporting to "..s3n)
				player:setpos(s3)
				return true
			end
		end
	end

	if s4n ~= false then
		local cmd = "/"..s4n
		if message:sub(0, #cmd) == cmd then
			if message == '/'..s4n then
				local player = minetest.get_player_by_name(name)
				minetest.chat_send_player(player:get_player_name(), "Teleporting to "..s4n)
				player:setpos(s4)
				return true
			end
		end
	end

	if s5n ~= false then
		local cmd = "/"..s5n
		if message:sub(0, #cmd) == cmd then
			if message == '/'..s5n then
				local player = minetest.get_player_by_name(name)
				minetest.chat_send_player(player:get_player_name(), "Teleporting to "..s5n)
				player:setpos(s5)
				return true
			end
		end
	end


end)
