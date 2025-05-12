-- If not using then set the name to nil

-- Spawn 1
local s1n = "spawn1"
local s1 = {x = 0, y = 0, z = 0}

-- Spawn 2
local s2n = "spawn2"
local s2 = {x = 0, y = 0, z = 0}

--Spawn 3
local s3n = "spawn3"
local s3 = {x = 0, y = 0, z = 0}

-- Spawn 4
local s4n = nil
local s4 = {x = 0, y = 0, z = 0}

-- Spawn 5
local s5n = nil
local s5 = {x = 0, y = 0, z = 0}

-- Nothing to change past here
minetest.register_on_chat_message(function(name, message, playername, player)
	if s1n ~= nil then
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

	if s2n ~= nil then
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

	if s3n ~= nil then
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

	if s4n ~= nil then
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

	if s5n ~= nil then
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
