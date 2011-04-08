------------------------------------------------------------------------
-- Launch Zui Script
------------------------------------------------------------------------
local Z, C, L = unpack(select(2, ...)) -- Import: Z - functions, constants, variables; C - config; L - locales

-- this install Tukui with default settings.
local function install()
	SetCVar("buffDurations", 1)
	SetCVar("mapQuestDifficulty", 1)
	SetCVar("scriptErrors", 1)
	SetCVar("ShowClassColorInNameplate", 1)
	SetCVar("screenshotQuality", 8)
	SetCVar("chatMouseScroll", 1)
	SetCVar("chatStyle", "im")
	SetCVar("WholeChatWindowClickable", 0)
	SetCVar("ConversationMode", "inline")
	SetCVar("showTutorials", 0)
	SetCVar("showNewbieTips", 0)
	SetCVar("Maxfps", 120)
	SetCVar("autoQuestWatch", 1)
	SetCVar("autoQuestProgress", 1)
	SetCVar("UberTooltips", 1)
	SetCVar("removeChatDelay", 1)
	SetCVar("showVKeyCastbar", 1)
	--SetCVar("bloatthreat", 0)
	--SetCVar("bloattest", 0)
	SetCVar("showArenaEnemyFrames", 0)
	
	-- setting this the creator  only, because a lot of people don't like this.		
	if Z.myname == "Zoddy" then
		SetCVar("autoDismountFlying", 1)
		SetCVar("secureAbilityToggle", 0)
		SetCVar("colorblindMode", 0)
		SetCVar("showLootSpam", 1)
		SetCVar("guildMemberNotify", 1)
		SetCVar("chatBubblesParty", 1)
		SetCVar("chatBubbles", 1)	
		SetCVar("UnitNameOwn", 0)
		SetCVar("UnitNameNPC", 0)
		SetCVar("UnitNameNonCombatCreatureName", 0)
		SetCVar("UnitNamePlayerGuild", 1)
		SetCVar("UnitNamePlayerPVPTitle", 1)
		SetCVar("UnitNameFriendlyPlayerName", 1)
		SetCVar("UnitNameFriendlyPetName", 1)
		SetCVar("UnitNameFriendlyGuardianName", 1)
		SetCVar("UnitNameFriendlyTotemName", 1)
		SetCVar("UnitNameEnemyPlayerName", 1)
		SetCVar("UnitNameEnemyPetName", 1)
		SetCVar("UnitNameEnemyGuardianName", 1)
		SetCVar("UnitNameEnemyTotemName", 1)
		SetCVar("CombatDamage", 1)
		SetCVar("CombatHealing", 1)
		SetCVar("nameplateShowFriends", 0)
		SetCVar("nameplateShowFriendlyPets", 0)
		SetCVar("nameplateShowFriendlyGuardians", 0)
		SetCVar("nameplateShowFriendlyTotems", 0)
		SetCVar("nameplateShowEnemies", 1)
		SetCVar("nameplateShowEnemyPets", 1)
		SetCVar("nameplateShowEnemyGuardians", 1)
		SetCVar("nameplateShowEnemyTotems", 1)	
		SetCVar("consolidateBuffs", 0)
		SetCVar("lootUnderMouse", 1)
		SetCVar("autoSelfCast", 1)
		SetCVar("cameraDistanceMax", 50)
		SetCVar("cameraDistanceMaxFactor", 2.3)
	end
	
	-- Var ok, now setting chat frames if using Tukui chats.	
	if (not IsAddOnLoaded("Prat") or not IsAddOnLoaded("Chatter")) then					
		FCF_ResetChatWindows()
		FCF_SetLocked(ChatFrame1, 1)
		FCF_DockFrame(ChatFrame2)
		FCF_SetLocked(ChatFrame2, 1)
		FCF_OpenNewWindow(L.chat_general)
		FCF_SetLocked(ChatFrame3, 1)
		FCF_DockFrame(ChatFrame3)

		FCF_OpenNewWindow(L.chat_trade .. "/" .. LOOT)
		FCF_UnDockFrame(ChatFrame4)
		FCF_SetLocked(ChatFrame4, 1)
		ChatFrame4:Show()

		for i = 1, NUM_CHAT_WINDOWS do
			local frame = _G[format("ChatFrame%s", i)]
			local chatFrameId = frame:GetID()
			local chatName = FCF_GetChatWindowInfo(chatFrameId)
			
			-- set the size of chat frames
			frame:Size(Z.InfoLeftRightWidth + 1, 111)
			
			-- tell wow that we are using new size
			SetChatWindowSavedDimensions(chatFrameId, Z.Scale(Z.InfoLeftRightWidth + 1), Z.Scale(111))
			
			-- move general bottom left or Loot (if found) on right
			if i == 1 then
				frame:ClearAllPoints()
				frame:Point("BOTTOMLEFT", ZuiInfoLeft, "BOTTOMLEFT", -2, (Z.buttonsize - 10) + Z.buttonspacing)
			elseif i == 4 and chatName == L.chat_trade .. "/" .. LOOT then
				frame:ClearAllPoints()
				frame:Point("BOTTOMRIGHT", ZuiInfoRight, "BOTTOMLEFT", -2, (Z.buttonsize - 10) + Z.buttonspacing)
			end
					
			-- save new default position and dimension
			FCF_SavePositionAndDimensions(frame)
			
			-- set default tukui font size
			FCF_SetChatWindowFontSize(nil, frame, 12)
			
			-- rename windows general and combat log
			if i == 1 then FCF_SetWindowName(frame, "G, S & W") end
			if i == 2 then FCF_SetWindowName(frame, "Log") end
		end
		
		ChatFrame_RemoveAllMessageGroups(ChatFrame1)
		ChatFrame_RemoveChannel(ChatFrame1, L.chat_trade) -- erf, it seem we need to localize this now
		ChatFrame_RemoveChannel(ChatFrame1, L.chat_general) -- erf, it seem we need to localize this now
		ChatFrame_RemoveChannel(ChatFrame1, L.chat_defense) -- erf, it seem we need to localize this now
		ChatFrame_RemoveChannel(ChatFrame1, L.chat_recrutment) -- erf, it seem we need to localize this now
		ChatFrame_RemoveChannel(ChatFrame1, L.chat_lfg) -- erf, it seem we need to localize this now
		ChatFrame_AddMessageGroup(ChatFrame1, "SAY")
		ChatFrame_AddMessageGroup(ChatFrame1, "EMOTE")
		ChatFrame_AddMessageGroup(ChatFrame1, "YELL")
		ChatFrame_AddMessageGroup(ChatFrame1, "GUILD")
		ChatFrame_AddMessageGroup(ChatFrame1, "OFFICER")
		ChatFrame_AddMessageGroup(ChatFrame1, "GUILD_ACHIEVEMENT")
		ChatFrame_AddMessageGroup(ChatFrame1, "WHISPER")
		ChatFrame_AddMessageGroup(ChatFrame1, "MONSTER_SAY")
		ChatFrame_AddMessageGroup(ChatFrame1, "MONSTER_EMOTE")
		ChatFrame_AddMessageGroup(ChatFrame1, "MONSTER_YELL")
		ChatFrame_AddMessageGroup(ChatFrame1, "MONSTER_WHISPER")
		ChatFrame_AddMessageGroup(ChatFrame1, "MONSTER_BOSS_EMOTE")
		ChatFrame_AddMessageGroup(ChatFrame1, "MONSTER_BOSS_WHISPER")
		ChatFrame_AddMessageGroup(ChatFrame1, "PARTY")
		ChatFrame_AddMessageGroup(ChatFrame1, "PARTY_LEADER")
		ChatFrame_AddMessageGroup(ChatFrame1, "RAID")
		ChatFrame_AddMessageGroup(ChatFrame1, "RAID_LEADER")
		ChatFrame_AddMessageGroup(ChatFrame1, "RAID_WARNING")
		ChatFrame_AddMessageGroup(ChatFrame1, "BATTLEGROUND")
		ChatFrame_AddMessageGroup(ChatFrame1, "BATTLEGROUND_LEADER")
		ChatFrame_AddMessageGroup(ChatFrame1, "BG_HORDE")
		ChatFrame_AddMessageGroup(ChatFrame1, "BG_ALLIANCE")
		ChatFrame_AddMessageGroup(ChatFrame1, "BG_NEUTRAL")
		ChatFrame_AddMessageGroup(ChatFrame1, "SYSTEM")
		ChatFrame_AddMessageGroup(ChatFrame1, "ERRORS")
		ChatFrame_AddMessageGroup(ChatFrame1, "AFK")
		ChatFrame_AddMessageGroup(ChatFrame1, "DND")
		ChatFrame_AddMessageGroup(ChatFrame1, "IGNORED")
		ChatFrame_AddMessageGroup(ChatFrame1, "ACHIEVEMENT")
		ChatFrame_AddMessageGroup(ChatFrame1, "BN_WHISPER")
		ChatFrame_AddMessageGroup(ChatFrame1, "BN_CONVERSATION")
					
		-- Setup the spam chat frame
		ChatFrame_RemoveAllMessageGroups(ChatFrame3)
		ChatFrame_AddChannel(ChatFrame3, L.chat_general) -- erf, it seem we need to localize this now
		ChatFrame_AddChannel(ChatFrame3, L.chat_recrutment) -- erf, it seem we need to localize this now
		ChatFrame_AddChannel(ChatFrame3, L.chat_lfg) -- erf, it seem we need to localize this now
				
		-- Setup the right chat
		ChatFrame_RemoveAllMessageGroups(ChatFrame4)
    ChatFrame_AddChannel(ChatFrame4, L.chat_trade) -- erf, it seem we need to localize this now
    ChatFrame_AddChannel(ChatFrame4, L.chat_defense) -- erf, it seem we need to localize this now
		ChatFrame_AddMessageGroup(ChatFrame4, "COMBAT_XP_GAIN")
		ChatFrame_AddMessageGroup(ChatFrame4, "COMBAT_HONOR_GAIN")
		ChatFrame_AddMessageGroup(ChatFrame4, "COMBAT_FACTION_CHANGE")
		ChatFrame_AddMessageGroup(ChatFrame4, "SKILL")
    ChatFrame_AddMessageGroup(ChatFrame4, "LOOT")
		ChatFrame_AddMessageGroup(ChatFrame4, "MONEY")
				
		-- enable classcolor automatically on login and on each character without doing /configure each time.
		ToggleChatColorNamesByClassGroup(true, "SAY")
		ToggleChatColorNamesByClassGroup(true, "EMOTE")
		ToggleChatColorNamesByClassGroup(true, "YELL")
		ToggleChatColorNamesByClassGroup(true, "GUILD")
		ToggleChatColorNamesByClassGroup(true, "OFFICER")
		ToggleChatColorNamesByClassGroup(true, "GUILD_ACHIEVEMENT")
		ToggleChatColorNamesByClassGroup(true, "ACHIEVEMENT")
		ToggleChatColorNamesByClassGroup(true, "WHISPER")
		ToggleChatColorNamesByClassGroup(true, "PARTY")
		ToggleChatColorNamesByClassGroup(true, "PARTY_LEADER")
		ToggleChatColorNamesByClassGroup(true, "RAID")
		ToggleChatColorNamesByClassGroup(true, "RAID_LEADER")
		ToggleChatColorNamesByClassGroup(true, "RAID_WARNING")
		ToggleChatColorNamesByClassGroup(true, "BATTLEGROUND")
		ToggleChatColorNamesByClassGroup(true, "BATTLEGROUND_LEADER")	
		ToggleChatColorNamesByClassGroup(true, "CHANNEL1")
		ToggleChatColorNamesByClassGroup(true, "CHANNEL2")
		ToggleChatColorNamesByClassGroup(true, "CHANNEL3")
		ToggleChatColorNamesByClassGroup(true, "CHANNEL4")
		ToggleChatColorNamesByClassGroup(true, "CHANNEL5")
	end
	
	-- reset saved variables on char
	ZuiDataPerChar = {}
	
	--[[ reset movable stuff into original position
	for i = 1, getn(Z.MoverFrames) do
		if Z.MoverFrames[i] then Z.MoverFrames[i]:SetUserPlaced(false) end
	end]]
	
	-- tell savedvariable that we installed Tukui perfectly
	ZuiDataPerChar.install = true
			
	ReloadUI()
