-- Variables
---------------------------------------------------------------
local PLAYER_EVENT_ON_COMMAND = 42


-- Functions
---------------------------------------------------------------

-- OnCommand: This function is called when a player types a command.
-- Will open a god mode gossip menu for the player.
local function OnCommand(event, player, command)
    if (command == "z") then
        if player:IsInCombat() then
            player:SendBroadcastMessage("You can't use this command while in combat.")
            return false
        end

        if player:IsDead() then    
            player:ResurrectPlayer(100, false)
        end
        
        player:RemoveAura(15007) -- Remove sickness
        player:RemoveAura(57724) -- Remove Bloodlust
        player:RemoveAura(2825) -- Remove Bloodlust
        player:ResetAllCooldowns()
        player:DurabilityRepairAll()
        player:Teleport(1, -10710.909180, 2482.393799, 7.922432, 3.432377)
        return false
    end
end


-- Events
---------------------------------------------------------------
RegisterPlayerEvent(PLAYER_EVENT_ON_COMMAND, OnCommand)