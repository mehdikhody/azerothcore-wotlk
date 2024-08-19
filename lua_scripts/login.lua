-- Variables
---------------------------------------------------------------
local PLAYER_EVENT_ON_LOGIN = 30


-- Functions
---------------------------------------------------------------

local function OnLogin(event, player)
    -- PVP
    player:SetHonorPoints(500000) -- Honor Points
    player:SetArenaPoints(500000) -- Arena Points
end

-- Events
---------------------------------------------------------------
RegisterPlayerEvent(PLAYER_EVENT_ON_LOGIN, OnLogin)