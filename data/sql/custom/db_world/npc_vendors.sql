-- --------------------------------------------------------------------------------------
--	Vendors - 10000000
-- --------------------------------------------------------------------------------------
SET
@StartEntry 	:= 10000000,
@MinLevel 	    := 80,
@MaxLevel 	    := 80,
@Faction 	    := 35,
@NPCFlag 	    := 4224,
@Scale		    := 1.0,
@BiggerScale	:= 1.5,
@SmallerScale	:= 0.5,
@Type 		    := 7,
@TypeFlags 	    := 0,
@FlagsExtra     := 2;

-- NPC CREATURES
DELETE FROM `creature_template` WHERE `entry` >= @StartEntry;
INSERT INTO creature_template (`entry`, `name`, `subname`, `minlevel`, `maxlevel`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `unit_class`, `unit_flags`, `type`, `type_flags`, `RegenHealth`, `flags_extra`) 
VALUES 
(@StartEntry, "Dungeons", "Normal", @MinLevel, @MaxLevel, @Faction, @NPCFlag, 1, 1.14286, @BiggerScale, 1, 2, @Type, @TypeFlags, 1, @FlagsExtra),
(@StartEntry+1, "Dungeons", "Heroic", @MinLevel, @MaxLevel, @Faction, @NPCFlag, 1, 1.14286, @BiggerScale, 1, 2, @Type, @TypeFlags, 1, @FlagsExtra),
(@StartEntry+2, "Tier sets", "", @MinLevel, @MaxLevel, @Faction, @NPCFlag, 1, 1.14286, @BiggerScale, 1, 2, @Type, @TypeFlags, 1, @FlagsExtra),
(@StartEntry+3, "Naxxramas - 10 Man", "", @MinLevel, @MaxLevel, @Faction, @NPCFlag, 1, 1.14286, @Scale, 1, 2, @Type, @TypeFlags, 1, @FlagsExtra),
(@StartEntry+4, "Naxxramas - 25 Man", "Armor", @MinLevel, @MaxLevel, @Faction, @NPCFlag, 1, 1.14286, @Scale, 1, 2, @Type, @TypeFlags, 1, @FlagsExtra),
(@StartEntry+5, "Naxxramas - 25 Man", "Acessories & Weapons", @MinLevel, @MaxLevel, @Faction, @NPCFlag, 1, 1.14286, @Scale, 1, 2, @Type, @TypeFlags, 1, @FlagsExtra),
(@StartEntry+6, "The Eye of Eternity", "", @MinLevel, @MaxLevel, @Faction, @NPCFlag, 1, 1.14286, @BiggerScale, 1, 2, @Type, @TypeFlags, 1, @FlagsExtra),
(@StartEntry+7, "Obsidian Sanctum", "", @MinLevel, @MaxLevel, @Faction, @NPCFlag, 1, 1.14286, @BiggerScale, 1, 2, @Type, @TypeFlags, 1, @FlagsExtra),
(@StartEntry+8, "Ulduar - 10 Man", "Armor", @MinLevel, @MaxLevel, @Faction, @NPCFlag, 1, 1.14286, @Scale, 1, 2, @Type, @TypeFlags, 1, @FlagsExtra),
(@StartEntry+9, "Ulduar - 10 Man", "Acessories & Weapons", @MinLevel, @MaxLevel, @Faction, @NPCFlag, 1, 1.14286, @Scale, 1, 2, @Type, @TypeFlags, 1, @FlagsExtra),
(@StartEntry+10, "Ulduar - 25 Man", "Armor", @MinLevel, @MaxLevel, @Faction, @NPCFlag, 1, 1.14286, @Scale, 1, 2, @Type, @TypeFlags, 1, @FlagsExtra),
(@StartEntry+11, "Ulduar - 25 Man", "Acessories & Weapons", @MinLevel, @MaxLevel, @Faction, @NPCFlag, 1, 1.14286, @Scale, 1, 2, @Type, @TypeFlags, 1, @FlagsExtra),
(@StartEntry+12, "Trial of the Crusader - 10 Man", "Armor", @MinLevel, @MaxLevel, @Faction, @NPCFlag, 1, 1.14286, @BiggerScale, 1, 2, @Type, @TypeFlags, 1, @FlagsExtra),
(@StartEntry+13, "Trial of the Crusader - 10 Man", "Acessories & Weapons", @MinLevel, @MaxLevel, @Faction, @NPCFlag, 1, 1.14286, @BiggerScale, 1, 2, @Type, @TypeFlags, 1, @FlagsExtra),
(@StartEntry+14, "Trial of the Crusader - 25 Man", "Armor", @MinLevel, @MaxLevel, @Faction, @NPCFlag, 1, 1.14286, @BiggerScale, 1, 2, @Type, @TypeFlags, 1, @FlagsExtra),
(@StartEntry+15, "Trial of the Crusader - 25 Man", "Acessories & Weapons", @MinLevel, @MaxLevel, @Faction, @NPCFlag, 1, 1.14286, @BiggerScale, 1, 2, @Type, @TypeFlags, 1, @FlagsExtra),
(@StartEntry+16, "Onyxia’s Lair", "", @MinLevel, @MaxLevel, @Faction, @NPCFlag, 1, 1.14286, @BiggerScale, 1, 2, @Type, @TypeFlags, 1, @FlagsExtra),
(@StartEntry+17, "Icecrown Citadel - 10 Man", "Armor", @MinLevel, @MaxLevel, @Faction, @NPCFlag, 1, 1.14286, @Scale, 1, 2, @Type, @TypeFlags, 1, @FlagsExtra),
(@StartEntry+18, "Icecrown Citadel - 10 Man", "Acessories", @MinLevel, @MaxLevel, @Faction, @NPCFlag, 1, 1.14286, @Scale, 1, 2, @Type, @TypeFlags, 1, @FlagsExtra),
(@StartEntry+19, "Icecrown Citadel - 10 Man", "Weapons", @MinLevel, @MaxLevel, @Faction, @NPCFlag, 1, 1.14286, @Scale, 1, 2, @Type, @TypeFlags, 1, @FlagsExtra),
(@StartEntry+20, "Icecrown Citadel - 25 Man", "Armor", @MinLevel, @MaxLevel, @Faction, @NPCFlag, 1, 1.14286, @Scale, 1, 2, @Type, @TypeFlags, 1, @FlagsExtra),
(@StartEntry+21, "Icecrown Citadel - 25 Man", "Acessories", @MinLevel, @MaxLevel, @Faction, @NPCFlag, 1, 1.14286, @Scale, 1, 2, @Type, @TypeFlags, 1, @FlagsExtra),
(@StartEntry+22, "Icecrown Citadel - 25 Man", "Weapons", @MinLevel, @MaxLevel, @Faction, @NPCFlag, 1, 1.14286, @Scale, 1, 2, @Type, @TypeFlags, 1, @FlagsExtra),
(@StartEntry+23, "The Ruby Sanctum", "", @MinLevel, @MaxLevel, @Faction, @NPCFlag, 1, 1.14286, @BiggerScale, 1, 2, @Type, @TypeFlags, 1, @FlagsExtra),
(@StartEntry+24, "Glyph Vendor", "DK, Warrior, Paladin", @MinLevel, @MaxLevel, @Faction, @NPCFlag, 1, 1.14286, @BiggerScale, 1, 2, @Type, @TypeFlags, 1, @FlagsExtra),
(@StartEntry+25, "Glyph Vendor", "Shaman, Hunter", @MinLevel, @MaxLevel, @Faction, @NPCFlag, 1, 1.14286, @BiggerScale, 1, 2, @Type, @TypeFlags, 1, @FlagsExtra),
(@StartEntry+26, "Glyph Vendor", "Druid, Rouge", @MinLevel, @MaxLevel, @Faction, @NPCFlag, 1, 1.14286, @BiggerScale, 1, 2, @Type, @TypeFlags, 1, @FlagsExtra),
(@StartEntry+27, "Glyph Vendor", "Mage, Priest, Warlock", @MinLevel, @MaxLevel, @Faction, @NPCFlag, 1, 1.14286, @BiggerScale, 1, 2, @Type, @TypeFlags, 1, @FlagsExtra),
(@StartEntry+28, "Gems Vendor", "", @MinLevel, @MaxLevel, @Faction, @NPCFlag, 1, 1.14286, @BiggerScale, 1, 2, @Type, @TypeFlags, 1, @FlagsExtra),
(@StartEntry+29, "Consumables Vendor", "", @MinLevel, @MaxLevel, @Faction, @NPCFlag, 1, 1.14286, @Scale, 1, 2, @Type, @TypeFlags, 1, @FlagsExtra),
(@StartEntry+30, "Mount Vendor", "", @MinLevel, @MaxLevel, @Faction, @NPCFlag, 1, 1.14286, @BiggerScale, 1, 2, @Type, @TypeFlags, 1, @FlagsExtra),
(@StartEntry+31, "Tools & Material Vendor", "", @MinLevel, @MaxLevel, @Faction, @NPCFlag, 1, 1.14286, @Scale, 1, 2, @Type, @TypeFlags, 1, @FlagsExtra);

