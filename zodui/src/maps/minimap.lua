local Z, C, L = unpack(select(2, ...)) -- Import: Z - functions, constants, variables; C - config; L - locales
--------------------------------------------------------------------
-- Zui Minimap Script
--------------------------------------------------------------------

local ZuiMinimap = CreateFrame("Frame", "ZuiMinimap", UIParent)
ZuiMinimap:CreatePanel("Default", 1, 1, "CENTER", UIParent, "CENTER", 0, 0)
ZuiMinimap:RegisterEvent("ADDON_LOADED")
ZuiMinimap:Point("TOPRIGHT", UIParent, "TOPRIGHT", -5, -5)
ZuiMinimap:Size(144, 144)
ZuiMinimap:CreateShadow("Default")
ZuiMinimap:SetClampedToScreen(true)
ZuiMinimap:SetMovable(true)
ZuiMinimap.text = Z.SetFontString(ZuiMinimap, C.media.uffont, 12)
ZuiMinimap.text:SetPoint("CENTER")
ZuiMinimap.text:SetText(L.move_minimap)

-- kill the minimap cluster
MinimapCluster:Kill()

-- Parent Minimap into our Map frame.
Minimap:SetParent(ZuiMinimap)
Minimap:ClearAllPoints()
Minimap:Point("TOPLEFT", 2, -2)
Minimap:Point("BOTTOMRIGHT", -2, 2)

-- Hide Border
MinimapBorder:Hide()
MinimapBorderTop:Hide()

-- Hide Zoom Buttons
MinimapZoomIn:Hide()
MinimapZoomOut:Hide()

-- Hide Voice Chat Frame
MiniMapVoiceChatFrame:Hide()

-- Hide North texture at top
MinimapNorthTag:SetTexture(nil)

-- Hide Zone Frame
MinimapZoneTextButton:Hide()

-- Hide Tracking Button
MiniMapTracking:Hide()

-- Hide Calendar Button
GameTimeFrame:Hide()

-- Hide Mail Button
MiniMapMailFrame:ClearAllPoints()
MiniMapMailFrame:Point("TOPRIGHT", Minimap, 3, 3)
MiniMapMailBorder:Hide()
MiniMapMailIcon:SetTexture("Interface\\AddOns\\zodui\\resource\\textures\\mail")

-- Move battleground icon
MiniMapBattlefieldFrame:ClearAllPoints()
MiniMapBattlefieldFrame:Point("BOTTOMRIGHT", Minimap, 3, 0)
MiniMapBattlefieldBorder:Hide()

-- Hide world map button
MiniMapWorldMapButton:Hide()

-- shitty 3.3 flag to move
MiniMapInstanceDifficulty:ClearAllPoints()
MiniMapInstanceDifficulty:SetParent(Minimap)
MiniMapInstanceDifficulty:SetPoint("TOPLEFT", Minimap, "TOPLEFT", 0, 0)

--[[ 4.0.6 Guild instance difficulty
GuildInstanceDifficulty:ClearAllPoints()
GuildInstanceDifficulty:SetParent(Minimap)
GuildInstanceDifficulty:SetPoint("TOPLEFT", Minimap, "TOPLEFT", 0, 0)]]

-- Reposition lfg icon at bottom-left
local function UpdateLFG()
	MiniMapLFGFrame:ClearAllPoints()
	MiniMapLFGFrame:Point("BOTTOMRIGHT", Minimap, "BOTTOMRIGHT", 2, 1)
	MiniMapLFGFrameBorder:Hide()
	
--	LFDDungeonReadyStatus:ClearAllPoints()
--	LFDDungeonReadyStatus:SetPoint("TOPRIGHT", Minimap, "BOTTOMLEFT", 5, -5)
--	LFDDungeonReadyStatus:SetScale(1)
--	LFDDungeonReadyStatus:SetAlpha(1,0.8)

--	LFDDungeonReadyDialog:ClearAllPoints()
--	LFDDungeonReadyDialog:SetPoint("TOPRIGHT", Minimap, "BOTTOMLEFT", -5, 5)
--	LFDDungeonReadyDialog:SetScale(1)
--	LFDDungeonReadyDialog:SetAlpha(1,0.8)

	LFDSearchStatus:ClearAllPoints()
	LFDSearchStatus:Point("TOPRIGHT", Minimap, "BOTTOMLEFT", -5, -5)
	LFDSearchStatus:SetScale(1)
	LFDSearchStatus:SetAlpha(1,0.8)
