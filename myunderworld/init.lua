local tp = {}
--if core.get_modpath("mybedrock") then
--local bedrock_depth = tonumber(core.settings:get("mybedrock.max_depth")) or -10000
--else
--bedrock_depth = -10000
--end

local default_min_depth = -10000
local default_max_depth = 100
local default_teleport_cooldown = 10

local settings = {
    min_depth = default_min_depth,
    max_depth = default_max_depth,
    teleport_cooldown = default_teleport_cooldown,
}

if core and core.settings then
    local function get_setting_val(key, default_val, is_int)
        local val = nil
        if is_int and core.settings.get_int then
            val = core.settings:get_int(key)
        end
        
        if val == nil and core.settings.get then
            local str_val = core.settings:get(key)
            if str_val ~= nil then
                if is_int then
                    val = tonumber(str_val)
                else
                    val = str_val
                end
            end
        end
        return val ~= nil and val or default_val
    end

    settings.min_depth = get_setting_val("myunderworld_min_depth", default_min_depth, true)
    settings.max_depth = get_setting_val("myunderworld_max_depth", default_max_depth, true)
    settings.teleport_cooldown = get_setting_val("myunderworld_teleport_cooldown", default_teleport_cooldown, true)
else
    
end

local function is_node_truly_empty(node_name)
    return node_name == "air" or node_name == "ignore" or node_name == "unnamed_entity"
end

local function clear_space_at_pos(pos)
    core.remove_node(pos)
    core.remove_node({x = pos.x, y = pos.y + 1, z = pos.z})
end

