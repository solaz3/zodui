local Z, C, L = unpack(select(2, ...))
if not ZuiInfoRight then return end

--[[local aggroColors = {
	[1] = {12/255, 151/255,  15/255},
	[2] = {166/255, 171/255,  26/255},
	[3] = {163/255,  24/255,  24/255},
}]]

local ZuiThreatBar = CreateFrame("StatusBar", "ZuiThreatBar", ZuiInfoRight)
ZuiThreatBar:Point("TOPLEFT", 2, -2)
ZuiThreatBar:Point("BOTTOMRIGHT", -2, 2)

ZuiThreatBar:SetStatusBarTexture(C.media.norm)
ZuiThreatBar:GetStatusBarTexture():SetHorizTile(false)
ZuiThreatBar:SetBackdrop({bgFile = C.media.blank})
ZuiThreatBar:SetBackdropColor(0, 0, 0, 0)
ZuiThreatBar:SetMinMaxValues(0, 100)

ZuiThreatBar.text = Z.SetFontString(ZuiThreatBar, C.media.pxfont, 12, "OUTLINEMONOCHROME")
ZuiThreatBar.text:Point("RIGHT", ZuiThreatBar, "RIGHT", -30, 0)

ZuiThreatBar.Title = Z.SetFontString(ZuiThreatBar, C.media.pxfont, 12, "OUTLINEMONOCHROME")
ZuiThreatBar.Title:SetText("Threat of current target: ")
ZuiThreatBar.Title:SetPoint("LEFT", ZuiThreatBar, "LEFT", Z.Scale(30), 0)
	  
ZuiThreatBar.bg = ZuiThreatBar:CreateTexture(nil, 'BORDER')
ZuiThreatBar.bg:SetAllPoints(ZuiThreatBar)
ZuiThreatBar.bg:SetTexture(0.1,0.1,0.1)

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
		if party > 0 or raid > 0 or pet == 1 then
			self:Show()
		else
			self:Hide()
		end
	else
		if (InCombatLockdown()) and (party > 0 or raid > 0 or pet == 1) then
			self:Show()
		else
			self:Hide()
		end
	end
end

local function OnUpdate(self, event, unit)
	if UnitAffectingCombat(self.unit) then
		local _, _, threatpct, rawthreatpct, _ = UnitDetailedThreatSituation(self.unit, self.tar)
		local threatval = threatpct or 0
		
		self:SetValue(threatval)
		self.text:SetFormattedText("%3.1f", threatval)
		
		local r, g, b = zUF.ColorGradient(threatval/100, 0,.8,0,.8,.8,0,.8,0,0) 
		self:SetStatusBarColor(r, g, b)

		if threatval > 0 then
			self:SetAlpha(1)
		else
			self:SetAlpha(0)
		end		
	end
end

ZuiThreatBar:RegisterEvent("PLAYER_ENTERING_WORLD")
ZuiThreatBar:RegisterEvent("PLAYER_REGEN_ENABLED")
ZuiThreatBar:RegisterEvent("PLAYER_REGEN_DISABLED")
ZuiThreatBar:SetScript("OnEvent", OnEvent)
ZuiThreatBar:SetScript("OnUpdate", OnUpdate)
ZuiThreatBar.unit = "player"
ZuiThreatBar.tar = ZuiThreatBar.unit.."target"
ZuiThreatBar.Colors = aggroColors
ZuiThreatBar:SetAlpha(0)