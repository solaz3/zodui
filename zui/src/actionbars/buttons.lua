local Z, C, L = unpack(select(2, ...)) -- Import: Z - functions, constants, variables; C - config; L - locales
-- This is the file for our action bars settings in game via mouseover buttons around action bars.
-- I really hope you'll understand the code, because I was totally drunk when I wrote this file.
-- At least, it work fine. :P (lol)

local function ShowOrHideBar(bar, button)
	local db = zDataPerChar
	if bar == ZuiBar5 then
    if button == ZuiBar5ButtonTop and bar:IsShown() then
      if ZuiBar6:IsShown() then
        ZuiBar6:Hide()
        bar:SetWidth((Z.buttonsize * 1) + (Z.buttonspacing * 2))
        db.hidebar6 = true
      else
        bar:Hide()
        db.hidebar5 = true
      end
    elseif button == ZuiBar5ButtonBottom and not bar:IsShown() then
      bar:Show()
      bar:SetWidth((Z.buttonsize * 1) + (Z.buttonspacing * 2))
      db.hidebar5 = false
    elseif button == ZuiBar5ButtonBottom and bar:IsShown() then
      if not ZuiBar6:IsShown() then
        ZuiBar6:Show()
        bar:SetWidth((Z.buttonsize * 2) + (Z.buttonspacing * 3))
        db.hidebar6 = false
      end
    end
  elseif bar == ZuiBar2 then
    if button == ZuiBar234Button then
      if ZuiBar4:IsShown() then
        ZuiBar1:SetHeight((Z.buttonsize * 1) + (Z.buttonspacing * 2))
        ZuiBar2:SetHeight(ZuiBar1:GetHeight())
        ZuiBar3:SetHeight(ZuiBar1:GetHeight())
        ZuiBar4:Hide()
        for i = 7, 12 do
          local left = _G["MultiBarBottomLeftButton"..i]
          --local right = _G["MultiBarBottomRightButton"..i]
          left:SetAlpha(0)
          --right:SetAlpha(0)
        end
        db.hidebar234 = true
      else
        ZuiBar1:SetHeight((Z.buttonsize * 2) + (Z.buttonspacing * 3))
        ZuiBar2:SetHeight(ZuiBar1:GetHeight())
        ZuiBar3:SetHeight(ZuiBar1:GetHeight())
        ZuiBar4:Show()
        for i = 7, 12 do
          local left = _G["MultiBarBottomLeftButton"..i]
          --local right = _G["MultiBarBottomRightButton"..i]
          left:SetAlpha(1)
          --right:SetAlpha(1)
        end
        db.hidebar234 = false
      end
    end
  end
end   

local function MoveButtonBar(button, bar)
	local db = zDataPerChar
	if button == ZuiBar234Button then
		if ZuiBar4:IsShown() then
			db.hidebar234 = false
			button:ClearAllPoints()
			button:SetBorder()
			button:Point("BOTTOM", ZuiBar1, "TOP", 0, 2)
			button.text:SetText(hexa.."-"..hexb)
		else
			db.hidebar234 = true
			button:ClearAllPoints()
			button:SetBorder()
			button:Point("BOTTOM", ZuiBar1, "TOP", 0, 2)
			button.text:SetText(hexa.."+"..hexb)
		end
	end

	if button == ZuiBar5ButtonTop or button == ZuiBar5ButtonBottom then		
		local buttontop = ZuiBar5ButtonTop
		local buttonbot = ZuiBar5ButtonBottom
		if bar:IsShown() then
			db.hidebar5 = false
			buttontop:ClearAllPoints()
			buttontop:SetBorder()
			buttontop:Size(bar:GetWidth(), 17)
			buttontop:Point("BOTTOM", bar, "TOP", 0, 2)
      buttontop.text:SetText(hexa..">"..hexb)
      
			buttonbot:ClearAllPoints()
			buttontop:SetBorder()
			buttonbot:Size(bar:GetWidth(), 17)
			buttonbot:Point("TOP", bar, "BOTTOM", 0, -2)
			buttonbot.text:SetText(hexa.."<"..hexb)

			-- move the pet
			ZuiPetBar:ClearAllPoints()
			ZuiPetBar:Point("RIGHT", bar, "LEFT", -6, 0)		
      ZuiWatchFrameAnchor:Point("TOPRIGHT", bar, "TOPLEFT", -50, 20)
		else
			db.hidebar5 = true
			buttonbot:ClearAllPoints()
			buttonbot:SetBorder()
			buttonbot:SetSize(ZuiLineToPetActionBarBackground:GetWidth(), ZuiLineToPetActionBarBackground:GetHeight())
			buttonbot:Point("LEFT", ZuiPetBar, "RIGHT", 2, 0)
			buttonbot.text:SetText(hexa.."<"..hexb)
      
			buttontop:ClearAllPoints()
			buttontop:SetBorder()
			buttontop:SetSize(ZuiLineToPetActionBarBackground:GetWidth(), ZuiLineToPetActionBarBackground:GetHeight())
			buttontop:Point("LEFT", ZuiPetBar, "RIGHT", 2, 0)
			buttontop.text:SetText(hexa.."<"..hexb)

			-- move the pet
			ZuiPetBar:ClearAllPoints()
			ZuiPetBar:Point("RIGHT", UIParent, "RIGHT", -23, -14)
      ZuiWatchFrameAnchor:Point("TOPRIGHT", UIParent, -70, -220)
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

local ZuiBar234Button = CreateFrame("Button", "ZuiBar234Button", UIParent)
ZuiBar234Button:Width(20)
ZuiBar234Button:SetBorder()
ZuiBar234Button:SetHeight(20)
ZuiBar234Button:Point("BOTTOM", ZuiBar1, "TOP", 0, 2)

