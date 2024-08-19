-- Variables
---------------------------------------------------------------
local PLAYER_EVENT_ON_COMMAND = 42
local MENU_ID = 100

local RAIDS_BUFF = {
    ["group_guid"] = {
        ["player_1"] = "spell_magic_greaterblessingofkings",
        ["player_2"] = "spell_holy_greaterblessingofkings",
        ["player_3"] = "spell_holy_greaterblessingofwisdom",
        ["player_4"] = "spell_holy_greaterblessingofsanctuary"
    }
}

-- Functions
---------------------------------------------------------------

-- Check if player has leader permission
local function HasLeaderPermission(player)
    local group = player:GetGroup()
    if group == nil then
        return false
    end

    local isLeader = group:IsLeader(player:GetGUID())
    local isAssistant = group:IsAssistant(player:GetGUID())
    local isGM = player:IsGM()
    if not isGM and not isLeader and not isAssistant then
        return false
    end

    return true
end

local function TeleportEveryoneOnLeader(player)
    local group = player:GetGroup()
    local members = group:GetMembers()
    local map = player:GetMapId()
    local x, y, z, o = player:GetLocation()
    
    for i = 1, #members do
        local member = members[i]
        if member:IsDead() then
            member:ResurrectPlayer(100, false)
        end
        member:Teleport(map, x, y, z, o)
    end

    player:SendNotification("Everyone has been teleported to your location")
end

local function ResetEveryoneCooldowns(player)
    local group = player:GetGroup()
    local members = group:GetMembers()
    for i = 1, #members do
        local member = members[i]
        member:DurabilityRepairAll()
        member:ResetAllCooldowns()
        member:SetHealth(member:GetMaxHealth())
        member:SetPower(member:GetMaxPower(0), 0)
        member:RemoveAura(15007) -- Remove sickness
        member:RemoveAura(57724) -- Remove Bloodlust
        member:SendNotification("All cooldowns have been reset")
    end
end

local function UnbindEveryoneInstances(player)
    local group = player:GetGroup()
    local members = group:GetMembers()
    for i = 1, #members do
        local member = members[i]
        member:UnbindAllInstances()
        member:SendNotification("All instances have been reset")
    end
end

local function GetPlayersWithClassOf(player, classId)
    local group = player:GetGroup()
    local members = group:GetMembers()
    local units = {}
    for i = 1, #members do
        local member = members[i]
        if member:GetClass() == classId then
            table.insert(units, member)
        end
    end
    return units
end

local function OpenBuffsMenu(player, object)
    player:GossipClearMenu()

    -- Priest
    local priests = GetPlayersWithClassOf(player, 5)
    if #priests > 0 then
        local member = priests[1]
        local memberName = member:GetName()
        local pof = string.format("|TInterface/ICONS/spell_holy_prayeroffortitude:24:24:-18|t %s", memberName)
        local pos = string.format("|TInterface/ICONS/spell_holy_prayerofspirit:24:24:-18|t %s", memberName)
        local posp = string.format("|TInterface/ICONS/spell_holy_prayerofshadowprotection:24:24:-18|t %s", memberName)

        player:GossipMenuAddItem(0, pof, 2, 0)
        player:GossipMenuAddItem(0, pos, 2, 0)
        player:GossipMenuAddItem(0, posp, 2, 0)
    end

    -- Death Knight
    local deathKnights = GetPlayersWithClassOf(player, 6)
    if #deathKnights > 0 then
        local member = deathKnights[1]
        local memberName = member:GetName()
        local how = string.format("|TInterface/ICONS/inv_misc_horn_02:24:24:-18|t %s", memberName)
        player:GossipMenuAddItem(0, "Horn of Winter", 2, 0)
    end

    -- Mage
    local mages = GetPlayersWithClassOf(player, 8)
    if #mages > 0 then
        local member = mages[1]
        local memberName = member:GetName()
        local ab = string.format("|TInterface/ICONS/spell_holy_arcaneintellect:24:24:-18|t %s", memberName)
        player:GossipMenuAddItem(0, ab, 2, 0)
    end

    -- Druid
    local druids = GetPlayersWithClassOf(player, 11)
    if #druids > 0 then
        local member = druids[1]
        local memberName = member:GetName()
        local gotw = string.format("|TInterface/ICONS/spell_nature_giftofthewild:24:24:-18|t %s", memberName)
        player:GossipMenuAddItem(0, gotw, 2, 0)
    end

    -- Paladin
    local paladins = GetPlayersWithClassOf(player, 2)
    if #paladins > 0 then
        local group = player:GetGroup()
        local groupGUID = group:GetGUID()

        if RAIDS_BUFF[groupGUID] == nil then
            RAIDS_BUFF[groupGUID] = {}
        end

        for i = 1, #paladins do
            local member = paladins[i]
            local memberName = member:GetName()
            local memberBuff = RAIDS_BUFF[groupGUID][memberName]

            if memberBuff == nil then
                if i == 1 then
                    memberBuff = "spell_magic_greaterblessingofkings"
                elseif i == 2 then
                    memberBuff = "spell_holy_greaterblessingofkings"
                elseif i == 3 then
                    memberBuff = "spell_holy_greaterblessingofwisdom"
                elseif i == 4 then
                    memberBuff = "spell_holy_greaterblessingofsanctuary"
                end
            end

            RAIDS_BUFF[groupGUID][memberName] = memberBuff
            local bok = string.format("|TInterface/ICONS/%s:24:24:-18|t %s", memberBuff, memberName)
            player:GossipMenuAddItem(0, bok, 2, i)
        end
    end

    player:GossipMenuAddItem(0, "Go Back", 0, 0)
    player:GossipSendMenu(1, object, MENU_ID)
