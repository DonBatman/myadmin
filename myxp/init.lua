local storage = minetest.get_mod_storage()
local player_huds = {}

myxp = {}

function myxp.get_xp(name)
    return storage:get_int(name) or 0
end

function myxp.set_xp(name, amount)
    storage:set_int(name, tonumber(amount) or 0)
    local player = minetest.get_player_by_name(name)
    if player then
        myxp.update_hud(player)
    end
end

function myxp.add_xp(name, amount)
    if not name or type(name) ~= "string" then return end
    local current = myxp.get_xp(name)
    local added = tonumber(amount) or 1
    myxp.set_xp(name, current + added)
end

function myxp.update_hud(player)
    if not player or not player:is_player() then return end
    
    local name = player:get_player_name()
    local xp = myxp.get_xp(name)
    
    if player_huds[name] then
        pcall(function()
            player:hud_change(player_huds[name], "text", "XP: " .. xp)
        end)
    else
        player_huds[name] = player:hud_add({
            hud_elem_type = "text",
            position = {x = 0, y = 1},
            offset = {x = 40, y = -40},
            text = "XP: " .. xp,
            alignment = {x = 1, y = 0},
            number = 0x32CD32,
            scale = {x = 100, y = 100},
        })
    end
end

minetest.register_on_dignode(function(pos, oldnode, digger)
    if not digger or not digger:is_player() then return end
    myxp.add_xp(digger:get_player_name(), 1)
end)

minetest.register_on_placenode(function(pos, newnode, placer)
    if not placer or not placer:is_player() then return end
    myxp.add_xp(placer:get_player_name(), 1)
end)

minetest.register_on_craft(function(itemstack, crafter, recipe, inventory)
    if not crafter or not crafter:is_player() then return end
    myxp.add_xp(crafter:get_player_name(), itemstack:get_count())
end)

if minetest.register_on_metadata_inventory_take then
    minetest.register_on_metadata_inventory_take(function(pos, listname, index, stack, player)
        if player and player:is_player() then
            if listname == "dst" or listname == "main" then
                myxp.add_xp(player:get_player_name(), stack:get_count())
            end
        end
    end)
else
    minetest.register_on_mods_loaded(function()
        local function override_furnace(name)
            local node = minetest.registered_nodes[name]
            if node then
                local old_take = node.on_metadata_inventory_take
                minetest.override_item(name, {
                    on_metadata_inventory_take = function(pos, listname, index, stack, player)
                        if player and player:is_player() and listname == "dst" then
                            myxp.add_xp(player:get_player_name(), stack:get_count())
                        end
                        if old_take then
                            return old_take(pos, listname, index, stack, player)
                        end
                    end
                })
            end
        end
        override_furnace("default:furnace")
        override_furnace("default:furnace_active")
    end)
end

minetest.register_on_joinplayer(function(player)
    minetest.after(0.5, function()
        if minetest.get_player_by_name(player:get_player_name()) then
            myxp.update_hud(player)
        end
    end)
end)

minetest.register_on_leaveplayer(function(player)
    player_huds[player:get_player_name()] = nil
end)

minetest.register_chatcommand("rank", {
    description = "Show player rankings",
    func = function(name)
        local data = storage:to_table().fields
        local players = {}
        for pname, xp in pairs(data) do
            table.insert(players, {name = pname, xp = tonumber(xp) or 0})
        end
        table.sort(players, function(a, b) return a.xp > b.xp end)
        
        local list_items = ""
        for i, p in ipairs(players) do
            if i > 50 then break end
            list_items = list_items .. "#" .. i .. " " .. p.name .. " (" .. p.xp .. " XP),"
        end
        
        local formspec = "size[6,8]bgcolor[#000000AA;true]" ..
            "label[1.8,0.5;--- Global Rankings ---]" ..
            "textlist[0.5,1.2;5,5.5;leaderboard;" .. (list_items ~= "" and list_items:sub(1, -2) or "No data yet") .. "]" ..
            "button_exit[2,7.2;2,0.8;close;Close]"
        minetest.show_formspec(name, "myxp:rankings", formspec)
        return true
    end,
})
