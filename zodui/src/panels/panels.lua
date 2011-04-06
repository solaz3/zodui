local Z, C, L = unpack(select(2, ...)) -- Import: Z - functions, constants, variables; C - config; L - locales

local height = Z.buttonsize - 10

-- INFO LEFT (FOR STATS)
local ileft = CreateFrame("Frame", "ZuiInfoLeft", UIParent)
ileft:SetFrameLevel(2)
ileft:SetTemplate("Default", true)
ileft:CreateShadow("Default")
ileft:SetWidth(Z.InfoLeftRightWidth - 12)
ileft:SetHeight(height)
ileft:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", 10, 10)
--ileft:CreatePanel("Default", Z.InfoLeftRightWidth - 12, height, "BOTTOMLEFT", UIParent, "BOTTOMLEFT", 10, 10)


-- INFO RIGHT (FOR STATS)
local iright = CreateFrame("Frame", "ZuiInfoRight", UIParent)
iright:CreatePanel("Default", Z.InfoLeftRightWidth - 12, height, "BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -10, 10)
iright:SetFrameLevel(2)
iright:SetTemplate("Default", true)
iright:CreateShadow("Default")

--[[ INFO BOTTOM (FOR STATS)
local ibottom = CreateFrame("Frame", "ZuiInfoBottom", UIParent)
ibottom:CreatePanel("Default", Z.buttonspacing*11.5+Z.buttonsize*11, height, "BOTTOM", UIParent, "BOTTOM", 0, 5)
ibottom:SetFrameLevel(2)]]

-- INFO TOPLEFT (FOR STATS)
local itop = CreateFrame("Frame", "ZuiInfoTop", UIParent)
itop:CreatePanel("Default", Z.InfoLeftRightWidth - Z.buttonspacing, height, "TOPLEFT", UIParent, "TOPLEFT", 5, -5)
itop:SetFrameLevel(2)
itop:SetTemplate("Default", true)
itop:CreateShadow("Default")

--if C.chat.background then
	-- CHAT BG LEFT
	local chatleftbg = CreateFrame("Frame", "ZuiChatBackgroundLeft", ZuiInfoLeft)
	chatleftbg:CreatePanel("Transparent", Z.InfoLeftRightWidth, (120 + (height * 3)) - 4, "BOTTOM", ZuiInfoLeft, "BOTTOM", 0, -5)
  chatleftbg:CreateShadow("Default")
  
	-- CHAT BG RIGHT
	local chatrightbg = CreateFrame("Frame", "ZuiChatBackgroundRight", ZuiInfoRight)
	chatrightbg:CreatePanel("Transparent", Z.InfoLeftRightWidth, (120 + (height * 3)) - 4, "BOTTOM", ZuiInfoRight, "BOTTOM", 0, -5)
	chatrightbg:CreateShadow("Default")
  
	-- LEFT TAB PANEL
	local tabsbgleft = CreateFrame("Frame", "ZuiTabsLeftBackground", chatleftbg)
	tabsbgleft:CreatePanel("Default", Z.InfoLeftRightWidth - 12, height, "TOP", chatleftbg, "TOP", 0, -5)
	tabsbgleft:SetFrameLevel(2)
  tabsbgleft:SetTemplate("Default", true)
  tabsbgleft:CreateShadow("Default")

	-- RIGHT TAB PANEL
	local tabsbgright = CreateFrame("Frame", "ZuiTabsRightBackground", chatrightbg)
	tabsbgright:CreatePanel("Default", Z.InfoLeftRightWidth - 12, height, "TOP", chatrightbg, "TOP", 0, -5)
	tabsbgright:SetFrameLevel(2)
  tabsbgright:SetTemplate("Default", true)
  tabsbgright:CreateShadow("Default")
--end

--if C.actionbar.enable then
	local TukuiBar1 = CreateFrame("Frame", "TukuiBar1", UIParent, "SecureHandlerStateTemplate")
	TukuiBar1:CreatePanel("Default", (Z.buttonsize * 12) + (Z.buttonspacing * 13) , (Z.buttonsize * 2) + (Z.buttonspacing * 3) , "BOTTOM", UIParent, "BOTTOM", 0, 8)
	TukuiBar1:SetPoint("BOTTOM", UIParent, "BOTTOM", 0, 5)
  TukuiBar1:SetFrameStrata("BACKGROUND")
  TukuiBar1:CreateShadow("Default")
	TukuiBar1:SetFrameLevel(2)

  -- split left
  local TukuiBar2 = CreateFrame("Frame", "TukuiBar2", UIParent)
	TukuiBar2:CreatePanel("Default",  (Z.buttonsize * 3) + (Z.buttonspacing * 4), TukuiBar1:GetHeight(), "BOTTOMRIGHT", TukuiBar1, "BOTTOMLEFT", -6, 0)
  TukuiBar2:SetFrameStrata("BACKGROUND")
  TukuiBar2:CreateShadow("Default")
	TukuiBar2:SetFrameLevel(2)
  
  -- split right
  local TukuiBar3 = CreateFrame("Frame", "TukuiBar3", UIParent)
	TukuiBar3:CreatePanel("Default",  (Z.buttonsize * 3) + (Z.buttonspacing * 4), TukuiBar1:GetHeight(), "BOTTOMLEFT", TukuiBar1, "BOTTOMRIGHT", 6, 0)
  TukuiBar3:SetFrameStrata("BACKGROUND")
  TukuiBar3:CreateShadow("Default")
	TukuiBar3:SetFrameLevel(2)

  -- right barbg
	local TukuiBar4 = CreateFrame("Frame", "TukuiBar4", UIParent)
	TukuiBar4:CreatePanel("Default", TukuiBar1:GetHeight(), (Z.buttonsize * 12) + (Z.buttonspacing * 13), "TOPRIGHT", Minimap, "BOTTOMRIGHT", 2, -Z.buttonsize * 2)
  TukuiBar4:SetFrameStrata("BACKGROUND")
  TukuiBar4:CreateShadow("Default")
	TukuiBar4:SetFrameLevel(2)
  
	--[[local TukuiBar5 = CreateFrame("Frame", "TukuiBar5", ZuiChatBackgroundRight)
	TukuiBar5:SetWidth(Z.InfoLeftRightWidth + 2)
	TukuiBar5:SetHeight(Z.buttonsize + (Z.buttonspacing * 2))
	TukuiBar5:Point("BOTTOM", ZuiChatBackgroundRight, "TOP", -2, 0)
	TukuiBar5:SetFrameStrata("BACKGROUND")
	TukuiBar5:SetFrameLevel(2)

	local TukuiBar6 = CreateFrame("Frame", "TukuiBar6", ZuiChatBackgroundRight)
	TukuiBar6:SetWidth(Z.InfoLeftRightWidth + 2)
	TukuiBar6:SetHeight(Z.buttonsize + (Z.buttonspacing * 2))
	TukuiBar6:SetPoint("BOTTOM", ZuiChatBackgroundRight, "TOP", 0, Z.buttonspacing)
	TukuiBar6:SetFrameStrata("BACKGROUND")
	TukuiBar6:SetFrameLevel(2)
	TukuiBar6:SetAlpha(1)

	local TukuiBar7 = CreateFrame("Frame", "TukuiBar7", ZuiChatBackgroundRight)
	TukuiBar7:SetWidth(Z.InfoLeftRightWidth + 2)
	TukuiBar7:SetHeight(Z.buttonsize + (Z.buttonspacing * 2))
	TukuiBar7:SetPoint("BOTTOM", ZuiChatBackgroundRight, "TOP", 0, Z.buttonspacing)
	TukuiBar7:SetFrameStrata("BACKGROUND")
	TukuiBar7:SetFrameLevel(2)
	TukuiBar7:SetAlpha(1)]]

	local petbg = CreateFrame("Frame", "TukuiPetBar", UIParent, "SecureHandlerStateTemplate")
  petbg:CreatePanel("Default", Z.petbuttonsize + (Z.buttonspacing * 2), (Z.petbuttonsize * 10) + (Z.buttonspacing * 11), "RIGHT", UIParent, "RIGHT", Z.Scale(-6), Z.Scale(-13.5))
  petbg:SetFrameLevel(3)
--end
	local ltpetbg = CreateFrame("Frame", "TukuiLineToPetBar", petbg)
  ltpetbg:CreatePanel("Default", 30, 265, "LEFT", petbg, "RIGHT", 0, 0)
  ltpetbg:SetTemplate("Transparent")
  ltpetbg:SetScript("OnShow", function(self)
		self:SetFrameStrata("BACKGROUND")
		self:SetFrameLevel(0)
	end)
	petbg:CreateShadow("Default")
--[[  
  local vbarbg = CreateFrame("Frame", "TukuiVehicleBar", UIParent)
	vbarbg:CreatePanel("Default", 1, 1, "BOTTOM", TukuiBar1, "TOP", 0, Z.buttonspacing)
	vbarbg:SetWidth(height)
	vbarbg:SetHeight(height)
	vbarbg:CreateShadow("Default")]]
  
-- VIEWPORT ON TOP AND BOTTOM OF THE UI
--if C["others"].viewport then	
	local tbar = CreateFrame("Frame", "TukuiTopBar", UIParent)
	tbar:CreatePanel("Default", 1, 1, "TOP", UIParent, "TOP", 0, Z.buttonspacing)
	tbar:SetWidth(Z.getscreenwidth + 4)
	tbar:SetHeight(height+2)
	tbar:SetFrameStrata("BACKGROUND")
	tbar:SetFrameLevel(0)
  tbar:SetTemplate("Transparent")
  tbar:CreateShadow("Default")

	local bbar = CreateFrame("Frame", "TukuiBottomBar", UIParent)
	bbar:CreatePanel("Default", 1, 1, "BOTTOM", UIParent, "BOTTOM", 0, -Z.buttonspacing)
	bbar:SetWidth(Z.getscreenwidth + 4)
	bbar:SetHeight(height+2)
	bbar:SetFrameStrata("BACKGROUND")
	bbar:SetFrameLevel(0)
  bbar:SetTemplate("Transparent")
  bbar:CreateShadow("Default")

--end

-- CUBE AT LEFT, ACT AS A BUTTON (CHAT MENU)
local cubeleft = CreateFrame("Frame", "ZuiCubeLeft", TukuiBar1)
cubeleft:CreatePanel("Default", height/2, height, "BOTTOMRIGHT", TukuiBar2, "BOTTOMLEFT", -Z.buttonspacing, 0)
cubeleft:SetTemplate("Default", true)
cubeleft:EnableMouse(true)
cubeleft:SetScript("OnMouseDown", function(self, btn)
	if ZuiInfoLeftBattleGround and UnitInBattleground("player") then
		if btn == "RightButton" then
			if ZuiInfoLeftBattleGround:IsShown() then
				ZuiInfoLeftBattleGround:Hide()
			else
				ZuiInfoLeftBattleGround:Show()
			end
		end
	end
	if btn == "LeftButton" then	
		ToggleFrame(ChatMenu)
	end
end)

-- CUBE AT RIGHT, ACT AS A BUTTON (CONFIGUI or BG'S)
local cuberight = CreateFrame("Frame", "ZuiCubeRight", TukuiBar1)
cuberight:CreatePanel("Default", height/2, height, "BOTTOMLEFT", TukuiBar3, "BOTTOMRIGHT", Z.buttonspacing, 0)
cuberight:SetTemplate("Default", true)
--if C["bags"].enable then
	cuberight:EnableMouse(true)
	--cuberight:SetScript("OnMouseDown", function(self)
	--	ToggleKeyRing()
	--end)
--end

--BATTLEGROUND STATS FRAME
if C["datatext"].battleground == true then
	local bgframe = CreateFrame("Frame", "ZuiInfoLeftBattleGround", UIParent)
	bgframe:CreatePanel("Default", 1, 1, "TOPLEFT", UIParent, "BOTTOMLEFT", 0, 0)
	bgframe:SetAllPoints(ileft)
	bgframe:SetFrameStrata("LOW")
	bgframe:SetFrameLevel(0)
	bgframe:EnableMouse(true)
end
