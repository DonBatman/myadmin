local bad_names = {}
local bad_names_file_path = core.get_modpath("mybadnames") .. "/bad_names.txt"

local function load_bad_names()
	local file, err = io.open(bad_names_file_path, "r")
	if err then
		return {}
	end
	local names = {}
	for line in file:lines() do
		local trimmed_line = line:match("^%s*(.-)%s*$")
		if trimmed_line ~= "" then
			table.insert(names, string.lower(trimmed_line))
		end
	end
	file:close()
	return names
end

bad_names = load_bad_names()

local function normalize_name(name)
	local lower_name = string.lower(name)
	local normalized = lower_name:gsub("[^%w]", "")
	return normalized
end

core.register_on_prejoinplayer(function(name, ip)
	local normalized_name = normalize_name(name)
	local player_file = core.get_worldpath() .. "/players/" .. name .. "/player.json"
	local file, err = io.open(player_file, "r")
	if file then
		file:close()
		return nil
	end
	if #bad_names == 0 then
		return nil
	end
	for _, bad_name in ipairs(bad_names) do
		if string.find(normalized_name, bad_name) then
			return "\nYour chosen name is not allowed. Please choose a different name."
		end
	end
	return nil
end)
