local admin_privilege = minetest.settings:get("myadmintools.admin_privilege") or "server"
local bypass_protection_privilege = minetest.settings:get("myadmintools.bypass_protection_privilege") or "server"
local fallback_item = minetest.settings:get("myadmintools.fallback_item") or "default:stick"
local area_size = tonumber(minetest.settings:get("myadmintools.area_size")) or 5

local player_tool_mode = {}

local default_tool_groupcap = {times = {[1] = 0, [2] = 0, [3] = 0}, uses = 0, maxlevel = 3}
local all_group_caps = {}
local groups_to_break = {
    "unbreakable", "fleshy", "choppy", "bendy",
    "cracky", "crumbly", "snappy", "falling_node"
}
for _, group_name in ipairs(groups_to_break) do
    all_group_caps[group_name] = default_tool_groupcap
end

local function register_ultimate_tool(name, description, image, drops_allowed)
    minetest.register_tool(name, {
        description = description,
        inventory_image = image,
        groups = {not_in_creative_inventory = 1},
        tool_capabilities = {
            full_punch_interval = 0.1,
            max_drop_level = 3,
            groupcaps = all_group_caps,
        },
        on_drop = function(itemstack, dropper, pos)
            if not drops_allowed then
                if dropper and type(dropper.remove_item) == "function" then
                    dropper:remove_item("myadmintools:ut", itemstack, false);
                    minetest.chat_send_player(dropper:get_player_name(), "This tool cannot be dropped.")
                else
                     minetest.chat_send_all("DEBUG: Ultimate Tool dropped unexpectedly. Please report this issue.")
                end
                return nil
            end
            return itemstack
        end,
        on_place = function(itemstack, placer, pointed_thing)
            local player_name = placer:get_player_name()

            if not minetest.get_player_privs(player_name)[admin_privilege] then
                minetest.chat_send_player(player_name, "You don't have the '" .. admin_privilege .. "' privilege to use this tool's modes.")
                return itemstack
            end

            local current_mode = player_tool_mode[player_name] or "dig"
            local next_mode

            if current_mode == "dig" then
                next_mode = "area_dig"
            else
                next_mode = "dig"
            end

            player_tool_mode[player_name] = next_mode
            local mode_message = "Ultimate Tool mode: " .. next_mode
            if next_mode == "area_dig" then
                 mode_message = mode_message .. ". Area size: " .. area_size .. "x" .. area_size .. "x" .. area_size
            end

            minetest.chat_send_player(player_name, mode_message)

            return itemstack
        end,
    })
end

register_ultimate_tool("myadmintools:ut", "Ultimate Tool", "ultimate_tool.png", false)
register_ultimate_tool("myadmintools:utd", "Ultimate Tool (Drops)", "ultimate_tool2.png", true)

minetest.register_alias("ut", "myadmintools:ut")
minetest.register_alias("utd", "myadmintools:utd")

local function get_area_pos(center_pos, size)
    local positions = {}
    local half_size = math.floor(size / 2)
    for x = center_pos.x - half_size, center_pos.x + half_size do
        for y = center_pos.y - half_size, center_pos.y + half_size do
            for z = center_pos.z - half_size, center_pos.z + half_size do
                table.insert(positions, {x = x, y = y, z = z})
            end
        end
    end
    return positions
end

minetest.register_on_punchnode(function(pos, node, puncher)
    if not puncher then
        return
    end

    local player_name = puncher:get_player_name()
    local wielded_item = puncher:get_wielded_item()
    local wielded_item_name = wielded_item:get_name()

    if wielded_item_name == "myadmintools:ut" or wielded_item_name == "myadmintools:utd" then
        if not minetest.get_player_privs(player_name)[admin_privilege] then
            minetest.chat_send_player(player_name, "You don't have the '" .. admin_privilege .. "' privilege to use this tool. Your item has been replaced with a stick.")
            puncher:set_wielded_item(fallback_item)
            return true
        end

        local current_mode = player_tool_mode[player_name] or "dig"

        local should_drop_items = (wielded_item_name == "myadmintools:utd")

        if current_mode == "dig" then
            if node.name ~= "air" then
                if minetest.is_protected(pos, player_name) and not minetest.get_player_privs(player_name)[bypass_protection_privilege] then
                    minetest.chat_send_player(player_name, "This area is protected.")
                else
                    minetest.remove_node(pos)

                    if should_drop_items then
                        local drops = minetest.get_node_drops(node.name)
                        local spawn_pos = {x = pos.x, y = pos.y + 1, z = pos.z}
                        for _, itemstack in ipairs(drops) do
                            minetest.spawn_item(spawn_pos, itemstack)
                        end
                    end
                end
            end
            return true

        elseif current_mode == "area_dig" then
            if node.name ~= "air" then
                 local positions_to_dig = get_area_pos(pos, area_size)
                 local nodes_removed = 0
                 for _, p in ipairs(positions_to_dig) do
                     if not minetest.is_protected(p, player_name) or minetest.get_player_privs(player_name)[bypass_protection_privilege] then
                         local node_at_p = minetest.get_node(p)
                         if node_at_p.name ~= "air" then
                             minetest.remove_node(p)

                             if should_drop_items then
                                 local drops = minetest.get_node_drops(node_at_p.name)
                                 local spawn_pos = {x = p.x, y = p.y + 1, z = p.z}
                                 for _, itemstack in ipairs(drops) do
                                     minetest.spawn_item(spawn_pos, itemstack)
                                 end
                             end
                             nodes_removed = nodes_removed + 1
                         end
                     end
                 end
                 minetest.chat_send_player(player_name, "Area Dig: Removed " .. nodes_removed .. " nodes.")
            end
            return true
        end

        return true

    else
        return nil
    end
end)

minetest.register_chatcommand("ut_size", {
    privs = { [admin_privilege] = true },
    description = "Sets the area size for Ultimate Tool operations. Usage: /ut_areasize <size>",
    params = "<size>",
    func = function(name, param)
        local player = minetest.get_player_by_name(name)
        if not player then return false end

        local size = tonumber(param)
        if size and size > 0 and size <= 30 then
            area_size = size
            minetest.chat_send_player(name, "Ultimate Tool area size set to " .. area_size .. ".")
        else
            minetest.chat_send_player(name, "Invalid size. Please provide a positive number up to 30.")
        end
        return true
    end,
})

minetest.register_chatcommand("ut_info", {
    privs = { [admin_privilege] = true },
    description = "Shows your current Ultimate Tool settings.",
    func = function(name, param)
        local player = minetest.get_player_by_name(name)
        if not player then return false end

        local current_mode = player_tool_mode[name] or "dig"

        local info_message = "Ultimate Tool Info:\n"
        info_message = info_message .. "  Mode: " .. current_mode .. "\n"
        if current_mode == "area_dig" then
             info_message = info_message .. ". Area size: " .. area_size .. "x" .. area_size .. "x" .. area_size
        end
        info_message = info_message .. "\nRequired Privilege: '" .. admin_privilege .. "'"
        info_message = info_message .. "\nBypass Protection Privilege: '" .. bypass_protection_privilege .. "'"
        info_message = info_message .. "\nFallback Item: '" .. fallback_item .. "'"

        minetest.chat_send_player(name, info_message)
        return true
    end,
})