end
hooksecurefunc("MiniMapLFG_UpdateIsShown", UpdateLFG)

-- reskin LFG dropdown
LFDSearchStatus:SetTemplate("Default")

-- for t13+, if we move map we need to point LFDSearchStatus according to our Minimap position.
local function UpdateLFGTooltip()
	local position = ZuiMinimap:GetPoint()
	LFDSearchStatus:ClearAllPoints()
	if position:match("BOTTOMRIGHT") then
		LFDSearchStatus:SetPoint("BOTTOMRIGHT", MiniMapLFGFrame, "BOTTOMLEFT", 0, 0)
	elseif position:match("BOTTOM") then
		LFDSearchStatus:SetPoint("BOTTOMLEFT", MiniMapLFGFrame, "BOTTOMRIGHT", 4, 0)
	elseif position:match("LEFT") then		
		LFDSearchStatus:SetPoint("TOPLEFT", MiniMapLFGFrame, "TOPRIGHT", 4, 0)
	else
		LFDSearchStatus:SetPoint("TOPRIGHT", MiniMapLFGFrame, "TOPLEFT", 0, 0)	
	end
end

-- Enable mouse scrolling
Minimap:EnableMouseWheel(true)
Minimap:SetScript("OnMouseWheel", function(self, d)
	if d > 0 then
		_G.MinimapZoomIn:Click()
	elseif d < 0 then
		_G.MinimapZoomOut:Click()
	end
end)

-- Set Square Map Mask
Minimap:SetMaskTexture(C.media.blank)

-- For others mods with a minimap button, set minimap buttons position in square mode.
function GetMinimapShape() return "SQUARE" end

-- do some stuff on addon loaded or player login event
ZuiMinimap:RegisterEvent("PLAYER_LOGIN")
ZuiMinimap:RegisterEvent("ADDON_LOADED")
ZuiMinimap:SetScript("OnEvent", function(self, event, addon)
	if event == "PLAYER_LOGIN" then
		UpdateLFGTooltip()
	elseif addon == "Blizzard_TimeManager" then
		-- Hide Game Time
		TimeManagerClockButton:Kill()
	end
end)

----------------------------------------------------------------------------------------
-- Right click menu, used to show micro menu
----------------------------------------------------------------------------------------

local menuFrame = CreateFrame("Frame", "ZuiMinimapMiddleClickMenu", ZuiMinimap, "UIDropDownMenuTemplate")
local menuList = {
    {text = CHARACTER_BUTTON,
    func = function() ToggleCharacter("PaperDollFrame") end},
    {text = SPELLBOOK_ABILITIES_BUTTON,
    func = function() ToggleFrame(SpellBookFrame) end},
    {text = TALENTS_BUTTON,
    func = function() if not PlayerTalentFrame then LoadAddOn("Blizzard_TalentUI") end if not GlyphFrame then LoadAddOn("Blizzard_GlyphUI") end PlayerTalentFrame_Toggle() end},
    {text = ACHIEVEMENT_BUTTON,
    func = function() ToggleAchievementFrame() end},
    {text = QUESTLOG_BUTTON,
    func = function() ToggleFrame(QuestLogFrame) end},
    {text = SOCIAL_BUTTON,
    func = function() ToggleFriendsFrame(1) end},
    {text = PLAYER_V_PLAYER,
    func = function() ToggleFrame(PVPFrame) end},
    {text = ACHIEVEMENTS_GUILD_TAB,
    func = function() if IsInGuild() then if not GuildFrame then LoadAddOn("Blizzard_GuildUI") end GuildFrame_Toggle() end end},
    {text = LFG_TITLE,
    func = function() ToggleFrame(LFDParentFrame) end},
    {text = L_LFRAID,
    func = function() ToggleFrame(LFRParentFrame) end},
    {text = HELP_BUTTON,
    func = function() ToggleHelpFrame() end},
    {text = L_CALENDAR,
    func = function()
    if(not CalendarFrame) then LoadAddOn("Blizzard_Calendar") end
        Calendar_Toggle()
    end},
}

Minimap:SetScript("OnMouseUp", function(self, btn)
	local position = ZuiMinimap:GetPoint()
	if btn == "RightButton" then
		local xoff = 0
		
		if position:match("RIGHT") then xoff = Z.Scale(-16) end
		ToggleDropDownMenu(1, nil, MiniMapTrackingDropDown, ZuiMinimap, xoff, Z.Scale(-2))
	elseif btn == "MiddleButton" then
		if position:match("LEFT") then
			EasyMenu(menuList, menuFrame, "cursor", 0, 0, "MENU", 2)
		else
			EasyMenu(menuList, menuFrame, "cursor", -160, 0, "MENU", 2)
		end
	else
		Minimap_OnClick(self)
	end
end)

