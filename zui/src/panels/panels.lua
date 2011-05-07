local Z, C, L = unpack(select(2, ...)) 

-- main action bar + multi left bar
local ZuiBar1 = CreateFrame("Frame", "ZuiBar1", UIParent, "SecureHandlerStateTemplate")
ZuiBar1:CreatePanel("Transparent", 1, 1, "BOTTOM", UIParent, "BOTTOM", 0, 7)
ZuiBar1:SetWidth((Z.buttonsize * 12) + (Z.buttonspacing * 13))
ZuiBar1:SetHeight((Z.buttonsize * 2) + (Z.buttonspacing * 3))
ZuiBar1:SetFrameStrata("BACKGROUND")
ZuiBar1:SetFrameLevel(2)
ZuiBar1:SetBorder()

-- left action bar (6 slots) multi bottom left
local ZuiBar2 = CreateFrame("Frame", "ZuiBar2", UIParent)
ZuiBar2:CreatePanel("Transparent", 1, 1, "BOTTOMRIGHT", ZuiBar1, "BOTTOMLEFT", -10, 0)
ZuiBar2:SetWidth((Z.buttonsize * 3) + (Z.buttonspacing * 4))
ZuiBar2:SetHeight((Z.buttonsize * 2) + (Z.buttonspacing * 3))
ZuiBar2:SetFrameStrata("BACKGROUND")
ZuiBar2:SetFrameLevel(2)
ZuiBar2:SetBorder()

-- right action bar (6 slots) multi bottom left
local ZuiBar3 = CreateFrame("Frame", "ZuiBar3", UIParent)
ZuiBar3:CreatePanel("Transparent", 1, 1, "BOTTOMLEFT", ZuiBar1, "BOTTOMRIGHT", 10, 0)
ZuiBar3:SetWidth((Z.buttonsize * 3) + (Z.buttonspacing * 4))
ZuiBar3:SetHeight((Z.buttonsize * 2) + (Z.buttonspacing * 3))
ZuiBar3:SetFrameStrata("BACKGROUND")
ZuiBar3:SetFrameLevel(2)
ZuiBar3:SetBorder()

-- action bar for multi bottom right action bar
local ZuiBar4 = CreateFrame("Frame", "ZuiBar4", UIParent)
ZuiBar4:CreatePanel("Transparent", 1, 1, "BOTTOM", UIParent, "BOTTOM", 0, 7)
ZuiBar4:SetWidth((Z.buttonsize * 12) + (Z.buttonspacing * 13))
ZuiBar4:SetHeight((Z.buttonsize * 2) + (Z.buttonspacing * 3))
ZuiBar4:SetFrameStrata("BACKGROUND")
ZuiBar4:SetFrameLevel(2)
ZuiBar4:SetBorder()

-- action bar for multi right
local ZuiBar5 = CreateFrame("Frame", "ZuiBar5", UIParent)
ZuiBar5:CreatePanel("Transparent", 1, (Z.buttonsize * 12) + (Z.buttonspacing * 13), "RIGHT", UIParent, "RIGHT", -5, -40)
ZuiBar5:SetWidth((Z.buttonsize * 2) + (Z.buttonspacing * 3))
ZuiBar5:SetFrameStrata("BACKGROUND")
ZuiBar5:SetFrameLevel(2)
ZuiBar5:SetBorder()

-- action bar for multi right
local ZuiBar6 = CreateFrame("Frame", "ZuiBar6", UIParent)
ZuiBar6:CreatePanel("Transparent", 1, (Z.buttonsize * 12) + (Z.buttonspacing * 13), "RIGHT", UIParent, "RIGHT", -5, -40)
ZuiBar6:SetWidth((Z.buttonsize * 2) + (Z.buttonspacing * 3))
ZuiBar6:SetFrameStrata("BACKGROUND")
ZuiBar6:SetFrameLevel(2)
ZuiBar6:SetBorder()


local petbg = CreateFrame("Frame", "ZuiPetBar", UIParent, "SecureHandlerStateTemplate")
petbg:CreatePanel("Hydra", Z.petbuttonsize + (Z.petbuttonspacing * 2), (Z.petbuttonsize * 10) + (Z.petbuttonspacing * 11), "RIGHT", ZuiBar5, "LEFT", -6, 0)

