local Z, C, L = unpack(select(2, ...)) -- Import: Z - functions, constants, variables; C - config; L - locales
-- This is the file for our action bars settings in game via mouseover buttons around action bars.
-- I really hope you'll understand the code, because I was totally drunk when I wrote this file.
-- At least, it work fine. :P (lol)

local function ToggleButtons(button, show)
  for i = 1, 12 do
    local btn = _G[button..i]
		if show then
      btn:SetAlpha(1)
      btn:SetFrameLevel(3)
      TukuiLineToPetBar:SetFrameLevel(0)
    else
      btn:SetAlpha(0)
      btn:SetFrameLevel(2)
      TukuiLineToPetBar:SetFrameLevel(0)
    end
  end
end

local function ShowOrHideBar(bar, button)
	local db = ZuiDataPerChar
	local barwidth = bar:GetWidth()
	if bar == TukuiBar4 then
		if bar:IsShown() then
			if button == TukuiBar4ButtonTop then
				if barwidth == TukuiBar1:GetHeight() then
          bar:SetWidth(Z.buttonsize+Z.buttonspacing*2)
          ToggleButtons("MultiBarLeftButton", false)
          db.hidebar5 = true
        elseif barwidth < TukuiBar1:GetHeight() and barwidth > 0 then
          bar:Hide()
          db.hidebar4 = true
        end
      elseif button == TukuiBar4ButtonBottom then
        if barwidth < TukuiBar1:GetHeight() and barwidth > 0 then
          bar:SetWidth(TukuiBar1:GetHeight())
          ToggleButtons("MultiBarLeftButton", true)
          db.hidebar5 = false
          db.hidebar4 = false
        end
      end
    else
      if button == TukuiBar4ButtonBottom then
        bar:Show()
        db.hidebar4 = false
        db.hidebar5 = true
      end
    end
  elseif bar == TukuiBar2 then
    if bar:IsShown() then
      bar:Hide()
      TukuiBar3:Hide()
      db.hidebar3 = true
    else
      bar:Show()
      TukuiBar3:Show()
      db.hidebar3 = false
    end
  end
end

local function MoveButtonBar(button, bar)
	local db = ZuiDataPerChar
	
	if button == TukuiBar4ButtonTop or button == TukuiBar4ButtonBottom then		
		local buttontop = TukuiBar4ButtonTop
		local buttonbot = TukuiBar4ButtonBottom
		if bar:IsShown() then
			db.hidebar4 = false
			buttontop:ClearAllPoints()
			buttontop:Size(bar:GetWidth(), 17)
			buttontop:Point("BOTTOM", bar, "TOP", 0, 2)
			buttontop.text:SetText("|cff4BAF4C>|r") 
			buttonbot:ClearAllPoints()
			buttonbot:Size(bar:GetWidth(), 17)
			buttonbot:Point("TOP", bar, "BOTTOM", 0, -2)
			buttonbot.text:SetText("|cff4BAF4C<|r")
				
			-- move the pet
			TukuiPetBar:ClearAllPoints()
			TukuiPetBar:Point("RIGHT", bar, "LEFT", -6, 0)		
		else
			db.hidebar4 = true
      db.hidebar5 = true
			buttonbot:ClearAllPoints()
			buttonbot:SetSize(bar:GetWidth(), 17)
			buttonbot:Point("TOP", bar, "BOTTOM", 0, -2)
			buttonbot.text:SetText("|cff4BAF4C<|r")
			buttontop:ClearAllPoints()
			buttontop:SetSize(bar:GetWidth(), 17)
			buttontop:Point("BOTTOM", bar, "TOP", 0, 2)
			buttontop.text:SetText("|cff4BAF4C>|r")
			
			-- move the pet
			TukuiPetBar:ClearAllPoints()
			TukuiPetBar:Point("RIGHT", UIParent, "RIGHT", -23, -14)
		end	
	end
end