-- eyefinity fix to not show tracking behind bezel
--MiniMapTrackingDropDown:SetParent(ZuiMinimap)

-- Move the zonetext
local pvpTextString = PVPInfoTextString
PVPInfoTextString:SetText("")
ZoneTextFrame:ClearAllPoints()									      --Location of Zone text
ZoneTextFrame:SetPoint("TOP", UIParent, "TOP", 0, -250)
SubZoneTextFrame:ClearAllPoints()									  --Location of Subzone Text
SubZoneTextFrame:SetPoint("TOP", UIParent, "TOP", 0, -270)

----------------------------------------------------------------------------------------
-- Mouseover map, displaying zone and coords
----------------------------------------------------------------------------------------

local m_zone = CreateFrame("Frame",nil,UIParent)
m_zone:CreatePanel("Default", 0, 20, "TOPLEFT", Minimap, "TOPLEFT", 2,-2)
m_zone:SetFrameLevel(5)
m_zone:SetFrameStrata("LOW")
m_zone:Point("TOPRIGHT",Minimap,-2,-2)
m_zone:SetAlpha(0)

local m_zone_text = m_zone:CreateFontString(nil,"Overlay")
m_zone_text:SetFont(C["media"].font,12)
m_zone_text:Point("TOP", 0, -1)
m_zone_text:SetPoint("BOTTOM")
m_zone_text:Height(12)
m_zone_text:Width(m_zone:GetWidth()-6)
m_zone_text:SetAlpha(0)

local m_coord = CreateFrame("Frame",nil,UIParent)
m_coord:CreatePanel("Default", 40, 20, "BOTTOMLEFT", Minimap, "BOTTOMLEFT", 2,2)
m_coord:SetFrameStrata("LOW")
m_coord:SetAlpha(0)

local m_coord_text = m_coord:CreateFontString(nil,"Overlay")
m_coord_text:SetFont(C["media"].font,12)
m_coord_text:Point("Center",-1,0)
m_coord_text:SetAlpha(0)
m_coord_text:SetText("00,00")

Minimap:SetScript("OnEnter",function()
	m_zone:SetAlpha(1)
	m_zone_text:SetAlpha(1)
	m_coord:SetAlpha(1)
	m_coord_text:SetAlpha(1)
end)

Minimap:SetScript("OnLeave",function()
	m_zone:SetAlpha(0)
	m_zone_text:SetAlpha(0)
	m_coord:SetAlpha(0)
	m_coord_text:SetAlpha(0)
end)
 
local ela = 0
local coord_Update = function(self,t)
	ela = ela - t
	if ela > 0 then return end
	local x,y = GetPlayerMapPosition("player")
	local xt,yt
	x = math.floor(100 * x)
	y = math.floor(100 * y)
	if x == 0 and y == 0 then
		m_coord_text:SetText("X _ X")
	else
		if x < 10 then
			xt = "0"..x
		else
			xt = x
		end
		if y < 10 then
			yt = "0"..y
		else
			yt = y
		end
		m_coord_text:SetText(xt..","..yt)
	end
	ela = .2
end
m_coord:SetScript("OnUpdate",coord_Update)
 
local zone_Update = function()
	local pvp = GetZonePVPInfo()
	m_zone_text:SetText(GetMinimapZoneText())
	if pvp == "friendly" then
		m_zone_text:SetTextColor(0.1, 1.0, 0.1)
	elseif pvp == "sanctuary" then
		m_zone_text:SetTextColor(0.41, 0.8, 0.94)
	elseif pvp == "arena" or pvp == "hostile" then
		m_zone_text:SetTextColor(1.0, 0.1, 0.1)
	elseif pvp == "contested" then
		m_zone_text:SetTextColor(1.0, 0.7, 0.0)
	else
		m_zone_text:SetTextColor(1.0, 1.0, 1.0)
	end
end
 
m_zone:RegisterEvent("PLAYER_ENTERING_WORLD")
m_zone:RegisterEvent("ZONE_CHANGED_NEW_AREA")
m_zone:RegisterEvent("ZONE_CHANGED")
m_zone:RegisterEvent("ZONE_CHANGED_INDOORS")
m_zone:SetScript("OnEvent",zone_Update) 