local ltpetbg = CreateFrame("Frame", "ZuiLineToPetActionBarBackground", petbg)
ltpetbg:CreatePanel("Hydra", 24, 265, "LEFT", petbg, "RIGHT", 0, 0)
ltpetbg:SetParent(petbg)
ltpetbg:SetFrameStrata("BACKGROUND")
ltpetbg:SetFrameLevel(0)
ltpetbg:SetAlpha(.8)

-- INVISIBLE FRAME COVERING BOTTOM ACTIONBARS JUST TO PARENT UF CORRECTLY
local invbarbg = CreateFrame("Frame", "InvZuiActionBarBackground", UIParent)
	invbarbg:SetPoint("TOPLEFT", ZuiBar2)
	invbarbg:SetPoint("BOTTOMRIGHT", ZuiBar3)

-- INFO LEFT (FOR STATS)
local ileft = CreateFrame("Frame", "ZuiInfoLeft", ZuiBar1)
ileft:CreatePanel("Hydra", C.general.infowidth, 20, "BOTTOMLEFT", UIParent, "BOTTOMLEFT", Z.Scale(5), Z.Scale(7))
ileft:SetFrameLevel(2)
ileft:SetFrameStrata("BACKGROUND")
ileft:CreateShadow("Hydra")

-- INFO RIGHT (FOR STATS)
local iright = CreateFrame("Frame", "ZuiInfoRight", ZuiBar1)
iright:CreatePanel("Hydra", C.general.infowidth, 20, "BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", Z.Scale(-5), Z.Scale(7))
iright:SetFrameLevel(2)
iright:SetFrameStrata("BACKGROUND")
iright:CreateShadow("Hydra")

if C.chat.background then
	-- CHAT BG LEFT
	local chatleftbg = CreateFrame("Frame", "ZuiChatBackgroundLeft", ZuiInfoLeft)
	chatleftbg:CreatePanel("Transparent", C.general.infowidth, C.chat.height+6, "BOTTOM", ZuiInfoLeft, "BOTTOM", 0, Z.Scale(22))
	chatleftbg:SetFrameLevel(1)
  chatleftbg:SetFrameStrata("LOW")
	chatleftbg:CreateShadow("")
	chatleftbg:SetBorder()
	
	-- CHAT BG RIGHT
	local chatrightbg = CreateFrame("Frame", "ZuiChatBackgroundRight", ZuiInfoRight)
	chatrightbg:CreatePanel("Transparent", C.general.infowidth, C.chat.height+6, "BOTTOM", ZuiInfoRight, "BOTTOM", 0, Z.Scale(22))
	--chatrightbg:Hide() --This will get shown if a chat exists in the bottomright corner
	chatrightbg:SetFrameLevel(1)
  chatrightbg:SetFrameStrata("LOW")
	chatrightbg:CreateShadow("")
	chatrightbg:SetBorder()
	
	-- LEFT TAB PANEL
	local tabsbgleft = CreateFrame("Frame", "ZuiTabsLeftBackground", ZuiBar1)
	tabsbgleft:CreatePanel("Transparent", C.general.infowidth, 16, "BOTTOMLEFT", chatleftbg, "TOPLEFT", 0, Z.Scale(2))
	tabsbgleft:SetFrameLevel(1)
	tabsbgleft:SetFrameStrata("LOW")
	tabsbgleft:CreateShadow("")
	tabsbgleft:SetBorder()

	-- RIGHT TAB PANEL
	local tabsbgright = CreateFrame("Frame", "ZuiTabsRightBackground", ZuiBar1)
	tabsbgright:CreatePanel("Transparent", C.general.infowidth, 16, "BOTTOMLEFT", chatrightbg, "TOPLEFT", 0, Z.Scale(2))
	tabsbgright:SetFrameLevel(1)
	tabsbgright:SetFrameStrata("LOW")
	--tabsbgright:Hide() --This will get shown if a chat exists in the bottomright corner
	tabsbgright:CreateShadow("")
	tabsbgright:SetBorder()
  
  -- hide chat bg on combat
  if C["chat"].hidebgoncombat then
    local function ToggleChatFrame(show)
      if not C["chat"].crazywxxsome then return end
      for i = 1, 4 do
        local frame = _G[format("ChatFrame%s", i)]
        local tab = _G[format("ChatFrame%sTab", i)]
        if show then
          frame:SetAlpha(1)
          tab:Show()
        else
          frame:SetAlpha(0)
          tab:Hide()
        end
      end
    end
    
    local function HideChatBackground(self, event)
      if event == "PLAYER_REGEN_ENABLED" then
        UIFrameFadeIn(self, 0.15)
        ToggleChatFrame(true)
      elseif event == "PLAYER_REGEN_DISABLED" then
        UIFrameFadeOut(self, 0.15)
        ToggleChatFrame(false)
      elseif event == "PLAYER_ENTERING_WORLD" then
        if InCombatLockdown() then
          UIFrameFadeOut(self, 0.15)
          ToggleChatFrame(false)
        else
          UIFrameFadeIn(self, 0.15)
          ToggleChatFrame(true)
        end
      end
    end
    
    chatleftbg:RegisterEvent("PLAYER_ENTERING_WORLD")
    chatleftbg:RegisterEvent("PLAYER_REGEN_ENABLED")
    chatleftbg:RegisterEvent("PLAYER_REGEN_DISABLED")    
    chatrightbg:RegisterEvent("PLAYER_ENTERING_WORLD")
    chatrightbg:RegisterEvent("PLAYER_REGEN_ENABLED")
    chatrightbg:RegisterEvent("PLAYER_REGEN_DISABLED")
    tabsbgleft:RegisterEvent("PLAYER_ENTERING_WORLD")
    tabsbgleft:RegisterEvent("PLAYER_REGEN_ENABLED")
    tabsbgleft:RegisterEvent("PLAYER_REGEN_DISABLED")
    tabsbgright:RegisterEvent("PLAYER_ENTERING_WORLD")
    tabsbgright:RegisterEvent("PLAYER_REGEN_ENABLED")
    tabsbgright:RegisterEvent("PLAYER_REGEN_DISABLED")
   
    chatleftbg:SetScript("OnEvent", HideChatBackground)
    chatrightbg:SetScript("OnEvent", HideChatBackground)
    tabsbgleft:SetScript("OnEvent", HideChatBackground)
    tabsbgright:SetScript("OnEvent", HideChatBackground)
  end
