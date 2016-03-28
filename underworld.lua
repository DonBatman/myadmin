--[[

check for stone when placing underworld?

set underworld teleporter and set meta

make a schematic for underworld

make lvm for schematic placement

decide if this should be a seperate mod



--]]
local tp = {}

minetest.register_node("myadmin:underworld", {
	description = "Underworld",
	tiles = {
		"default_sand.png^[colorize:#000000:255"
	},
	drawtype = "nodebox",
	paramtype = "light",
	groups = {oddly_breakable_by_hand = 1, not_in_creative_inventory = 1},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5625, -0.5, 0.4375, -0.4375, 1.5, 0.5625},
			{0.4375, -0.5, 0.4375, 0.5625, 1.5, 0.5625},
			{0.4375, -0.5, -0.5625, 0.5625, 1.5, -0.4375},
			{-0.5625, -0.5, -0.5625, -0.4375, 1.5, -0.4375},
			{-0.5625, -0.5, -0.5625, 0.5625, -0.4375, 0.5625},
			{-0.5625, 1.4375, -0.5625, 0.5625, 1.5, 0.5625},
		}
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5625, -0.5, 0.4375, -0.4375, 1.5, 0.5625},
			{0.4375, -0.5, 0.4375, 0.5625, 1.5, 0.5625},
			{0.4375, -0.5, -0.5625, 0.5625, 1.5, -0.4375},
			{-0.5625, -0.5, -0.5625, -0.4375, 1.5, -0.4375},
			{-0.5625, -0.5, -0.5625, 0.5625, -0.4375, 0.5625},
			{-0.5625, 1.4375, -0.5625, 0.5625, 1.5, 0.5625},
		}
	},
	on_place = function(itemstack, placer, pointed_thing)

		if minetest.get_player_privs(placer:get_player_name()).myadmin_levels_super == true then

		local pos = pointed_thing.above
		local top = { x = pos.x, y = pos.y + 1, z = pos.z }

			if top.name ~= air then
				minetest.chat_send_player(placer, "Not enough room!")
				return
			end

			minetest.set_node(pos, {name = "myadmin:underworld"})
			minetest.set_node(top, {name = "myadmin:underworld_block"})

			minetest.show_formspec(placer:get_player_name(),"fs",
					"size[6,5;]"..
					"field[1,1;4.5,1;name;Name;]"..
					"field[2,2.5;2,1;depth;Depth;]"..
					"button_exit[2,4;2,1;set;set]")

			minetest.register_on_player_receive_fields(function(player, fs, fields)
			local meta = minetest.get_meta(pos)
			local n = fields["name"]
			local d = fields["depth"]
				if tonumber(d) + pos.y > 15000 then
					d = 15000 + pos.y
				end
				if tonumber(d) + pos.y < 3000 then
					d = 3000 + pos.y
				end

				if d == "" or
					d == nil then
					d = 5000
				end

				if fields["name"] or
					fields["depth"] or
					fields["set"] then

					if fields["name"] ~= "" and
						fields["depth"] ~= "" then

						meta:set_string("name",n)
						meta:set_string("infotext",n.." Top at "..d)
						meta:set_string("depth",d)
						meta:set_string("torb","top")

						minetest.forceload_block({x = pos.x, y = pos.y - tonumber(d), z = pos.z})

						minetest.set_node({x = pos.x, y = pos.y - tonumber(d), z = pos.z}, {name = "myadmin:underworld"})
						minetest.set_node({x = pos.x, y = pos.y - tonumber(d) + 1, z = pos.z}, {name = "myadmin:underworld_block"})
						local dmeta = minetest.get_meta({x = pos.x, y = pos.y - tonumber(d), z = pos.z})
						dmeta:set_string("name",n.." Underworld")
						dmeta:set_string("infotext",n.." Underworld at "..d)
						dmeta:set_string("depth",d)
						dmeta:set_string("torb","bottom")
					end
				end
			end)
		end
	end,
	on_dig = function(pos, node, player)

		if minetest.get_player_privs(player:get_player_name()).myadmin_levels_super == true then

		local meta = minetest.get_meta(pos)
		local n = meta:get_string("torb")
		local below = tonumber(meta:get_string("depth"))
			--if below == nil then below = 1 end
		local b = { x = pos.x, y = pos.y - below, z = pos.z }
		local btop = { x = pos.x, y = pos.y - (below - 1), z = pos.z }

		local t = { x = pos.x, y = pos.y + below, z = pos.z }
		local ttop = { x = pos.x, y = pos.y + (below + 1), z = pos.z }

		local top = { x = pos.x, y = pos.y + 1, z = pos.z }

			if n == "top" then
				minetest.remove_node(pos)
				minetest.remove_node(top)
				minetest.remove_node(b)
				minetest.remove_node(btop)
			elseif n == "bottom" then
				minetest.remove_node(pos)
				minetest.remove_node(top)
				minetest.remove_node(t)
				minetest.remove_node(ttop)
			end
		end
	end,
})

minetest.register_node("myadmin:underworld_block", {
	tiles = {
		{name="myadmin_underworld_ani_blue.png", animation={type="vertical_frames",aspect_w=16, aspect_h=16, length=0.5}}
	},
	drawtype = "nodebox",
	paramtype = "light",
	walkable = false,
	pointable = false,
	light_source = 12,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.4375, -1.4375, -0.4375, 0.4375, 0.4375, 0.4375},
		}
	}
})
minetest.register_abm({
	nodenames = {"myadmin:underworld"},
	interval = 1,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		
		local meta = minetest.get_meta(pos)
		local t = meta:get_string("name")
		local depth = tonumber(meta:get_string("depth"))

		if depth == nil then return end

		local up = meta:get_string("torb")

		local objs = minetest.env:get_objects_inside_radius(pos, 1)
		for k, player in pairs(objs) do
		local p = player:get_player_name()
		if tp[p] == false then 
			return
		end

		tp[p] = true

			if up == "top" and p then
				tp[p] = false
				player:setpos({x = pos.x, y = pos.y - depth, z = pos.z})
				minetest.after(10, function()
					tp[p] = true
				end)
			else
				tp[p] = false
				player:setpos({x = pos.x, y = pos.y + depth, z = pos.z})
				minetest.after(10, function()
					tp[p] = true
				end)
			end
		end
	end	
})
