minetest.register_on_chat_message(function(name, message, playername, player)
    local cmd ="/afk"
    if message:sub(0, #cmd) == cmd then
            if message == '/afk' then
            local player = minetest.env:get_player_by_name(name)
            minetest.chat_send_all(name.." is AFK! ")
            return true
        end
    end
    local cmd ="/back"
    if message:sub(0, #cmd) == cmd then
            if message == '/back' then
            local player = minetest.env:get_player_by_name(name)
            minetest.chat_send_all(name.." is Back! ")
            return true
        end
    end
    local cmd ="/happy"
    if message:sub(0, #cmd) == cmd then
            if message == '/happy' then
            local player = minetest.env:get_player_by_name(name)
            minetest.chat_send_all(name.." is Happy! ")
            return true
        end
    end
    local cmd ="/sad"
    if message:sub(0, #cmd) == cmd then
            if message == '/sad' then
            local player = minetest.env:get_player_by_name(name)
            minetest.chat_send_all(name.." is Sad! ")
            return true
        end
    end
    local cmd ="/here"
    if message:sub(0, #cmd) == cmd then
            if message == '/here' then
            local player = minetest.env:get_player_by_name(name)
            minetest.chat_send_all("The amazing "..name.." is here! ")
            return true
        end
    end
    local cmd ="/there"
    if message:sub(0, #cmd) == cmd then
            if message == '/there' then
            local player = minetest.env:get_player_by_name(name)
            minetest.chat_send_all(name.." is not there! "..name.." is here")
            return true
        end
    end
    local cmd ="/funny"
    if message:sub(0, #cmd) == cmd then
            if message == '/funny' then
            local player = minetest.env:get_player_by_name(name)
            minetest.chat_send_all(name.." is sooooooooooooooooooooooooooooo funny! ")
            return true
        end
    end
    local cmd ="/crazy"
    if message:sub(0, #cmd) == cmd then
            if message == '/crazy' then
            local player = minetest.env:get_player_by_name(name)
            minetest.chat_send_all(name.." is losing his mind! ")
            return true
        end
    end
    local cmd ="/max"
    if message:sub(0, #cmd) == cmd then
            if message == '/max' then
            local player = minetest.env:get_player_by_name(name)
            minetest.chat_send_all("Max is the greatest guy ever! Except for Batman. Batman is better!")
            return true
        end
    end
    local cmd ="/bat"
    if message:sub(0, #cmd) == cmd then
            if message == '/bat' then
            local player = minetest.env:get_player_by_name(name)
            minetest.chat_send_all("Batman is the greatest guy ever! Except for Max. Max is better!")
            return true
        end
    end
    local cmd ="/hurt"
    if message:sub(0, #cmd) == cmd then
            if message == '/hurt' then
            local player = minetest.env:get_player_by_name(name)
            minetest.chat_send_all(name.." is hurt!")
            return true
        end
    end
    local cmd ="/mine"
    if message:sub(0, #cmd) == cmd then
            if message == '/mine' then
            local player = minetest.env:get_player_by_name(name)
            minetest.chat_send_all(name.." is mining!")
            return true
        end
    end
end)
