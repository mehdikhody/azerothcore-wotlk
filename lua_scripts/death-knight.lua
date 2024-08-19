-- Variables
---------------------------------------------------------------
local CLASS_ID_DEATH_KNIGHT = 6
local PLAYER_EVENT_ON_FIRST_LOGIN = 30

local STARTER_QUESTS = {
    12593, 12619, 12842, 12848, 12636, 12641, 12657, 12678, 12679, 12680,
    12687, 12698, 12701, 12706, 12716, 12719, 12720, 12722, 12724, 12725,
    12727, 12733,    -1, 12751, 12754, 12755, 12756, 12757, 12779, 12801,
    13165, 13166,    -1
}

local SPECIAL_QUESTS = {
    12742, 12748, 12744, 12743, 12750, 12739,
    12745, 12749,    -1, 12747, 12746
}

local TEAM_QUESTS = {
    13188,      -- Alliance Quest
    13189       -- Horde Quest
}

-- Functions
---------------------------------------------------------------

-- OnFirstLogin: This function is called when a player logs in
-- for the first time after creating a character.
local function OnFirstLogin(event, player)
    if player:GetClass() ~= CLASS_ID_DEATH_KNIGHT then
        return
    end

    -- Combine the quests into a single table
    local quests = {}
    for _, questId in ipairs(STARTER_QUESTS) do
        if questId ~= -1 then
            table.insert(quests, questId)
        end
    end

    table.insert(quests, 23, SPECIAL_QUESTS[player:GetRace()])
    if player:IsAlliance() then
        table.insert(quests, 33, TEAM_QUESTS[1])
    else
        table.insert(quests, 33, TEAM_QUESTS[2])
    end

    -- Complete the quests
    for i, questId in ipairs(quests) do
        if questId ~= -1 and player:GetQuestStatus(questId) == 0 then
            player:AddQuest(questId)
            player:CompleteQuest(questId)
            player:RewardQuest(questId)
        end
    end

    player:AddItem(6948)  -- Hearthstone
    player:AddItem(38664) -- Sky Darkener's Shroud of the Unholy
    player:AddItem(39322) -- Shroud of the North Wind
    player:AddItem(38632) -- Greatsword of the Ebon Blade
    player:SaveToDB()

    -- Set the player's bind point to the starting area
    player:SetBindPoint(-10710.909180, 2482.393799, 7.922432, 1, 2477)
    player:Teleport(1, -10710.909180, 2482.393799, 7.922432, 3.432377)
end


-- Events
---------------------------------------------------------------
RegisterPlayerEvent(PLAYER_EVENT_ON_FIRST_LOGIN, OnFirstLogin)