local function DrPepper(self, bar) -- guess what! :P
	-- yep, you cannot drink DrPepper while in combat. :(
	if InCombatLockdown() then print(ERR_NOT_IN_COMBAT) return end
	
	local button = self
	
	ShowOrHideBar(bar, button)
	MoveButtonBar(button, bar)
end
--[[
local TukuiBar2Button = CreateFrame("Button", "TukuiBar2Button", UIParent)
TukuiBar2Button:Width(17)
TukuiBar2Button:SetHeight(TukuiBar2:GetHeight())
if Z.lowversion then
	TukuiBar2Button:Point("BOTTOMRIGHT", TukuiBar1, "BOTTOMLEFT", 2, 0)
else
	TukuiBar2Button:Point("BOTTOMRIGHT", TukuiBar2, "BOTTOMLEFT", -2, 0)
end
TukuiBar2Button:SetTemplate("Default")
TukuiBar2Button:RegisterForClicks("AnyUp")
TukuiBar2Button:SetAlpha(0)
TukuiBar2Button:SetScript("OnClick", function(self) DrPepper(self, TukuiBar2) end)
TukuiBar2Button:SetScript("OnEnter", function(self) self:SetAlpha(1) end)
TukuiBar2Button:SetScript("OnLeave", function(self) self:SetAlpha(0) end)
TukuiBar2Button.text = Z.SetFontString(TukuiBar2Button, C.media.uffont, 20)
TukuiBar2Button.text:Point("CENTER", 1, 1)
TukuiBar2Button.text:SetText("|cff4BAF4C>|r")

local TukuiBar3Button = CreateFrame("Button", "TukuiBar3Button", UIParent)
TukuiBar3Button:Width(17)
TukuiBar3Button:SetHeight(TukuiBar3:GetHeight())
if Z.lowversion then
	TukuiBar3Button:Point("BOTTOMLEFT", TukuiBar1, "BOTTOMRIGHT", 2, 0)
else
	TukuiBar3Button:Point("BOTTOMLEFT", TukuiBar3, "BOTTOMRIGHT", 2, 0)
end
TukuiBar3Button:SetTemplate("Default")
TukuiBar3Button:RegisterForClicks("AnyUp")
TukuiBar3Button:SetAlpha(0)
TukuiBar3Button:SetScript("OnClick", function(self) DrPepper(self, TukuiBar3) end)
TukuiBar3Button:SetScript("OnEnter", function(self) self:SetAlpha(1) end)
TukuiBar3Button:SetScript("OnLeave", function(self) self:SetAlpha(0) end)
TukuiBar3Button.text = Z.SetFontString(TukuiBar3Button, C.media.uffont, 20)
TukuiBar3Button.text:Point("CENTER", 1, 1)
TukuiBar3Button.text:SetText("|cff4BAF4C<|r")

local TukuiBar4Button = CreateFrame("Button", "TukuiBar4Button", UIParent)
TukuiBar4Button:SetWidth(TukuiBar1:GetWidth())
TukuiBar4Button:Height(10)
TukuiBar4Button:Point("TOP", TukuiBar1, "BOTTOM", 0, -2)
TukuiBar4Button:SetTemplate("Default")
TukuiBar4Button:RegisterForClicks("AnyUp")
TukuiBar4Button:SetAlpha(0)
TukuiBar4Button:SetScript("OnClick", function(self) DrPepper(self, TukuiBar4) end)
TukuiBar4Button:SetScript("OnEnter", function(self) self:SetAlpha(1) end)
TukuiBar4Button:SetScript("OnLeave", function(self) self:SetAlpha(0) end)
TukuiBar4Button.text = Z.SetFontString(TukuiBar4Button, C.media.uffont, 30)
TukuiBar4Button.text:SetPoint("CENTER", 0, 0)
TukuiBar4Button.text:SetText("|cff4BAF4C- - - - - -|r")]]

local TukuiBar3Button = CreateFrame("Button", "TukuiBar3Button", ZuiCubeRight)
TukuiBar3Button:SetAllPoints(ZuiCubeRight)
TukuiBar3Button:RegisterForClicks("AnyUp")
TukuiBar3Button:SetScript("OnClick", function(self) DrPepper(self, TukuiBar2) end)

local TukuiBar4ButtonTop = CreateFrame("Button", "TukuiBar4ButtonTop", UIParent)
TukuiBar4ButtonTop:SetWidth(TukuiBar4:GetWidth())
TukuiBar4ButtonTop:Height(17)
TukuiBar4ButtonTop:Point("BOTTOM", TukuiBar4, "TOP", 0, 2)
TukuiBar4ButtonTop:SetTemplate("Default")
TukuiBar4ButtonTop:RegisterForClicks("AnyUp")
TukuiBar4ButtonTop:SetAlpha(0)
TukuiBar4ButtonTop:SetScript("OnClick", function(self) DrPepper(self, TukuiBar4) end)
TukuiBar4ButtonTop:SetScript("OnEnter", function(self) self:SetAlpha(1) end)
TukuiBar4ButtonTop:SetScript("OnLeave", function(self) self:SetAlpha(0) end)
TukuiBar4ButtonTop.text = Z.SetFontString(TukuiBar4ButtonTop, C.media.font, 20)
TukuiBar4ButtonTop.text:Point("CENTER", 1, 1)
TukuiBar4ButtonTop.text:SetText("|cff4BAF4C>|r")

local TukuiBar4ButtonBottom = CreateFrame("Button", "TukuiBar4ButtonBottom", UIParent)
TukuiBar4ButtonBottom:SetFrameLevel(TukuiBar4ButtonTop:GetFrameLevel() + 1)
TukuiBar4ButtonBottom:SetWidth(TukuiBar4:GetWidth())
TukuiBar4ButtonBottom:Height(17)
TukuiBar4ButtonBottom:Point("TOP", TukuiBar4, "BOTTOM", 0, -2)
TukuiBar4ButtonBottom:SetTemplate("Default")
TukuiBar4ButtonBottom:RegisterForClicks("AnyUp")
TukuiBar4ButtonBottom:SetAlpha(0)
TukuiBar4ButtonBottom:SetScript("OnClick", function(self) DrPepper(self, TukuiBar4) end)
TukuiBar4ButtonBottom:SetScript("OnEnter", function(self) self:SetAlpha(1) end)
TukuiBar4ButtonBottom:SetScript("OnLeave", function(self) self:SetAlpha(0) end)
TukuiBar4ButtonBottom.text = Z.SetFontString(TukuiBar4ButtonBottom, C.media.font, 20)
TukuiBar4ButtonBottom.text:Point("CENTER", 1, 1)
TukuiBar4ButtonBottom.text:SetText("|cff4BAF4C<|r")

-- vehicle button under minimap
local vehicle = CreateFrame("Button", nil, UIParent, "SecureHandlerClickTemplate")
vehicle:SetWidth(Z.Scale(26))
vehicle:SetHeight(Z.Scale(26))
vehicle:SetPoint("BOTTOM", TukuiBar1, "TOP", 0, Z.buttonspacing)
vehicle:SetNormalTexture("Interface\\AddOns\\zodui\\resource\\textures\\vehicleexit")
vehicle:SetPushedTexture("Interface\\AddOns\\zodui\\resource\\textures\\vehicleexit")
vehicle:SetHighlightTexture("Interface\\AddOns\\zodui\\resource\\textures\\vehicleexit")
vehicle:SetTemplate("Default")
vehicle:RegisterForClicks("AnyUp")
vehicle:SetScript("OnClick", function() VehicleExit() end)
RegisterStateDriver(vehicle, "visibility", "[target=vehicle,noexists] hide;show")

--[[exit vehicle button on left side of bottom action bar
local vehicleleft = CreateFrame("Button", "TukuiExitVehicleButtonLeft", UIParent, "SecureHandlerClickTemplate")
vehicleleft:SetAllPoints(TukuiVehicleBar)
vehicleleft:SetFrameStrata(TukuiVehicleBar:GetFrameStrata())
vehicleleft:SetFrameLevel(TukuiVehicleBar:GetFrameLevel() + 1)
vehicleleft:SetTemplate("Default")
vehicleleft:SetBackdropBorderColor(75/255,  175/255, 76/255)
vehicleleft:RegisterForClicks("AnyUp")
vehicleleft:SetScript("OnClick", function() VehicleExit() end)
vehicleleft.text = Z.SetFontString(vehicleleft, C.media.uffont, 20)
vehicleleft.text:SetPoint("CENTER", Z.Scale(1), Z.Scale(1))
vehicleleft.text:SetText("|cff4BAF4CV|r")
RegisterStateDriver(vehicleleft, "visibility", "[target=vehicle,exists] show;hide")

--exit vehicle button on right side of bottom action bar
local vehicleright = CreateFrame("Button", "TukuiExitVehicleButtonRight", UIParent, "SecureHandlerClickTemplate")
vehicleright:SetAllPoints(TukuiBar3Button)
vehicleright:SetTemplate("Default")
vehicleright:SetFrameStrata(TukuiBar3Button:GetFrameStrata())
vehicleright:SetFrameLevel(TukuiBar3Button:GetFrameLevel() + 1)
vehicleright:SetBackdropBorderColor(75/255,  175/255, 76/255)
vehicleright:RegisterForClicks("AnyUp")
vehicleright:SetScript("OnClick", function() VehicleExit() end)
vehicleright.text = Z.SetFontString(vehicleright, C.media.uffont, 20)
vehicleright.text:SetPoint("CENTER", Z.Scale(1), Z.Scale(1))
vehicleright.text:SetText("|cff4BAF4CV|r")
RegisterStateDriver(vehicleright, "visibility", "[target=vehicle,exists] show;hide")]]

--------------------------------------------------------------
-- DrPepper taste is really good with Vodka. 
--------------------------------------------------------------

local init = CreateFrame("Frame")
init:RegisterEvent("VARIABLES_LOADED")
init:SetScript("OnEvent", function(self, event)
	if not ZuiDataPerChar then ZuiDataPerChar = {} end
	local db = ZuiDataPerChar
	
	if db.hidebar3 then 
		DrPepper(TukuiBar2Button, TukuiBar2)
	end
  
  if db.hidebar5 then
		DrPepper(TukuiBar4ButtonTop, TukuiBar4)
    if db.hidebar4 then
      DrPepper(TukuiBar4ButtonTop, TukuiBar4)
    end
	end
  
  TukuiBar4ButtonTop:SetWidth(TukuiBar4:GetWidth())
  TukuiBar4ButtonBottom:SetWidth(TukuiBar4:GetWidth())
  
  --[[
	if db.hidebar3 then
		DrPepper(TukuiBar3Button, TukuiBar3)
	end
	
	if db.hidebar4 then
		DrPepper(TukuiBar4Button, TukuiBar4)
	end
		
	if Z.lowversion then
		-- because we use bar6.lua and bar7.lua with TukuiBar5Button for lower reso.
		--TukuiBar2Button:Hide()
		--TukuiBar3Button:Hide()
		if db.hidebar7 then
			--TukuiBar7:Hide()
			--TukuiBar5:SetWidth((Z.buttonsize * 2) + (Z.buttonspacing * 3))
		end
		
		if db.hidebar6 then
			--TukuiBar6:Hide()
			--TukuiBar5:SetWidth((Z.buttonsize * 1) + (Z.buttonspacing * 2))
		end
		
		--TukuiBar5ButtonTop:SetWidth(TukuiBar5:GetWidth())
		--TukuiBar5ButtonBottom:SetWidth(TukuiBar5:GetWidth())
	end
	
	if db.hidebar5 then
		--DrPepper(TukuiBar5ButtonTop, TukuiBar5)
	end]]
end)