core.register_node("myunderworld:underworld", {
	description = "Underworld Portal",
	tiles = {
		"default_obsidian.png",
		"default_obsidian.png",
		"default_obsidian.png",
		"default_obsidian.png",
		"default_obsidian.png",
		"default_obsidian.png",
	},
	drawtype = "nodebox",
	paramtype = "light",
	walkable = false,
	pointable = true,
	light_source = 0,
	groups = {oddly_breakable_by_hand = 1, portal = 1},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.4375, 0.5},
			{-0.5, -0.4375, -0.5, -0.4375, 1.4375, -0.4375},
			{0.4375, -0.4375, -0.5, 0.5, 1.4375, -0.4375},
			{-0.5, -0.4375, 0.4375, -0.4375, 1.4375, 0.5},
			{0.4375, -0.4375, 0.4375, 0.5, 1.4375, 0.5},
			{-0.4375, 1.375, -0.5, 0.4375, 1.4375, -0.4375},
			{-0.4375, 1.375, 0.4375, 0.4375, 1.4375, 0.5},
			{-0.5, 1.375, -0.4375, -0.4375, 1.4375, 0.4375},
			{0.4375, 1.375, -0.4375, 0.5, 1.4375, 0.4375},
			{-0.5, 1.5, -0.5, 0.5, 1.4375, 0.5},
		}
	},


	on_place = function(itemstack, placer, pointed_thing)
		local pos = pointed_thing.above
		local top_block_pos = { x = pos.x, y = pos.y + 1, z = pos.z }

		if not is_node_truly_empty(core.get_node(top_block_pos).name) then
			core.chat_send_player(placer:get_player_name(), "Not enough room! Need 2 blocks of air above the placement spot.")
			return itemstack
		end

		core.set_node(pos, {name = "myunderworld:underworld"})
		core.set_node(top_block_pos, {name = "myunderworld:underworld_block"})

		local meta = core.get_meta(pos)
		meta:set_string("owner", placer:get_player_name())
		meta:set_string("infotext", "Underworld Portal (unconfigured)")

		core.show_formspec(placer:get_player_name(),"myunderworld:portal_config",
            "size[6,6;]"..
            "label[0.5,0.5;".."Configure your Underworld Portal".."]"..
            "field[1,1.5;4.5,1;name;".."Portal Name"..";"..
                (meta:get_string("name") or "").."]"..
            "field[1,2.5;4.5,1;depth;".."Target Depth (Y-coordinate)"..";"..
                (meta:get_string("depth") or "") .. "]"..
            "button_exit[2,4;2,1;set;".."Set".."]"..
            "label[0.5,4.5;".."Enter a name and the Y-coordinate for the linked portal below."
                .. " Min Y: " .. tostring(settings.min_depth) .. ", Max Y: " .. tostring(settings.max_depth) .. "]"
        )

        itemstack:take_item()
        return itemstack
    end,

    on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
        local meta = core.get_meta(pos)
        local owner_name = meta:get_string("owner")
        local placer_name = clicker:get_player_name()

        if owner_name == placer_name then
            core.show_formspec(placer_name, "myunderworld:portal_config",
                "size[6,6;]"..
                "label[0.5,0.5;".."Reconfigure your Underworld Portal".."]"..
                "field[1,1.5;4.5,1;name;".."Portal Name"..";"..
                    (meta:get_string("name") or "").."]"..
                "field[1,2.5;4.5,1;depth;".."Target Depth (Y-coordinate)"..";"..
                    (meta:get_string("depth") or "") .. "]"..
                "button_exit[2,4;2,1;set;".."Set".."]"..
                "label[0.5,4.5;".."Enter a name and the Y-coordinate for the linked portal below."
                    .. " Min Y: " .. tostring(settings.min_depth) .. ", Max Y: " .. tostring(settings.max_depth) .. "]"
            )
        else
            local portal_name = meta:get_string("name") or "(Unconfigured)"
            local linked_depth_str = meta:get_string("depth")
            local torb_status = meta:get_string("torb") or "top"
            local linked_coords = ""

            local linked_depth_val = tonumber(linked_depth_str)
            if linked_depth_val ~= nil then
                if torb_status == "top" then
                    linked_coords = " (Linked to Y: " .. tostring(linked_depth_val) .. ")"
                else
                    local original_depth_val = tonumber(meta:get_string("original_depth")) or 0
                    linked_coords = " (Linked to Y: " .. tostring(pos.y + original_depth_val) .. ")"
                end
            end
            core.chat_send_player(placer_name,
                "Portal Info: " .. portal_name .. " " .. linked_coords .. ". " .. "Owner: " .. tostring(owner_name or "None"))
        end
        return itemstack
    end,
		
	on_destruct = function(pos, oldnode, remover)
        core.chat_send_all("MyUnderworld: on_remove triggered for portal at " .. core.pos_to_string(pos))

        local meta = core.get_meta(pos)
        local torb = meta:get_string("torb")
        local linked_depth_str = meta:get_string("depth")
        local portal_name = meta:get_string("name") or "Unnamed Portal"

        core.remove_node({x = pos.x, y = pos.y + 1, z = pos.z}) 

        if linked_depth_str and torb then
            local target_pos_y
            if torb == "top" then
                target_pos_y = tonumber(linked_depth_str)
            else
                local original_depth_val = tonumber(meta:get_string("original_depth"))
                if original_depth_val then
                     target_pos_y = pos.y + original_depth_val
                else
                    core.chat_send_all("Part of portal '" .. portal_name .. "' removed at " .. core.pos_to_string(pos) .. ". " .. "Linked portal might remain.")
                    return
                end
            end

            local target_pos = { x = pos.x, y = target_pos_y, z = pos.z }
            local target_top_block_pos = { x = target_pos.x, y = target_pos.y + 1, z = target_pos.z }

            core.forceload_block(target_pos, true)
            core.after(0.5, function()
                local target_node_name = core.get_node(target_pos).name
                
                if target_node_name == "myunderworld:underworld" then
                    core.remove_node(target_pos)
                    core.remove_node(target_top_block_pos)
                    core.chat_send_all("Portal '" .. portal_name .. "' removed at " .. core.pos_to_string(pos) .. ". " .. "Its linked portal at " .. core.pos_to_string(target_pos) .. " was also removed.")
                else
                    core.chat_send_all("Portal '" .. portal_name .. "' removed at " .. core.pos_to_string(pos))-- .. ". " .. "Could not remove linked portal at " .. core.pos_to_string(target_pos) .. " (not found or not a portal).")
                end
                core.forceload_block(target_pos, false)
            end)
        else
            core.chat_send_all("Unlinked portal '" .. portal_name .. "' removed at " .. core.pos_to_string(pos) .. ".")
        end
    end
})

core.register_node("myunderworld:underworld_block", {
	tiles = {
		{name="myunderworld_ani_blue.png", animation={type="vertical_frames",aspect_w=16, aspect_h=16, length=0.5}}
	},
	description = "Underworld Portal Block",
	drawtype = "nodebox",
	paramtype = "light",
	walkable = false,
	pointable = false,
	light_source = 12,
	groups = {oddly_breakable_by_hand = 1, not_in_creative_inventory = 1},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.4375, -1.4375, -0.4375, 0.4375, 0.4375, 0.4375},
		}
	}
})

