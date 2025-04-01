local bedmin = tonumber(core.settings:get("mybedrock.depth")) or -11000
local bedmax = tonumber(core.settings:get("mybedrock.max_depth")) or -10000

minetest.register_node("mybedrock:bedrock", {
	description = "Bedrock",
	tiles = {"mybedrock_bedrock.png"},
	groups = {unbreakable = 1, not_in_creative_inventory = 1},
})
minetest.register_ore({
	ore_type = "scatter",
	ore = "mybedrock:bedrock",
	wherein = "default:stone",
	clust_scarcity = 1*1*1,
	clust_num_ores = 5,
	clust_size = 5,
	height_min = bedmin,
	height_max = bedmax,
})
