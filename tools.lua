
minetest.register_alias("ut", "myadmin:ultimate_tool")
minetest.register_alias("utd", "myadmin:ultimate_tool_drop")

minetest.register_tool("myadmin:ultimate_tool", {
	description = "Ultimate Tool",
	inventory_image = "ultimate_tool.png",
	groups = {not_in_creative_inventory=1},
	tool_capabilities = {
		full_punch_interval = 0,
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
})
minetest.register_tool("myadmin:ultimate_tool_drop", {
	description = "Ultimate Tool With Drops",
	inventory_image = "ultimate_tool2.png",
	groups = {not_in_creative_inventory=1},
	tool_capabilities = {
		full_punch_interval = 0,
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
})
minetest.register_on_punchnode(function(pos, node, puncher)
	if puncher:get_wielded_item():get_name() == "myadmin:ultimate_tool"
	and minetest.env: get_node(pos).name ~= "air" then
		minetest.env:remove_node(pos)
	end
end)


