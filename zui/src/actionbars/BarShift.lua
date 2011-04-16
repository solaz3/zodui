local Z, C, L = unpack(select(2, ...)) -- Import: Z - functions, constants, variables; C - config; L - locales
if not C["actionbar"].enable then return end

---------------------------------------------------------------------------
-- Setup Shapeshift Bar
---------------------------------------------------------------------------
-- used for anchor totembar or shapeshiftbar
local ZuiShiftBar = CreateFrame("Frame","ZuiShiftBar",UIParent)
ZuiShiftBar:SetPoint("TOPLEFT", 4, -46)
ZuiShiftBar:SetWidth((Z.petbuttonsize * 5) + (Z.petbuttonsize * 4))
ZuiShiftBar:SetHeight(10)
ZuiShiftBar:SetFrameStrata("MEDIUM")
ZuiShiftBar:SetMovable(true)
ZuiShiftBar:SetClampedToScreen(true)

-- shapeshift command to move totem or shapeshift in-game
local ssmover = CreateFrame("Frame", "ZuiShapeShiftHolder", UIParent)
ssmover:SetAllPoints(ZuiShiftBar)
ssmover:SetTemplate("Default")
ssmover:SetFrameStrata("HIGH")
ssmover:SetBackdropBorderColor(1,0,0)
ssmover:SetAlpha(0)
ssmover.text = Z.SetFontString(ssmover, C.media.font, 12, "OUTLINE")
ssmover.text:SetPoint("CENTER")
ssmover.text:SetText(L.move_shapeshift)

-- hide it if not needed and stop executing code
if C.actionbar.hideshapeshift then ZuiShiftBar:Hide() return end

-- create the shapeshift bar if we enabled it
local bar = CreateFrame("Frame", "ZuiShapeShift", ZuiShiftBar, "SecureHandlerStateTemplate")
bar:ClearAllPoints()
bar:SetAllPoints(ZuiShiftBar)

local States = {
	["DRUID"] = "show",
	["WARRIOR"] = "show",
	["PALADIN"] = "show",
	["DEATHKNIGHT"] = "show",
	["ROGUE"] = "show,",
	["PRIEST"] = "show,",
	["HUNTER"] = "show,",
	["WARLOCK"] = "show,",
}

bar:RegisterEvent("PLAYER_LOGIN")
bar:RegisterEvent("PLAYER_ENTERING_WORLD")
bar:RegisterEvent("UPDATE_SHAPESHIFT_FORMS")
bar:RegisterEvent("UPDATE_SHAPESHIFT_USABLE")
bar:RegisterEvent("UPDATE_SHAPESHIFT_COOLDOWN")
bar:RegisterEvent("UPDATE_SHAPESHIFT_FORM")
bar:RegisterEvent("ACTIONBAR_PAGE_CHANGED")
bar:SetScript("OnEvent", function(self, event, ...)
	if event == "PLAYER_LOGIN" then
		local button
		for i = 1, NUM_SHAPESHIFT_SLOTS do
			button = _G["ShapeshiftButton"..i]
			button:ClearAllPoints()
			button:SetParent(self)
			if i == 1 then
				button:Point("BOTTOMLEFT", ZuiShiftBar, 0, 24)
			else
				local previous = _G["ShapeshiftButton"..i-1]
				button:Point("LEFT", previous, "RIGHT", Z.buttonspacing, 0)
			end
			local _, name = GetShapeshiftFormInfo(i)
			if name then
				button:Show()
			end
		end
		RegisterStateDriver(self, "visibility", States[Z.myclass] or "hide")
	elseif event == "UPDATE_SHAPESHIFT_FORMS" then
		-- Update Shapeshift Bar Button Visibility
		-- I seriously don't know if it's the best way to do it on spec changes or when we learn a new stance.
		if InCombatLockdown() then return end -- > just to be safe ;p
		local button
		for i = 1, NUM_SHAPESHIFT_SLOTS do
			button = _G["ShapeshiftButton"..i]
			local _, name = GetShapeshiftFormInfo(i)
			if name then
				button:Show()
			else
				button:Hide()
			end
		end
		Z.ShiftBarUpdate()
	elseif event == "PLAYER_ENTERING_WORLD" then
		Z.StyleShift()
	else
		Z.ShiftBarUpdate()
	end
end)