end

local function cvar()

end

local function DisableZui()
	DisableAddOn("zUI")
	ReloadUI()
end

------------------------------------------------------------------------
--	Popups
------------------------------------------------------------------------

StaticPopupDialogs["ZUIDISABLE_UI"] = {
	text = L.popup_disableui,
	button1 = ACCEPT,
	button2 = CANCEL,
	OnAccept = DisableZui,
	timeout = 0,
	whileDead = 1,
}

StaticPopupDialogs["ZUIINSTALL_UI"] = {
	text = L.popup_install,
	button1 = ACCEPT,
	button2 = CANCEL,
    OnAccept = install,
	OnCancel = function() ZuiDataPerChar.install = true end,
    timeout = 0,
    whileDead = 1,
}

StaticPopupDialogs["ZUIRESET_UI"] = {
	text = L.popup_reset,
	button1 = ACCEPT,
	button2 = CANCEL,
    OnAccept = install,
	OnCancel = function() ZuiDataPerChar.install = true end,
    timeout = 0,
    whileDead = 1,
}

StaticPopupDialogs["ZUIDISABLE_RAID"] = {
	text = L.popup_2raidactive,
	button1 = "DPS - TANK",
	button2 = "HEAL",
	OnAccept = function() DisableAddOn("zodui_heal") EnableAddOn("zodui_dps") ReloadUI() end,
	OnCancel = function() EnableAddOn("zodui_dps") DisableAddOn("zodui_heal") ReloadUI() end,
	timeout = 0,
	whileDead = 1,
}

