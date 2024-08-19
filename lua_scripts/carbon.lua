-- Variables
---------------------------------------------------------------
local GOSSIP_EVENT_ON_HELLO = 1
local GOSSIP_EVENT_ON_SELECT = 2

local CLASS_TRAINERS = {
    [0] = {                                                             -- Alliance
        [1] = {0, -8684.320312, 322.522827, 109.438927, 2.762156},      -- Warrior
        [2] = {0, -8571.125000, 874.315674, 106.519798, 2.245283},      -- Paladin
        [3] = {0, -8411.889648, 575.031006, 92.317902, 0.855211},       -- Hunter
        [4] = {0, -8751.705078, 382.740601, 101.056343, 3.816127},      -- Rogue
        [5] = {0, -8530.514648, 847.882812, 106.519173, 0.671371},      -- Priest
        [6] = {0, 2427.174072, -5544.168457, 376.904358, 2.20100},      -- Death Knight
        [7] = {0, -9035.712891, 548.839478, 73.783249, 0.277919},       -- Shaman
        [8] = {0, -9002.471680, 866.640930, 29.621325, 2.241321},       -- Mage
        [9] = {0, -8954.000000, 993.724976, 122.209000, 0.698000},      -- Warlock
        [11] = {0, -8751.000000, 1124.520020, 92.634003, 1.536000},     -- Druid
    },
    [1] = {                                                             -- Hord
        [1] = {1, 1983.293579, -4793.322754, 56.043747, 5.194841},      -- Warrior
        [2] = {1, 1933.772827, -4131.599609, 41.134701, 5.739130},      -- Paladin
        [3] = {1, 2103.533936, -4620.207520, 58.710781, 3.387385},      -- Hunter
        [4] = {1, 1778.183594, -4286.919922, 7.187177, 2.120017},       -- Rogue
        [5] = {1, 1454.327637, -4176.754883, 61.560715, 4.940373},      -- Priest
        [6] = {0, 2427.174072, -5544.168457, 376.904358, 2.20100},      -- Death Knight
        [7] = {1, 1936.987793, -4215.391602, 42.320004, 2.171848},      -- Shaman
        [8] = {1, 1476.659424, -4221.768066, 43.186245, 2.996526},      -- Mage
        [9] = {1, 1845.489990, -4395.950195, 5.435580, 3.804820},       -- Warlock
        [11] = {1, -1045.962891, -280.859985, 159.030396, 5.730117},    -- Druid
    }
}

local RAID_LOCATIONS = {
    {"Naxxramas", 571, 3668.719971, -1262.460938, 243.623825, 4.785000},
    {"The Eye of Eternity", 571, 3859.439941, 6989.850098, 152.041000, 5.796350},
    {"Vault of Archavon", 571, 5475.638184, 2840.790039, 418.675659, 0.000000},
    {"Obsidian Sanctum", 571, 3457.110107, 262.394012, -113.819000, 3.282580},
    {"Ulduar", 571, 9341.828125, -1114.599731, 1245.146118, 0.000847},
    {"Trial of the Crusader", 571, 8515.679688, 716.981995, 558.247986, 1.573150},
    {"Onyxia’s Lair", 1, -4692.477539, -3716.395508, 49.307957, 3.766808},
    {"Icecrown Citadel", 571, 5800.627441, 2076.969727, 636.064819, 3.583716},
    {"The Ruby Sanctum", 571, 3599.480957, 198.663437, -113.805481, 5.265909},
}

-- Functions
---------------------------------------------------------------

-- Open Class Trainer Gossip
local function OpenClassTrainerGossip(player, object)
    local class = player:GetClass()
    local team = player:GetTeam()
    
    if CLASS_TRAINERS[team][class] ~= nil then
        local map, x, y, z, o = table.unpack(CLASS_TRAINERS[team][class])
        player:Teleport(map, x, y, z, o)
    end
end

-- Open Gossip Menu
local function OnGossipHello(event, player, object)
    player:GossipClearMenu()
    player:GossipMenuAddItem(6, "My Personal Bank", 1, 5)
    player:GossipMenuAddItem(2, "Teleport me To ...", 1, 2)
    player:GossipMenuAddItem(3, "Meet your Trainer", 1, 1)
    player:GossipMenuAddItem(4, "Reset My Cooldowns", 1, 3)
    player:GossipMenuAddItem(4, "Reset All Instances", 1, 4)
    player:GossipSendMenu(1, object)
end

-- Handle Gossip Select
local function OnGossipSelect(event, player, object, sender, intid, code)
    if sender == 0 then
        OnGossipHello(event, player, object)
        return
    end

    if sender == 1 and intid == 1 then
        OpenClassTrainerGossip(player, object)
    end

    -- List of Raid Locations
    if sender == 1 and intid == 2 then
        player:GossipClearMenu()
        for i, v in ipairs(RAID_LOCATIONS) do
            player:GossipMenuAddItem(2, v[1], 2, i)
        end

        player:GossipMenuAddItem(0, "Go Back", 0, 0)
        player:GossipSendMenu(1, object)
    end

    -- Teleport to Raid Location
    if sender == 2 then
        player:GossipComplete()
        local name, map, x, y, z, o = table.unpack(RAID_LOCATIONS[intid])
        if name ~= nil then
            player:Teleport(map, x, y, z, o)
            player:SendNotification("You have been teleported to " .. name)
        end
    end

    -- Reset My Cooldowns
    if sender == 1 and intid == 3 then
        player:GossipComplete()
        player:ResetAllCooldowns()
        player:DurabilityRepairAll()
        player:SetHealth(player:GetMaxHealth())
        player:SetPower(player:GetMaxPower(0), 0)
        player:SendNotification("All cooldowns have been reset")
    end

    -- Reset All Instances
    if sender == 1 and intid == 4 then
        player:GossipComplete()
        player:UnbindAllInstances()
        player:SendNotification("All instances have been reset")
    end

    -- My Personal Bank
    if sender == 1 and intid == 5 then
        player:GossipComplete()
        player:SendShowBank(object)
    end
end




-- Events
---------------------------------------------------------------
RegisterCreatureGossipEvent(9000000, GOSSIP_EVENT_ON_HELLO, OnGossipHello)
RegisterCreatureGossipEvent(9000000, GOSSIP_EVENT_ON_SELECT, OnGossipSelect)