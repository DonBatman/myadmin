-- init.lua for the mycursing mod (with bad_words.txt integration)

local mod_name = "mycursing" -- IMPORTANT: Ensure this matches your mod's folder name

-- --- Mod Loading/Initialization ---
local bad_words = {}
local bad_words_filepath = core.get_modpath(mod_name) .. "/bad_words.txt"

local file = io.open(bad_words_filepath, "r")
if file then
    for line in file:lines() do
        line = line:match("^%s*(.-)%s*$") -- Trim whitespace
        if line ~= "" and not line:match("^#") then -- Ignore empty lines and comments
            table.insert(bad_words, line:lower()) -- Add word to list, converted to lowercase
        end
    end
    file:close()
    core.log("action", "[" .. mod_name .. "] Loaded " .. #bad_words .. " bad words from " .. bad_words_filepath)
else
    core.log("warning", "[" .. mod_name .. "] Could not find bad_words.txt at " .. bad_words_filepath .. ". Using default hardcoded list.")
    -- Fallback to a hardcoded list if the file is not found
    bad_words = {
        "fuck", "faggot", "fag", "gay", "asshole", "arsehole", "dick", "cunt",
        "wtf", "retard", "bitch", "shit", "bastard", "nigger", "nigga", "damn", "ass"
    }
end

-- --- Chat Message Hook ---
-- This hook maintains the exact logic of the "working" snippet you provided:
-- - Kicks the player if a forbidden word is found.
-- - You confirmed that 'return message' here causes the message to NOT be displayed.
-- - If no forbidden words are found, this function returns nothing, which
--   you confirmed causes clean messages to be displayed.
core.register_on_chat_message(function(name, message)
    if not message then return end -- Ensure message is not nil

    local msg = message:lower() -- Convert message to lowercase for comparison

    for _, word in pairs(bad_words) do
        -- Simple string find for the bad word (this will find "fuck" in "fucking", for example)
        if msg:find(word) then
            core.kick_player(name, "( ** WATCH YOUR LANGUAGE ** )")
            
            -- You confirmed that in your environment, 'return message' here
            -- results in the message NOT being displayed in public chat.
            return message
        end
    end
    
    -- If no forbidden words are found, the function implicitly returns nothing (nil).
    -- You have confirmed that this results in the clean message being displayed.
    -- No 'return message' statement is explicitly needed here based on your confirmed behavior.
end)