core.register_on_player_receive_fields(function(player, formname, fields)
    if formname ~= "myunderworld:portal_config" then
        return
    end

    local player_name = player:get_player_name()
    local pos_to_check = player:get_pos()
    local pos = core.find_node_near(pos_to_check, 2, "myunderworld:underworld")

    if not pos then
        core.chat_send_player(player_name, "Error: Portal not found near you. Make sure you are standing near it.")
        return true
    end

    local meta = core.get_meta(pos)
    local owner = meta:get_string("owner")

    if owner ~= player_name then
        core.chat_send_player(player_name, "You are not the owner of this portal and cannot configure it.")
        return true
    end

    if fields["set"] then
        local n = fields["name"]
        local d_str = fields["depth"]
        local target_y = tonumber(d_str)

        if not n or n == "" then
            core.chat_send_player(player_name, "Portal name cannot be empty!")
            return false
        end
        if not target_y or d_str == "" or target_y < settings.min_depth or target_y > settings.max_depth then
            core.chat_send_player(player_name,
                "Invalid depth! Please enter a number between " .. tostring(settings.min_depth) .. " and " .. tostring(settings.max_depth) .. ".")
            return false
        end

        local target_pos = { x = pos.x, y = target_y, z = pos.z }
        local target_top_block_pos = { x = target_pos.x, y = target_pos.y + 1, z = target_pos.z }

        local existing_underworld_node = core.get_node(target_pos).name
        if existing_underworld_node == "myunderworld:underworld" then
            core.chat_send_player(player_name, "Cannot link: Another Underworld Portal already exists at " .. core.pos_to_string(target_pos) .. ".")
            return false
        end
        local existing_underworld_block_above = core.get_node(target_top_block_pos).name
        if existing_underworld_block_above == "myunderworld:underworld_block" then
            core.chat_send_player(player_name, "Cannot link: Another Underworld Portal (part) exists at " .. core.pos_to_string(target_top_block_pos) .. ".")
            return false
        end

        meta:set_string("name", n)
        meta:set_string("infotext", n .. " (Top Portal at Y: " .. tostring(pos.y) .. ")")
        meta:set_string("depth", tostring(target_y))
        meta:set_string("torb", "top")
        meta:set_string("original_depth", tostring(pos.y - target_y))

        core.chat_send_player(player_name, "Portal '" .. n .. "' configured. Linking to Y: " .. tostring(target_y) .. ".")

        core.forceload_block(target_pos, true)

        core.after(2, function()
            core.after(1, function()
                core.set_node(target_pos, {name = "myunderworld:underworld"})
                core.set_node(target_top_block_pos, {name = "myunderworld:underworld_block"})

                local dmeta = core.get_meta(target_pos)
                dmeta:set_string("name", n .. " (Underworld Portal)")
                dmeta:set_string("infotext", n .. " (Bottom Portal at Y: " .. tostring(target_y) .. ")")
                dmeta:set_string("depth", tostring(pos.y))
                dmeta:set_string("torb", "bottom")
                dmeta:set_string("owner", player_name)
                dmeta:set_string("original_depth", tostring(pos.y - target_y))

                core.chat_send_player(player_name, "Linked portal created for '" .. n .. "' at " .. core.pos_to_string(target_pos) .. ".")
                core.forceload_block(target_pos, false)
            end)
        end)
    end
    return true
end)

core.register_abm({
	nodenames = {"myunderworld:underworld"},
	interval = 1,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		
		local meta = core.get_meta(pos)
		local portal_name = meta:get_string("name")
		local linked_y_str = meta:get_string("depth")
		local torb = meta:get_string("torb")

		if not portal_name or not linked_y_str or not torb then
			return
		end
		local linked_y = tonumber(linked_y_str)
		if not linked_y then
            return
        end

		local objs = core.get_objects_inside_radius(pos, 1)

		for _, obj in pairs(objs) do
            if not obj:is_player() then
                goto continue_loop
            end

            local player = obj
            local p_name = player:get_player_name()

            if tp[p_name] == false then
                goto continue_loop
            end

            tp[p_name] = false

            local target_pos_base
            if torb == "top" then
                target_pos_base = { x = pos.x, y = linked_y, z = pos.z }
            else
                local original_depth_val = tonumber(meta:get_string("original_depth"))
                if original_depth_val then
                    target_pos_base = { x = pos.x, y = pos.y + original_depth_val, z = pos.z }
                else
                    target_pos_base = { x = pos.x, y = linked_y, z = pos.z }
                end
            end

            player:set_pos(target_pos_base)
            core.chat_send_player(player:get_player_name(), "Teleported through portal '" .. portal_name .. "'!")

            core.after(settings.teleport_cooldown, function()
                tp[p_name] = true
            end)
            ::continue_loop::
        end
	end	
})
