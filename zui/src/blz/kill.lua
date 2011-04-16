local Z, C, L = unpack(select(2, ...)) -- Import: Z - functions, constants, variables; C - config; L - locales
-- here we kill all shit stuff on default UI that we don't need!
local Kill = CreateFrame("Frame")
Kill:RegisterEvent("ADDON_LOADED")
Kill:RegisterEvent("PLAYER_LOGIN")
Kill:SetScript("OnEvent", function(self, event, addon)
	if event == "PLAYER_LOGIN" then
		if IsAddOnLoaded("zui_dps") or IsAddOnLoaded("zui_heal") then
			InterfaceOptionsFrameCategoriesButton10:SetScale(0.00001)
			InterfaceOptionsFrameCategoriesButton10:SetAlpha(0)		
			InterfaceOptionsFrameCategoriesButton11:SetScale(0.00001)
			InterfaceOptionsFrameCategoriesButton11:SetAlpha(0)
			if Z.isctm then
        CompactPartyFrame:Kill()
        CompactRaidFrameManager:Kill()
        CompactRaidFrameContainer:Kill()
      end
		end	
	else
		if addon == "Blizzard_AchievementUI" then
			if C.tooltip.enable then
				hooksecurefunc("AchievementFrameCategories_DisplayButton", function(button) button.showTooltipFunc = nil end)
			end
		end
		
		if addon ~= "zui" then return end
		if Z.isctm then
      StreamingIcon:Kill()
      Advanced_UseUIScale:Kill()
      Advanced_UIScaleSlider:Kill()		
      BuffFrame:Kill()
      TemporaryEnchantFrame:Kill()
      ConsolidatedBuffs:Kill()
    end
    PartyMemberBackground:Kill()
		TutorialFrameAlertButton:Kill()		
		InterfaceOptionsBuffsPanelConsolidateBuffs:Kill()
		InterfaceOptionsUnitFramePanelPartyBackground:Kill()

		-- make sure boss or arena frame is always disabled when running tukui
		SetCVar("showArenaEnemyFrames", 0)
		
		if C.arena.unitframes then
			InterfaceOptionsUnitFramePanelArenaEnemyFrames:Kill()
			InterfaceOptionsUnitFramePanelArenaEnemyCastBar:Kill()
			InterfaceOptionsUnitFramePanelArenaEnemyPets:Kill()
		end
		
		if C.chat.enable then
			SetCVar("WholeChatWindowClickable", 0)
			SetCVar("ConversationMode", "inline")
			InterfaceOptionsSocialPanelWholeChatWindowClickable:Kill()
			InterfaceOptionsSocialPanelConversationMode:Kill()
		end
		
		if C.unitframes.enable then
			PlayerFrame:Kill() -- Just to be sure we are safe
			InterfaceOptionsFrameCategoriesButton9:SetScale(0.00001)
			InterfaceOptionsFrameCategoriesButton9:SetAlpha(0)	
			InterfaceOptionsFrameCategoriesButton9:SetScale(0.00001)
			InterfaceOptionsFrameCategoriesButton9:SetAlpha(0)
		end
		
		if C.actionbar.enable then
			InterfaceOptionsActionBarsPanelBottomLeft:Kill()
			InterfaceOptionsActionBarsPanelBottomRight:Kill()
			InterfaceOptionsActionBarsPanelRight:Kill()
			InterfaceOptionsActionBarsPanelRightTwo:Kill()
			InterfaceOptionsActionBarsPanelAlwaysShowActionBars:Kill()
		end
	end
end)
