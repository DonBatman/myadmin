local bad_names = {
    "fuck",
    "faggot",
    "asshole",
    "arsehole",
    "cunt",
    "retard",
    "bitch",
    "shit",
    "bastard",
    "nigger",
    "nigga",
    "guest"
}

local function normalize_name(name)
    return string.lower(name:gsub("[^%w]", ""))
end

minetest.register_on_prejoinplayer(function(name, ip)
    local normalized_name = normalize_name(name)

    local player_file = minetest.get_worldpath() .. "/players/" .. name
    local file, err = io.open(player_file, "r")
    if file then
        file:close()
        return
    end

    for _, bad_name in ipairs(bad_names) do
        if string.find(normalized_name, bad_name) then
            return "\nYour chosen name is not allowed. Please choose a different name."
        end
    end

    return
end)
