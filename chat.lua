
minetest.register_chatcommand("chats", {
	privs = {shout = true},
	func = function(name, param)
		minetest.chat_send_player(name,"Available commands - /afk, /back, /here, /there, /happy, /sad, /surprised, /mad, /funny, /crazy, /hurt, /mining")
		return true
	end,
})
minetest.register_chatcommand("afk", {
	privs = {shout = true},
	func = function(name, param)
		minetest.chat_send_all(name.." is AFK! ")
		return true
	end,
})
minetest.register_chatcommand("back", {
	privs = {shout = true},
	func = function(name, param)
		minetest.chat_send_all(name.." is Back! ")
		return true
	end,
})
minetest.register_chatcommand("gtg", {
	privs = {shout = true},
	func = function(name, param)
		minetest.chat_send_all(name.." needs to go now. Bye!")
		return true
	end,
})
minetest.register_chatcommand("bbl", {
	privs = {shout = true},
	func = function(name, param)
		minetest.chat_send_all(name.." is leaving and will be back later.")
		return true
	end,
})
minetest.register_chatcommand("lol", {
	privs = {shout = true},
	func = function(name, param)
		minetest.chat_send_all(name.." is laughing out loud! Ha Ha Ha Ha Ha Ha Ha ")
		return true
	end,
})
minetest.register_chatcommand("happy", {
	privs = {shout = true},
	func = function(name, param)
		minetest.chat_send_all(name.." is Happy! ")
		return true
	end,
})
minetest.register_chatcommand("sad", {
	privs = {shout = true},
	func = function(name, param)
		minetest.chat_send_all(name.." is Sad! ")
		return true
	end,
})
minetest.register_chatcommand("surprised", {
	privs = {shout = true},
	func = function(name, param)
		minetest.chat_send_all(name.." is Surprised! ")
		return true
	end,
})
minetest.register_chatcommand("mad", {
	privs = {shout = true},
	func = function(name, param)
		minetest.chat_send_all(name.." is Soooooooooo Mad! ")
		return true
	end,
})

minetest.register_chatcommand("here", {
	privs = {shout = true},
	func = function(name, param)
		minetest.chat_send_all("The amazing "..name.." is here! ")
		return true
	end,
})
minetest.register_chatcommand("there", {
	privs = {shout = true},
	func = function(name, param)
		minetest.chat_send_all(name.." is not there! "..name.." is here")
		return true
	end,
})
minetest.register_chatcommand("funny", {
	privs = {shout = true},
	func = function(name, param)
		minetest.chat_send_all(name.." is soooooooooooo funny! ")
		return true
	end,
})
minetest.register_chatcommand("crazy", {
	privs = {shout = true},
	func = function(name, param)
		minetest.chat_send_all(name.." is losing their mind! ")
		return true
	end,
})
minetest.register_chatcommand("hurt", {
	privs = {shout = true},
	func = function(name, param)
		minetest.chat_send_all(name.." is hurt! ")
		return true
	end,
})
minetest.register_chatcommand("mining", {
	privs = {shout = true},
	func = function(name, param)
		minetest.chat_send_all(name.." is Mining! ")
		return true
	end,
})
minetest.register_chatcommand("max", {
	privs = {shout = true},
	func = function(name, param)
		minetest.chat_send_all("Max is the greatest guy ever! Except for Batman. Batman is better!")
		return true
	end,
})
minetest.register_chatcommand("bat", {
	privs = {shout = true},
	func = function(name, param)
		minetest.chat_send_all("Batman is the greatest guy ever! Except for Max. Max is better!")
		return true
	end,
})
