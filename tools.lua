
minetest.register_alias("ut", "myadmin:ultimate_tool")
minetest.register_alias("utd", "myadmin:ultimate_tool_drop")

minetest.register_tool("myadmin:ultimate_tool", {
	description = "Ultimate Tool",
	inventory_image = "ultimate_tool.png",
	groups = {not_in_creative_inventory=1},
	tool_capabilities = {
		full_punch_interval = 0.2,
		max_drop_level=3,
		groupcaps= {
			unbreakable={times={[1]=0, [2]=0, [3]=0}, uses=0, maxlevel=3},
			fleshy = {times={[1]=0, [2]=0, [3]=0}, uses=0, maxlevel=3},
			choppy={times={[1]=0, [2]=0, [3]=0}, uses=0, maxlevel=3},
			bendy={times={[1]=0, [2]=0, [3]=0}, uses=0, maxlevel=3},
			cracky={times={[1]=0, [2]=0, [3]=0}, uses=0, maxlevel=3},
			crumbly={times={[1]=0, [2]=0, [3]=0}, uses=0, maxlevel=3},
			snappy={times={[1]=0, [2]=0, [3]=0}, uses=0, maxlevel=3},
		}
	},
	on_drop = function(itemstack, dropper, pos)
	end
})
minetest.register_tool("myadmin:ultimate_tool_drop", {
	description = "Ultimate Tool With Drops",
	inventory_image = "ultimate_tool2.png",
	groups = {not_in_creative_inventory=1},
	tool_capabilities = {
		full_punch_interval = 0.2,
		max_drop_level=3,
		groupcaps= {
			unbreakable={times={[1]=0, [2]=0, [3]=0}, uses=0, maxlevel=3},
			fleshy = {times={[1]=0, [2]=0, [3]=0}, uses=0, maxlevel=3},
			choppy={times={[1]=0, [2]=0, [3]=0}, uses=0, maxlevel=3},
			bendy={times={[1]=0, [2]=0, [3]=0}, uses=0, maxlevel=3},
			cracky={times={[1]=0, [2]=0, [3]=0}, uses=0, maxlevel=3},
			crumbly={times={[1]=0, [2]=0, [3]=0}, uses=0, maxlevel=3},
			snappy={times={[1]=0, [2]=0, [3]=0}, uses=0, maxlevel=3},
		}
	},
	on_drop = function(itemstack, dropper, pos)
	end
})

minetest.register_on_punchnode(function(pos, node, puncher)
	local n = node
	if puncher:get_wielded_item():get_name() == "myadmin:ultimate_tool"
	and minetest.get_node(pos).name ~= "air" 
	and minetest.get_player_privs(puncher:get_player_name()).myadmin_levels_super == true then
		minetest.remove_node(pos)
	end

	if puncher:get_wielded_item():get_name() == "myadmin:ultimate_tool"
	or puncher:get_wielded_item():get_name() == "myadmin:ultimate_tool_drop"
	and minetest.get_node(pos).name ~= "air" then
		if minetest.get_player_privs(puncher:get_player_name()).myadmin_levels_super ~= true then
			minetest.chat_send_player(puncher:get_player_name(), "You don't have the priv for this tool")
			puncher:set_wielded_item("default:stick")
			minetest.set_node(pos,{name = node.name})
			return
		end
	end
end)