-- NPC MODELS
DELETE FROM `creature_template_model` WHERE `CreatureID` >= @StartEntry;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`) 
VALUES 
(@StartEntry, 0, 28986, @BiggerScale, 1, 0),        -- Dungeons
(@StartEntry+1, 0, 28986, @BiggerScale, 1, 0),      -- Dungeons
(@StartEntry+2, 0, 28986, @BiggerScale, 1, 0),      -- Tier sets
(@StartEntry+3, 0, 16508, @Scale, 1, 0),            -- Naxxramas
(@StartEntry+4, 0, 16508, @Scale, 1, 0),            -- Naxxramas
(@StartEntry+5, 0, 16508, @Scale, 1, 0),            -- Naxxramas
(@StartEntry+6, 0, 28195, @BiggerScale, 1, 0),     -- The Eye of Eternity
(@StartEntry+7, 0, 28195, @BiggerScale, 1, 0),     -- Obsidian Sanctum
(@StartEntry+8, 0, 28739, @Scale, 1, 0),            -- Ulduar
(@StartEntry+9, 0, 28739, @Scale, 1, 0),            -- Ulduar
(@StartEntry+10, 0, 28739, @Scale, 1, 0),           -- Ulduar
(@StartEntry+11, 0, 28739, @Scale, 1, 0),           -- Ulduar
(@StartEntry+12, 0, 28754, @BiggerScale, 1, 0),     -- Trial of the Crusader
(@StartEntry+13, 0, 28754, @BiggerScale, 1, 0),     -- Trial of the Crusader
(@StartEntry+14, 0, 28754, @BiggerScale, 1, 0),     -- Trial of the Crusader
(@StartEntry+15, 0, 28754, @BiggerScale, 1, 0),     -- Trial of the Crusader
(@StartEntry+16, 0, 28195, @BiggerScale, 1, 0),    -- Onyxia’s Lair
(@StartEntry+17, 0, 30869, @Scale, 1, 0),           -- Icecrown Citadel
(@StartEntry+18, 0, 30869, @Scale, 1, 0),           -- Icecrown Citadel
(@StartEntry+19, 0, 30869, @Scale, 1, 0),           -- Icecrown Citadel
(@StartEntry+20, 0, 30869, @Scale, 1, 0),           -- Icecrown Citadel
(@StartEntry+21, 0, 30869, @Scale, 1, 0),           -- Icecrown Citadel
(@StartEntry+22, 0, 30869, @Scale, 1, 0),           -- Icecrown Citadel
(@StartEntry+23, 0, 28195, @BiggerScale, 1, 0),    -- The Ruby Sanctum
(@StartEntry+24, 0, 25635, @BiggerScale, 1, 0),    -- Glyph Vendor
(@StartEntry+25, 0, 25635, @BiggerScale, 1, 0),    -- Glyph Vendor
(@StartEntry+26, 0, 25635, @BiggerScale, 1, 0),    -- Glyph Vendor
(@StartEntry+27, 0, 25635, @BiggerScale, 1, 0),    -- Glyph Vendor
(@StartEntry+28, 0, 26075, @BiggerScale, 1, 0),    -- Gems Vendor
(@StartEntry+29, 0, 30686, @Scale, 1, 0),          -- Consumables Vendor
(@StartEntry+30, 0, 24311, @BiggerScale, 1, 0),    -- Mount Vendor
(@StartEntry+31, 0, 28282, @Scale, 1, 0);          -- Tools Vendor