ZuiBar234Button:SetTemplate("Transparent")
ZuiBar234Button:RegisterForClicks("AnyUp")
ZuiBar234Button:SetAlpha(0)
ZuiBar234Button:SetScript("OnClick", function(self) DrPepper(self, ZuiBar2) end)
ZuiBar234Button:SetScript("OnEnter", function(self) self:SetAlpha(1) end)
ZuiBar234Button:SetScript("OnLeave", function(self) self:SetAlpha(0) end)
ZuiBar234Button.text = Z.SetFontString(ZuiBar234Button, C.media.pxfont, 12, "OUTLINEMONOCHROME")
ZuiBar234Button.text:Point("CENTER", 1, 1)
ZuiBar234Button.text:SetText(hexa.."-"..hexb)

local ZuiBar5ButtonTop = CreateFrame("Button", "ZuiBar5ButtonTop", UIParent)
ZuiBar5ButtonTop:SetWidth(ZuiBar5:GetWidth())
ZuiBar5ButtonTop:Height(17)
ZuiBar5ButtonTop:Point("BOTTOM", ZuiBar5, "TOP", 0, 2)
ZuiBar5ButtonTop:SetTemplate("Transparent")
ZuiBar5ButtonTop:SetBorder()
ZuiBar5ButtonTop:RegisterForClicks("AnyUp")
ZuiBar5ButtonTop:SetAlpha(0)
ZuiBar5ButtonTop:SetScript("OnClick", function(self) DrPepper(self, ZuiBar5) end)
ZuiBar5ButtonTop:SetScript("OnEnter", function(self) self:SetAlpha(1) end)
ZuiBar5ButtonTop:SetScript("OnLeave", function(self) self:SetAlpha(0) end)
ZuiBar5ButtonTop.text = Z.SetFontString(ZuiBar5ButtonTop, C.media.pxfont, 12, "OUTLINEMONOCHROME")
ZuiBar5ButtonTop.text:Point("CENTER", 1, 1)
ZuiBar5ButtonTop.text:SetText(hexa..">"..hexb)

local ZuiBar5ButtonBottom = CreateFrame("Button", "ZuiBar5ButtonBottom", UIParent)
ZuiBar5ButtonBottom:SetFrameLevel(ZuiBar5ButtonTop:GetFrameLevel() + 1)
ZuiBar5ButtonBottom:SetWidth(ZuiBar5:GetWidth())
ZuiBar5ButtonBottom:Height(17)
ZuiBar5ButtonBottom:Point("TOP", ZuiBar5, "BOTTOM", 0, -2)
ZuiBar5ButtonBottom:SetTemplate("Transparent")
ZuiBar5ButtonBottom:SetBorder()
ZuiBar5ButtonBottom:RegisterForClicks("AnyUp")
ZuiBar5ButtonBottom:SetAlpha(0)
ZuiBar5ButtonBottom:SetScript("OnClick", function(self) DrPepper(self, ZuiBar5) end)
ZuiBar5ButtonBottom:SetScript("OnEnter", function(self) self:SetAlpha(1) end)
ZuiBar5ButtonBottom:SetScript("OnLeave", function(self) self:SetAlpha(0) end)
ZuiBar5ButtonBottom.text = Z.SetFontString(ZuiBar5ButtonBottom, C.media.pxfont, 12, "OUTLINEMONOCHROME")
ZuiBar5ButtonBottom.text:Point("CENTER", 1, 1)
ZuiBar5ButtonBottom.text:SetText(hexa.."<"..hexb)

local color = RAID_CLASS_COLORS[Z.myclass]

-- exit vehicle button on left side of bottom action bar
local vehicle = CreateFrame("Button", "ZuiExitVehicleButton", UIParent, "SecureHandlerClickTemplate")
vehicle:SetAllPoints(ZuiBar234Button)
vehicle:SetFrameStrata(ZuiBar234Button:GetFrameStrata())
vehicle:SetFrameLevel(ZuiBar234Button:GetFrameLevel() + 1)
vehicle:SetTemplate("Transparent")
vehicle:SetBorder()
vehicle:SetBackdropBorderColor(color.r,color.g,color.b)
vehicle:RegisterForClicks("AnyUp")
vehicle:SetScript("OnClick", function() VehicleExit() end)
vehicle.text = Z.SetFontString(vehicle, C.media.pxfont, 12, "OUTLINEMONOCHROME")
vehicle.text:SetPoint("CENTER", Z.Scale(1), Z.Scale(1))
vehicle.text:SetText(hexa.."V"..hexb)
RegisterStateDriver(vehicle, "visibility", "[target=vehicle,exists] show;hide")

--------------------------------------------------------------
-- DrPepper taste is really good with Vodka. 
--------------------------------------------------------------

local init = CreateFrame("Frame")
init:RegisterEvent("VARIABLES_LOADED")
init:SetScript("OnEvent", function(self, event)
	if not zDataPerChar then zDataPerChar = {} end
	local db = zDataPerChar

	if db.hidebar234 then 
		DrPepper(ZuiBar234Button, ZuiBar2)
	end

	if db.hidebar6 then
		DrPepper(ZuiBar5ButtonTop, ZuiBar5)
  end
  
  if db.hidebar6 and db.hidebar5 then
    DrPepper(ZuiBar5ButtonTop, ZuiBar5)
	end
end)

ZuiExitVehicleButton:SetBackdropBorderColor(color.r,color.g,color.b) -- left exit button doesnt lite up properly that why we do it here