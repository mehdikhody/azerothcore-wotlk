-- Variables
---------------------------------------------------------------
local PLAYER_EVENT_ON_FIRST_LOGIN = 30


-- Functions
---------------------------------------------------------------

local function OnFirstLogin(event, player)
    -- Riding spells and items
    player:LearnSpell(33388) -- Apprentice Riding
    player:LearnSpell(33391) -- Journeyman Riding
    player:LearnSpell(34090) -- Expert Riding
    player:LearnSpell(34091) -- Artisan Riding
    player:LearnSpell(54197) -- Cold Weather Flying

    player:AddItem(50818) -- Invincible's Reins

    -- Emblems
    player:AddItem(49426, 10000) -- Emblem of Frost
    player:AddItem(47241, 10000) -- Emblem of Triumph
    player:AddItem(40753, 10000) -- Emblem of Valor
    player:AddItem(40752, 10000) -- Emblem of Heroism
    player:AddItem(45624, 10000) -- Emblem of Conquest

    -- Set the player's bind point to the starting area
    player:SetBindPoint(-10710.909180, 2482.393799, 7.922432, 1, 2477)
    player:Teleport(1, -10710.909180, 2482.393799, 7.922432, 3.432377)
end

-- Events
---------------------------------------------------------------
RegisterPlayerEvent(PLAYER_EVENT_ON_FIRST_LOGIN, OnFirstLogin)