------------------------------------------------------------------------
--	On login function, look for some infos!
------------------------------------------------------------------------

local ZuiOnLogon = CreateFrame("Frame")
ZuiOnLogon:RegisterEvent("PLAYER_ENTERING_WORLD")
ZuiOnLogon:SetScript("OnEvent", function(self, event)
	self:UnregisterEvent("PLAYER_ENTERING_WORLD")
	
	-- create empty saved vars if they doesn't exist.
	if (ZuiData == nil) then ZuiData = {} end
	if (ZuiDataPerChar == nil) then ZuiDataPerChar = {} end

	if Z.getscreenwidth < 1200 then
			SetCVar("useUiScale", 0)
			StaticPopup_Show("ZUIDISABLE_UI")
	else
		SetCVar("useUiScale", 1)
		if C["general"].multisampleprotect == true then
			SetMultisampleFormat(1)
		end
		if C["general"].uiscale > 1 then C["general"].uiscale = 1 end
		if C["general"].uiscale < 0.64 then C["general"].uiscale = 0.64 end

		-- set our uiscale
		SetCVar("uiScale", C["general"].uiscale)
		
		-- we adjust UIParent to screen #1 if Eyefinity is found
		if Z.eyefinity then
			local width = Z.eyefinity
			local height = Z.getscreenheight
			
			-- if autoscale is off, find a new width value of UIParent for screen #1.
			if not C.general.autoscale or height > 1200 then
				local h = UIParent:GetHeight()
				local ratio = Z.getscreenheight / h
				local w = Z.eyefinity / ratio
				
				width = w
				height = h			
			end
			
			UIParent:SetSize(width, height)
			UIParent:ClearAllPoints()
			UIParent:SetPoint("CENTER")		
		end
		
		-- install default if we never ran Tukui on this character.
		if not ZuiDataPerChar.install then			
			StaticPopup_Show("ZUIINSTALL_UI")
		end
	end
	
	if (IsAddOnLoaded("zodui_dps") and IsAddOnLoaded("zodui_heal")) then
		StaticPopup_Show("ZUIDISABLE_RAID")
	end
	
	print(L.core_welcome1..Z.version)
	print(L.core_welcome2)
end)

------------------------------------------------------------------------
--	UI HELP
------------------------------------------------------------------------

-- Print Help Messages
local function UIHelp()
	print(" ")
	print(L.core_uihelp1)
	print(L.core_uihelp2)
	print(L.core_uihelp3)
	print(L.core_uihelp4)
	print(L.core_uihelp5)
	print(L.core_uihelp6)
	print(L.core_uihelp7)
	print(L.core_uihelp8)
	print(L.core_uihelp9)
	print(L.core_uihelp10)
	print(L.core_uihelp11)
  print(L.core_uihelp12)
	print(" ")
	print(L.core_uihelp100)
end

SLASH_UIHELP1 = "/UIHelp"
SlashCmdList["UIHELP"] = UIHelp

SLASH_CONFIGURE1 = "/resetui"
SlashCmdList.CONFIGURE = function() StaticPopup_Show("ZUIRESET_UI") end