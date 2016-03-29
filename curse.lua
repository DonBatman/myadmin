 local bad_words = myadmin.bad_words
 if bad_words == nil then
	bad_words = {
"fuck",
"faggot",
"fag",
"gay",
"asshole",
"arsehole",
"dick",
"cunt",
"wtf",
"retard",
"bitch",
"shit",
"bastard",
"nigger",
"nigga"
}
end
minetest.register_on_chat_message(function(name, message)
	if not message then return end
	local msg = message:lower()
		for _, word in pairs(bad_words) do
			if msg:find(word) then
				minetest.kick_player(name, "( ** WATCH YOUR LANGUAGE ** )")
				return
			end
		end
	end)
