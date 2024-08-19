local NPC_ENTRY = 9000001
local GOSSIP_EVENT_ON_HELLO = 1
local GOSSIP_EVENT_ON_SELECT = 2

local PRIMARY_PROFESSIONS = {
    {
        NAME = "Alchemy",
        SKILL = 171,
        SPELLS = {2259, 3101, 3464, 11611, 28596, 51304}
    },
    {
        NAME = "Blacksmithing",
        SKILL = 164,
        SPELLS = {2018, 3100, 3538, 9785, 29844, 51300}
    },
    {
        NAME = "Enchanting",
        SKILL = 333,
        SPELLS = {7411, 7412, 7413, 13920, 28029, 51313}
    },
    {
        NAME = "Engineering",
        SKILL = 202,
        SPELLS = {4036, 4037, 4038, 12656, 30350, 51306}
    },
    {
        NAME = "Herbalism",
        SKILL = 182,
        SPELLS = {2366, 2368, 3570, 11993, 28695, 50300}
    },
    {
        NAME = "Inscription",
        SKILL = 773,
        SPELLS = {45357, 45358, 45359, 45360, 45361, 45363}
    },
    {
        NAME = "Jewelcrafting",
        SKILL = 755,
        SPELLS = {25229, 25230, 28894, 28895, 28897, 51311}
    },
    {
        NAME = "Leatherworking",
        SKILL = 165,
        SPELLS = {2108, 3104, 3811, 10662, 32549, 51302}
    },
    {
        NAME = "Mining",
        SKILL = 186,
        SPELLS = {2575, 2576, 3564, 10248, 29354, 50310}
    },
    {
        NAME = "Skinning",
        SKILL = 393,
        SPELLS = {8613, 8617, 8618, 10768, 32654, 50305}
    },
    {
        NAME = "Tailoring",
        SKILL = 197,
        SPELLS = {3908, 3909, 3910, 12180, 26790, 51309}
    }
}

local SECONDARY_PROFESSIONS = {
    {
        NAME = "Cooking",
        SKILL = 185,
        SPELLS = {51296}
    },
    {
        NAME = "Fishing",
        SKILL = 356,
        SPELLS = {51294, 7731, 7732, 18248, 33095, 7620, 62734, 65293}
    },
    {
        NAME = "First Aid",
        SKILL = 129,
        SPELLS = {45542}
    }
}

local function OnGossipHello(event, player, npc)
    player:GossipClearMenu()

    local total_known_professions = 0;
    for i, v in ipairs(PRIMARY_PROFESSIONS) do
        if player:HasSkill(v.SKILL) == true then
            total_known_professions = total_known_professions + 1
        end
    end
    
    if total_known_professions < 2 then
        for i, v in ipairs(PRIMARY_PROFESSIONS) do
            if player:HasSkill(v.SKILL) == false then
                player:GossipMenuAddItem(3, v.NAME, 1, v.SKILL)
            end
        end 
    end

    for i, v in ipairs(SECONDARY_PROFESSIONS) do
        if player:HasSkill(v.SKILL) == false then
            player:GossipMenuAddItem(3, v.NAME, 2, v.SKILL)
        end
    end

    player:GossipSendMenu(1, npc)
end

local function OnGossipSelect(event, player, npc, sender, intid, code)
    if sender == 0 then
        OnGossipHello(event, player, npc)
        return
    end

    if sender == 1 then
        local total_known_professions = 0;
        for i, v in ipairs(PRIMARY_PROFESSIONS) do
            if player:HasSkill(v.SKILL) == true then
                total_known_professions = total_known_professions + 1
            end
        end

        if total_known_professions >= 2 then
            player:GossipComplete()
            player:SendNotification("You can only learn 2 primary professions")
            return
        end

        local profession = nil
        for i, v in ipairs(PRIMARY_PROFESSIONS) do
            if v.SKILL == intid and player:HasSkill(v.SKILL) == false then
                profession = v
                break
            end
        end

        if profession == nil then
            player:GossipComplete()
            player:SendNotification("Already know this profession")
            return
        end

        player:SetSkill(profession.SKILL, 1, 450, 450)
        for i, v in ipairs(profession.SPELLS) do
            player:LearnSpell(v)
        end
        player:GossipComplete()
    end
    
    if sender == 2 then
        local profession = nil
        for i, v in ipairs(SECONDARY_PROFESSIONS) do
            if v.SKILL == intid and player:HasSkill(v.SKILL) == false then
                profession = v
                break
            end
        end

        if profession == nil then
            player:GossipComplete()
            player:SendNotification("Already know this profession")
            return
        end

        player:SetSkill(profession.SKILL, 1, 450, 450)
        for i, v in ipairs(profession.SPELLS) do
            player:LearnSpell(v)
        end
        player:GossipComplete()
    end
    
    player:GossipComplete()
    player:SendNotification("You know evey profession possible")
end

RegisterCreatureGossipEvent(NPC_ENTRY, GOSSIP_EVENT_ON_HELLO, OnGossipHello)
RegisterCreatureGossipEvent(NPC_ENTRY, GOSSIP_EVENT_ON_SELECT, OnGossipSelect)