spawn = {x = 0, y = 0, z = 0}
deep = {x = 0, y = -10000, z = 0}
minetest.register_on_chat_message(function(name, message, playername, player)
    local cmd = "/spawn"
    if message:sub(0, #cmd) == cmd then
        if message == '/spawn' then
        local player = minetest.env:get_player_by_name(name)
        minetest.chat_send_player(player:get_player_name(), "Teleporting to Spawn...")
        player:setpos(spawn)
        return true
        end
    end
    local cmd = "/deep"
    if message:sub(0, #cmd) == cmd then
        if message == '/deep' then
        local player = minetest.env:get_player_by_name(name)
        minetest.chat_send_player(player:get_player_name(), "Teleporting to far underground...")
        player:setpos(deep)
        return true
        end
    end
end)
