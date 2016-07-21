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
		"guest",
		"sadie"
		}

for _, nm in pairs(bad_names) do

minetest.register_on_prejoinplayer(function(name, ip)
	local n = string.find(string.lower(name),nm)
	local wp, err = io.open(minetest.get_worldpath().."/players/"..name, "r")
	if wp then 
		wp:close()
		return
	end
	if n ~= nil then
		return "\nThe name .."..name.." is not allowed\n\nPlease pick a different Name."
	end
end)

end
