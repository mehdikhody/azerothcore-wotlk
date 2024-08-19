local INSTANCE_EVENT_ON_LOAD = 2
local HEALTH_MULTIPLIER = 1.20
local DAMAGE_MULTIPLIER = 1.20
local INSTANCE_MAP_IDS = {631}

local function IncreaseCreatureHealth(creature)
    local health = creature:GetMaxHealth()
    creature:SetMaxHealth(health * HEALTH_MULTIPLIER)
    creature:SetHealth(health * HEALTH_MULTIPLIER)
end

local function OnInstanceLoad(event, instance_data, map, creature)
    if creature:CanStartAttack() then
        IncreaseCreatureHealth(creature)
    end
end

for _, mapId in ipairs(INSTANCE_MAP_IDS) do
    print("Registering events for map: " .. mapId)
    RegisterMapEvent(mapId, 5, OnInstanceLoad)
end