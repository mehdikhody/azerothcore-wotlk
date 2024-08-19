-- --------------------------------------------------------------------------------------
--	Carbon - 9000000
-- --------------------------------------------------------------------------------------
SET
@Entry 		:= 9000000,
@Model 		:= 30416,
@Name 		:= "Carbon",
@Title 		:= "GM",
@Icon 		:= "Speak",
@GossipMenu := 0,
@MinLevel 	:= 80,
@MaxLevel 	:= 80,
@Faction 	:= 35,
@NPCFlag 	:= 1,
@Scale		:= 1.0,
@Type 		:= 7,
@TypeFlags 	:= 0,
@FlagsExtra := 2,
@Text       := "Greetings, $N. Carbon the Server Administrator at your service. How may I assist you today?";

-- NPC CREATURE
DELETE FROM creature_template WHERE entry = @Entry;
INSERT INTO creature_template (`entry`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `unit_class`, `unit_flags`, `type`, `type_flags`, `RegenHealth`, `flags_extra`) 
VALUES (@Entry, @Name, @Title, @Icon, @GossipMenu, @MinLevel, @MaxLevel, @Faction, @NPCFlag, 1, 1.14286, @Scale, 1, 2, @Type, @TypeFlags, 1, @FlagsExtra);

-- NPC MODEL
DELETE FROM `creature_template_model` WHERE `CreatureID` = @Entry;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`) 
VALUES (@Entry, 0, @Model, 1, 1, 0);

-- NPC EQUIPPED
DELETE FROM `creature_equip_template` WHERE (`CreatureID` = 9000000);
INSERT INTO `creature_equip_template` (`CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`) VALUES
(9000000, 1, 49623, 50730, 0, 18019);

-- NPC TEXT
DELETE FROM `npc_text` WHERE `ID`=@Entry;
INSERT INTO `npc_text` (`ID`, `text0_0`) VALUES (@Entry, @Text);
