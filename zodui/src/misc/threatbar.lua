local Z, C, L = unpack(select(2, ...)) -- Import: Z - functions, constants, variables; C - config; L - locales
-- Very simple threat bar for T.

-- cannot work without Info Right DataText Panel.
if not ZuiInfoRight then return end

local aggroColors = {
	[1] = {12/255, 151/255,  15/255},
	[2] = {166/255, 171/255,  26/255},
	[3] = {163/255,  24/255,  24/255},
}

-- create the bar
local ZuiThreatBar = CreateFrame("StatusBar", "ZuiThreatBar", ZuiInfoRight)
ZuiThreatBar:Point("TOPLEFT", 2, -2)
ZuiThreatBar:Point("BOTTOMRIGHT", -2, 2)

ZuiThreatBar:SetStatusBarTexture(C.media.normTex)
ZuiThreatBar:GetStatusBarTexture():SetHorizTile(false)
ZuiThreatBar:SetTemplate("Default", true)
ZuiThreatBar:SetBackdropColor(0, 0, 0, 0)
ZuiThreatBar:SetMinMaxValues(0, 100)

ZuiThreatBar.text = Z.SetFontString(ZuiThreatBar, C.media.font, 12, "THINOUTLINE")
ZuiThreatBar.text:Point("CENTER", ZuiThreatBar)
ZuiThreatBar.text:SetShadowOffset(Z.mult, -Z.mult)
ZuiThreatBar.text:SetShadowColor(0, 0, 0, 0.4)

--ZuiThreatBar.Title = Z.SetFontString(ZuiThreatBar, C.media.font, 12)
--ZuiThreatBar.Title:SetText(L.unitframes_ouf_threattext)
--ZuiThreatBar.Title:SetPoint("LEFT", ZuiThreatBar, "LEFT", Z.Scale(30), 0)
	  
ZuiThreatBar.bg = ZuiThreatBar:CreateTexture(nil, 'BORDER')
ZuiThreatBar.bg:SetAllPoints(ZuiThreatBar)
--ZuiThreatBar.bg:SetTexture(0.1,0.1,0.1)

-- event func
local function OnEvent(self, event, ...)
	local party = GetNumPartyMembers()
	local raid = GetNumRaidMembers()
	local pet = select(1, HasPetUI())
	
	if event == "PLAYER_ENTERING_WORLD" then
		self:Hide()
		self:UnregisterEvent("PLAYER_ENTERING_WORLD")
	elseif event == "PLAYER_REGEN_ENABLED" then
		self:Hide()
	elseif event == "PLAYER_REGEN_DISABLED" then
		-- look if we have a pet, party or raid active
		-- having threat bar solo is totally useless
		if party > 0 or raid > 0 or pet == 1 then
			self:Show()
		else
			self:Hide()
		end
	else
		-- update when pet, party or raid change.
		if (InCombatLockdown()) and (party > 0 or raid > 0 or pet == 1) then
			self:Show()
		else
			self:Hide()
		end
	end
end

-- update status bar func
local function OnUpdate(self, event, unit)
	if UnitAffectingCombat(self.unit) then
		local _, _, threatpct, rawthreatpct, _ = UnitDetailedThreatSituation(self.unit, self.tar)
		local threatval = threatpct or 0
		
		self:SetValue(threatval)
		self.text:SetFormattedText("%s "..Z.ValColor.."%3.1f%%|r", L.unitframes_ouf_threattext, threatval)
		
		if( threatval < 30 ) then
			self:SetStatusBarColor(unpack(self.Colors[1]))
		elseif( threatval >= 30 and threatval < 70 ) then
			self:SetStatusBarColor(unpack(self.Colors[2]))
		else
			self:SetStatusBarColor(unpack(self.Colors[3]))
		end
				
		if threatval > 0 then
			self:SetAlpha(1)
		else
			self:SetAlpha(0)
		end		
	end
end

-- event handling
ZuiThreatBar:RegisterEvent("PLAYER_ENTERING_WORLD")
ZuiThreatBar:RegisterEvent("PLAYER_REGEN_ENABLED")
ZuiThreatBar:RegisterEvent("PLAYER_REGEN_DISABLED")
ZuiThreatBar:SetScript("OnEvent", OnEvent)
ZuiThreatBar:SetScript("OnUpdate", OnUpdate)
ZuiThreatBar.unit = "player"
ZuiThreatBar.tar = ZuiThreatBar.unit.."target"
ZuiThreatBar.Colors = aggroColors
ZuiThreatBar:SetAlpha(0)

-- THAT'S IT!