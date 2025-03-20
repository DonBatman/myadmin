local admin_privilege = minetest.settings:get("myadmintools.admin_privilege") or "server"

local function register_ultimate_tool(name, description, image, drops)
    minetest.register_tool(name, {
        description = description,
        inventory_image = image,
        groups = {not_in_creative_inventory = 1},
        tool_capabilities = {
            full_punch_interval = 0.2,
            max_drop_level = 3,
            groupcaps = {
                unbreakable = {times = {[1] = 0, [2] = 0, [3] = 0}, uses = 0, maxlevel = 3},
                fleshy = {times = {[1] = 0, [2] = 0, [3] = 0}, uses = 0, maxlevel = 3},
                choppy = {times = {[1] = 0, [2] = 0, [3] = 0}, uses = 0, maxlevel = 3},
                bendy = {times = {[1] = 0, [2] = 0, [3] = 0}, uses = 0, maxlevel = 3},
                cracky = {times = {[1] = 0, [2] = 0, [3] = 0}, uses = 0, maxlevel = 3},
                crumbly = {times = {[1] = 0, [2] = 0, [3] = 0}, uses = 0, maxlevel = 3},
                snappy = {times = {[1] = 0, [2] = 0, [3] = 0}, uses = 0, maxlevel = 3},
            }
        },
        on_drop = function(itemstack, dropper, pos)
            if not drops then
              dropper:remove_item(itemstack);
              minetest.chat_send_player(dropper:get_player_name(), "This tool cannot be dropped.")
            end
        end,
    })
end

register_ultimate_tool("myadmintools:ut", "Ultimate Tool", "ultimate_tool.png", false) -- No drops
register_ultimate_tool("myadmintools:utd", "Ultimate Tool (Drops)", "ultimate_tool2.png", true) -- Drops allowed

minetest.register_alias("ut", "myadmintools:ut")
minetest.register_alias("utd", "myadmintools:utd")

minetest.register_on_punchnode(function(pos, node, puncher)
    local player_name = puncher:get_player_name()

    if not minetest.get_player_privs(player_name)[admin_privilege] then
        minetest.chat_send_player(player_name, "You don't have the required privilege for this tool.")
        puncher:set_wielded_item("default:stick")
        return
    end

    local wielded_item = puncher:get_wielded_item()
    if wielded_item:get_name() == "myadmintools:ut" or wielded_item:get_name() == "myadmintools:utd" then
        if node.name ~= "air" then
            minetest.remove_node(pos)
        end
    end
end)
