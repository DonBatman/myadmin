--Code by degiel1982

-- Settings for item pickup behavior
local pickup_radius = 1 -- The radius in which items are affected
local item_pickup_speed = 20 -- Speed of item movement towards the player
local minimum_pickup_distance = 0.35 -- Distance at which items are picked up
local active_pickup_sounds = {} -- Table for managing active pickup sounds

-- Function to play a sound for item pickup
local function play_pickup_sound(player_name)
    if not active_pickup_sounds[player_name] then
        local sound_duration = 0.3 -- Duration before sound can be replayed
        active_pickup_sounds[player_name] = {time_remaining = sound_duration}
        core.sound_play({
            name = "aio_digndrop_pickup_sound",
            gain = 0.3,
            pitch = math.random(80, 120) / 100,
            to_player = player_name,
        })
    end
end

-- Globalstep callback for managing item pickup and sound playback
core.register_globalstep(function(delta_time)
    -- Get the list of connected players
    local players = core.get_connected_players()
    if players then
        for _, player in ipairs(players) do
            -- Update the time remaining for active sounds
            for player_name, sound_data in pairs(active_pickup_sounds) do
                sound_data.time_remaining = sound_data.time_remaining - delta_time
                if sound_data.time_remaining <= 0 then
                    active_pickup_sounds[player_name] = nil
                end
            end

            -- Get the player's position and name
            local player_position = player:get_pos()
            local player_name = player:get_player_name()

            -- Process nearby objects within the pickup radius
            for object in core.objects_inside_radius(player_position, pickup_radius) do
                if object and not object:is_player() and object:get_luaentity() and object:get_luaentity().name == "__builtin:item" then
                    -- Get the item from the object
                    local item_stack = ItemStack(object:get_luaentity().itemstring)
                    local object_position = object:get_pos()

                    -- Calculate the direction and distance to the player
                    local direction = vector.subtract(player_position, object_position)
                    local distance = vector.length(direction)

                    if distance > minimum_pickup_distance then
                        -- Move the object towards the player if not within pickup distance
                        direction = vector.normalize(direction)
                        local velocity = vector.multiply(direction, item_pickup_speed)
                        object:set_velocity(velocity)
                    else
                        -- Add the item to the player's inventory and remove the object
                        player:get_inventory():add_item("main", item_stack)
                        object:remove()
                        -- Play the pickup sound for the player
                        play_pickup_sound(player_name)
                    end
                end
            end
        end
    end
end)
