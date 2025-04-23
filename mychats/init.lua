local emotes = {
    afk = "is AFK!",
    back = "is back!",
    gtg = "needs to go now. Bye!",
    bbl = "is leaving and will be back later.",
    lol = "is laughing out loud! Ha Ha Ha Ha Ha Ha Ha",
    happy = "is happy!",
    sad = "is sad!",
    surprised = "is surprised!",
    mad = "is soooooooo mad!",
    here = "is here!",
    there = "is not there! is here",
    funny = "is soooooooooooo funny!",
    crazy = "is losing their mind!",
    hurt = "is hurt!",
    mining = "is mining!",
}

local function handle_emote(player_name, emote_name)
    local emote_message = emotes[emote_name]
    if emote_message then
        core.chat_send_all(player_name .. " " .. emote_message)
    else
        core.chat_send_player(player_name, "Invalid emote.")
    end
end

core.register_chatcommand("emote", {
    privs = { shout = true },
    params = "<emote>",
    func = function(player_name, emote_name)
        handle_emote(player_name, emote_name)
        return true
    end,
})

core.register_chatcommand("emotes", {
    privs = { shout = true },
    func = function(player_name, _)
        local emote_list = ""
        for emote_name, _ in pairs(emotes) do
            emote_list = emote_list .. "/" .. emote_name .. ", "
        end
        core.chat_send_player(player_name, "Available emotes: " .. emote_list:sub(1, #emote_list - 2))
        return true
    end,
})

for emote_name, _ in pairs(emotes) do
    core.register_chatcommand(emote_name, {
        privs = { shout = true },
        func = function(player_name, _)
            handle_emote(player_name, emote_name)
            return true
        end,
    })
end
