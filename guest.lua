if myadmin.guest == true then
minetest.register_on_prejoinplayer(function(name, ip)
	local n = string.find(string.lower(name),"guest")
	if n ~= nil then
		return "\nThe name Guest is not allowed\n\nPlease pick a Name."
	end
end)
end

if minetest.setting_getbool("disallow_empty_password") == false  or nil and
	myadmin.require_password == true then
		minetest.setting_setbool("disallow_empty_password", true)
elseif minetest.setting_getbool("disallow_empty_password") == true  or nil and
	myadmin.require_password == false then
		minetest.setting_setbool("disallow_empty_password", false)
end
