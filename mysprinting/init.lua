-- doubletap_sprint/init.lua

-- Constants for our mod
local SPRINT_DELAY = 0.5  -- Maximum interval (in seconds) between taps and delay before sprint lock.
local NORMAL_SPEED = 1    -- Normal walking speed.
local SPRINT_SPEED = 2    -- Sprinting speed (2× normal).

-- Table to track per-player double-tap state for the forward ("W"/up) key.
local player_double_tap = {}

-- Clean up when a player leaves.
minetest.register_on_leaveplayer(function(player)
    local name = player:get_player_name()
    player_double_tap[name] = nil
end)

-- Helper function to determine if a player is touching any liquid.
-- Checks nodes near the feet and near the head.
local function is_touching_liquid(pos)
    -- Note: player:get_pos() returns the center of the player's collision box.
    -- For a typical player, the collision box might extend from pos.y - 0.5 (feet)
    -- to pos.y + 0.85 (head).
    local feet_pos = { x = pos.x, y = pos.y - 0.5, z = pos.z }
    local head_pos = { x = pos.x, y = pos.y + 0.85, z = pos.z }
    local check_positions = {
        vector.round(feet_pos),
        vector.round(head_pos)
    }
    for _, p in ipairs(check_positions) do
        local node = minetest.get_node_or_nil(p)
        if node then
            local nodedef = minetest.registered_nodes[node.name]
            if nodedef and nodedef.liquidtype and nodedef.liquidtype ~= "none" then
                return true
            end
        end
    end
    return false
end

-- Global step: called every server tick.
minetest.register_globalstep(function(dtime)
    -- Iterate over all connected players.
    for _, player in ipairs(minetest.get_connected_players()) do
        local name    = player:get_player_name()
        local control = player:get_player_control()
        local pos     = player:get_pos()
        local desired_speed = NORMAL_SPEED

        -- Cancel sprinting if any part of the player's collision box touches liquid.
        if is_touching_liquid(pos) then
            desired_speed = NORMAL_SPEED
            player_double_tap[name] = nil
        else
            -- Initialize double-tap state if not already present.
            if not player_double_tap[name] then
                player_double_tap[name] = { count = 0, timer = 0, was_up = false, sprinting = false }
            end
            local dt_state = player_double_tap[name]

            if dt_state.sprinting then
                -- Sprint mode is locked when activated.
                desired_speed = SPRINT_SPEED
                if not control.up then
                    -- Reset when the key is released.
                    dt_state.sprinting = false
                    dt_state.count = 0
                    dt_state.timer = 0
                end
            else
                -- Not yet in locked sprint mode.
                if dt_state.count > 0 then
                    dt_state.timer = dt_state.timer + dtime
                end

                -- Detect a fresh (rising edge) press of the up key.
                if control.up and not dt_state.was_up then
                    dt_state.count = dt_state.count + 1
                    if dt_state.count == 1 then
                        dt_state.timer = 0  -- Start the timer for the first tap.
                    end
                end

                -- Save current key state for next frame.
                dt_state.was_up = control.up

                -- If too much time has elapsed, reset the counter.
                if dt_state.timer > SPRINT_DELAY then
                    dt_state.count = 0
                    dt_state.timer = 0
                end

                -- Activate sprint when two taps are detected within the time window and the key is held.
                if dt_state.count >= 2 and control.up then
                    dt_state.sprinting = true
                    desired_speed = SPRINT_SPEED
                else
                    desired_speed = NORMAL_SPEED
                end
            end
        end

        -- Only update the player's physics if the speed has actually changed.
        local current_physics = player:get_physics_override()
        if current_physics.speed ~= desired_speed then
            player:set_physics_override({ speed = desired_speed })
        end
    end
end)