end

-- Open Gossip Menu
local function OnGossipHello(event, player, object)
    player:GossipClearMenu()
    player:GossipMenuAddItem(0, "Teleport Everyone on Me", 1, 1)
    player:GossipMenuAddItem(0, "Reset All Cooldowns", 1, 2)
    player:GossipMenuAddItem(0, "Reset All Instances", 1, 3)
    player:GossipMenuAddItem(0, "Raid Buffs", 1, 4)
    player:GossipSendMenu(1, object, MENU_ID)
end

-- Handle Gossip Select
local function OnGossipSelect(event, player, object, sender, intid, code)
    if sender == 0 then
        OnGossipHello(event, player, object)
        return
    end

    -- Teleport Everyone on Me
    if sender == 1 and intid == 1 then
        player:GossipComplete()
        TeleportEveryoneOnLeader(player)
    end

    -- Reset All Cooldowns
    if sender == 1 and intid == 2 then
        player:GossipComplete()
        ResetEveryoneCooldowns(player)
    end

    -- Reset All Instances
    if sender == 1 and intid == 3 then
        player:GossipComplete()
        UnbindEveryoneInstances(player)
    end

    -- Raid Buffs
    if sender == 1 and intid == 4 then
        OpenBuffsMenu(player, object)
        return;
    end

    -- Paladin Buffs
    if sender == 2 and intid ~= 0 then
        local group = player:GetGroup()
        local groupGUID = group:GetGUID()
        local paladins = GetPlayersWithClassOf(player, 2)
        local member = paladins[intid]

        if member == nil then
            return
        end

        local memberName = member:GetName()
        if RAIDS_BUFF[groupGUID] == nil then
            RAIDS_BUFF[groupGUID] = {}
        end

        local memberBuff = RAIDS_BUFF[groupGUID][memberName]
        if memberBuff == nil then
            memberBuff = "spell_magic_greaterblessingofkings"
        end

        if memberBuff == "spell_magic_greaterblessingofkings" then
            memberBuff = "spell_holy_greaterblessingofkings"
        end

        if memberBuff == "spell_holy_greaterblessingofkings" then
            memberBuff = "spell_holy_greaterblessingofwisdom"
        end

        if memberBuff == "spell_holy_greaterblessingofwisdom" then
            memberBuff = "spell_holy_greaterblessingofsanctuary"
        end

        if memberBuff == "spell_holy_greaterblessingofsanctuary" then
            memberBuff = "spell_magic_greaterblessingofkings"
        end

        RAIDS_BUFF[groupGUID][memberName] = memberBuff
        OpenBuffsMenu(player, object)
    end
end

local function OnLeadCommand(event, player, command)
    if command == "lead" and HasLeaderPermission(player) then
        if player:IsInCombat() then
            player:SendBroadcastMessage("You can't use this command while in combat.")
            return false
        end

        OnGossipHello(event, player, player)
        return false
    end
end


-- Events
---------------------------------------------------------------
RegisterPlayerEvent(PLAYER_EVENT_ON_COMMAND, OnLeadCommand)
RegisterPlayerGossipEvent(MENU_ID, 2, OnGossipSelect)
RegisterItemGossipEvent(MENU_ID, 2, OnGossipSelect)