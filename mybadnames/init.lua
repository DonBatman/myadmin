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

for _, nm in pairs(bad_names) do

minetest.register_on_prejoinplayer(function(name, ip)
	local n = string.find(string.lower(name),nm)
	if n ~= nil then
		return "\nThe name .."..name.." is not allowed\n\nPlease pick a different Name."
	end
end)

end