end

-- BOTTOM BAR
local tbottombar = CreateFrame("Frame", "ZuiBottomBar", UIParent)
tbottombar:CreatePanel("Transparent", 1, 22, "TOP", UIParent, "TOP", 0, 0)
tbottombar:ClearAllPoints()
tbottombar:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", Z.Scale(-6), Z.Scale(-6))
tbottombar:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", Z.Scale(6), Z.Scale(-6))
tbottombar:SetFrameStrata("BACKGROUND")
tbottombar:SetFrameLevel(0)
tbottombar:CreateShadow("Hydra")

--BATTLEGROUND STATS FRAME
if C["datatext"].battleground then
	local bgframe = CreateFrame("Frame", "ZuiInfoLeftBattleGround", UIParent)
	bgframe:CreatePanel("Hydra", 1, 1, "TOPLEFT", UIParent, "BOTTOMLEFT", 0, 0)
	bgframe:SetAllPoints(ileft)
	bgframe:SetFrameStrata("LOW")
	bgframe:SetFrameLevel(0)
	bgframe:EnableMouse(true)
end

--Pve/Pvp datatext yo
local pvedl = CreateFrame("Frame", "PveLeft", ZuiBar2)
pvedl:CreatePanel("Transparent", ZuiBar2:GetWidth(), 15, "BOTTOM", ZuiBar2, "TOP", Z.Scale(0), Z.Scale(2))
pvedl:SetFrameLevel(2)
pvedl:SetFrameStrata("BACKGROUND")
pvedl:SetBorder()

--Pve/Pvp datatext yo
local pvedr= CreateFrame("Frame", "PveRight", ZuiBar3)
pvedr:CreatePanel("Transparent", ZuiBar3:GetWidth(), 15, "BOTTOM", ZuiBar3, "TOP", Z.Scale(0), Z.Scale(2))
pvedr:SetFrameLevel(2)
pvedr:SetFrameStrata("BACKGROUND")
pvedr:SetBorder()

--show hide datatext 8 and 9 on entering instance/pvp -- thanks Hydra!
local function OnEvent(self, event)
	if event == "PLAYER_ENTERING_WORLD" then
		local inInstance, instanceType = IsInInstance()
		if (inInstance and instanceType == "party") or (inInstance and  instanceType == "raid") or (inInstance and  instanceType == "pvp")  then
			PveLeft:Show()
			PveRight:Show()
		else
			PveLeft:Hide()
			PveRight:Hide()
		end
	end
end
local dataFrame = CreateFrame("Frame")
dataFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
dataFrame:SetScript("OnEvent", OnEvent)
