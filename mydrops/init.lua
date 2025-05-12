local old_handle_node_drops = core.handle_node_drops

function core.handle_node_drops(pos, drops, player)

	if not player or player.is_fake_player then
		return old_handle_node_drops(pos, drops, player)
	end

	for i = 1, #drops do

		local drop = drops[i]

		if minetest.registered_items[drop] then
			core.add_item(pos, drop)
		end
	end
end
