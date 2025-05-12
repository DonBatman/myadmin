local core = minetest

local pickup_radius = tonumber(core.settings:get("mypickup.pickup_radius")) or 1.0
local item_pickup_speed = tonumber(core.settings:get("mypickup.item_pickup_speed")) or 20
local minimum_pickup_distance = tonumber(core.settings:get("mypickup.minimum_pickup_distance")) or 0.35
local full_inventory_stuck_range = tonumber(core.settings:get("mypickup.full_inventory_stuck_range")) or 2.0

local inventory_full_message = core.settings:get("mypickup.inventory_full_message") or "Your inventory is full! %s %s not picked up."

local active_pickup_sounds = {}

local function play_pickup_sound(player_name)
    if not active_pickup_sounds[player_name] then
        local sound_duration = 0.3
        active_pickup_sounds[player_name] = {time_remaining = sound_duration}

        core.sound_play({
            name = "aio_digndrop_pickup_sound",
            gain = 0.3,
            pitch = math.random(80, 120) / 100,
            to_player = player_name,
        })
    end
end

core.register_globalstep(function(delta_time)
    local players = core.get_connected_players()
    if players then
        for player_name, sound_data in pairs(active_pickup_sounds) do
            sound_data.time_remaining = sound_data.time_remaining - delta_time
            if sound_data.time_remaining <= 0 then
                active_pickup_sounds[player_name] = nil
            end
        end

        for _, player in ipairs(players) do
            local player_position = player:get_pos()
            local player_name = player:get_player_name()

            local search_position = vector.add(player_position, vector.new(0, 0, 0))

            for object in core.objects_inside_radius(search_position, pickup_radius) do
                if object and not object:is_player() and object:get_luaentity() and object:get_luaentity().name == "__builtin:item" then
                    local item_entity = object:get_luaentity()
                    local item_stack = ItemStack(item_entity.itemstring)
                    local object_position = object:get_pos()

                    local direction = vector.subtract(player_position, object_position)
                    local distance = vector.length(direction)

                    local apply_magnetic_pull = true
                    if item_entity.full_inventory_stopped then
                        local dist_to_stuck_pos = vector.distance(player_position, item_entity.stuck_position or player_position)
                        if dist_to_stuck_pos <= full_inventory_stuck_range then
                             apply_magnetic_pull = false
                             object:set_velocity({x=0, y=0, z=0})
                        else
                            item_entity.full_inventory_stopped = nil
                            item_entity.stuck_position = nil
                        end
                    end

                    if distance <= minimum_pickup_distance then
                        local remaining_item = player:get_inventory():add_item("main", item_stack)
                        
                        if remaining_item:is_empty() then
                            object:remove()
                            play_pickup_sound(player_name)
                            item_entity.full_inventory_stopped = nil
                            item_entity.stuck_position = nil
                        else
                            item_entity.itemstring = remaining_item:to_string()
                            object:set_velocity({x=0, y=0, z=0})
                            
                            item_entity.full_inventory_stopped = true
                            item_entity.stuck_position = object_position
                            
                            core.chat_send_player(player_name, string.format(inventory_full_message, remaining_item:get_count(), remaining_item:get_name()))
                        end
                    elseif apply_magnetic_pull then
                        direction = vector.normalize(direction)
                        local velocity = vector.multiply(direction, item_pickup_speed)
                        object:set_velocity(velocity)
                    end
                end
            end
        end
    end
end)
