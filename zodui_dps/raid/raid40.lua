local Z, C, L = unpack(Zui) -- Import Functions/Constants, Config, Locales
local oUF = zUF or oUF
assert(oUF, "ZUI was unable to locate oUF.")

if not C["raidframes"].enable then return end

local RAID_WIDTH = ((ZuiChatBackgroundLeft:GetWidth() / 5) - 2.5)*C["raidframes"].scale
local RAID_HEIGHT = Z.Scale(32)*C["raidframes"].scale

local BORDER = 2

local function Shared(self, unit)
	-- Set Colors
	self.colors = Z.oUF_colors
	
	-- Register Frames for Click
	self:RegisterForClicks("AnyUp")
	self:SetScript('OnEnter', UnitFrame_OnEnter)
	self:SetScript('OnLeave', UnitFrame_OnLeave)
	
	-- Setup Menu
	self.menu = Z.SpawnMenu
	self:SetAttribute('type2', 'menu')
  
	-- Frame Level
	self:SetFrameLevel(5)
	
  self:SetAttribute('initial-height', RAID_HEIGHT)
	self:SetAttribute('initial-width', RAID_WIDTH)
  
	--Health Bar
	local health = Z.ContructHealthBar(self, true, true)
	health:Point("TOPRIGHT", self, "TOPRIGHT", -BORDER, -BORDER)
	health:Point("BOTTOMLEFT", self, "BOTTOMLEFT", BORDER, BORDER)
	health.value:Point("BOTTOM", health, "BOTTOM", 0, 1)
	health.value:SetFont(C["media"].numfont, (C["raidframes"].fontsize-1)*C["raidframes"].scale, "THINOUTLINE")
	
	self.Health = health
				
	--Name
	self:FontString("Name", C["media"].uffont, (C["unitframes"].fontsize-1)*C["raidframes"].scale, "THINOUTLINE")
	self.Name:Point("TOP", health, "TOP", 0, -3)
	self.Name.frequentUpdates = 0.3
	self:Tag(self.Name, "[Zui:getnamecolor][Zui:nameshort]")

	if C["raidframes"].role == true then
		local LFDRole = self:CreateTexture(nil, "OVERLAY")
		LFDRole:Size(6, 6)
		LFDRole:Point("TOP", self.Name, "BOTTOM", 0, -1)
		LFDRole:SetTexture("Interface\\AddOns\\zodui\\resource\\textures\\lfdicons.blp")
		self.LFDRole = LFDRole
	end
	
	--Aggro Glow
	if C["raidframes"].displayaggro == true then
		table.insert(self.__elements, Z.UpdateThreat)
		self:RegisterEvent('PLAYER_TARGET_CHANGED', Z.UpdateThreat)
		self:RegisterEvent('UNIT_THREAT_LIST_UPDATE', Z.UpdateThreat)
		self:RegisterEvent('UNIT_THREAT_SITUATION_UPDATE', Z.UpdateThreat)
	end


	local RaidIcon = self:CreateTexture(nil, 'OVERLAY')
	RaidIcon:Size(15*C["raidframes"].scale, 15*C["raidframes"].scale)
	RaidIcon:SetPoint('CENTER', self, 'TOP')
	RaidIcon:SetTexture('Interface\\AddOns\\zodui\\resource\\textures\\raidicons.blp')
	self.RaidIcon = RaidIcon
	
	local ReadyCheck = self.Health:CreateTexture(nil, "OVERLAY")
	ReadyCheck:SetHeight(C["raidframes"].fontsize)
	ReadyCheck:SetWidth(C["raidframes"].fontsize)
	ReadyCheck:Point('TOP', self.Name, 'BOTTOM', 0, -2)
	self.ReadyCheck = ReadyCheck
	
	--if C["unitframes"].debuffhighlight == true then
		local dbh = self:CreateTexture(nil, "OVERLAY")
		dbh:SetAllPoints()
		dbh:SetTexture(C["media"].blank)
		dbh:SetBlendMode("ADD")
		dbh:SetVertexColor(0,0,0,0)
		self.DebuffHighlight = dbh
		self.DebuffHighlightFilter = true
		self.DebuffHighlightAlpha = 0.35	
	--end
		
	if C["raidframes"].showrange == true then
		local range = {insideAlpha = 1, outsideAlpha = C["raidframes"].raidalphaoor}
		self.Range = range
	end
	
	if C["raidframes"].raidunitbuffwatch == true then
		Z.createAuraWatch(self,unit)
    end
	
	if C["raidframes"].mouseglow == true then
		self:CreateShadow("Default")
		
		--self.shadow is used for threat, if we leave it like this, it may cause complications
		self.mouseglow = self.shadow
		self.shadow = nil
		
		self.mouseglow:SetFrameStrata("BACKGROUND")
		self.mouseglow:Point("TOPLEFT", -4, 4)
		self.mouseglow:Point("TOPRIGHT", 4, 4)
		self.mouseglow:Point("BOTTOMLEFT", -4, -4)
		self.mouseglow:Point("BOTTOMRIGHT", 4, -4)
		self.mouseglow:Hide()
		
		self:HookScript("OnEnter", function(self)
			local unit = self.unit
			if not unit then return end
			self.mouseglow:Show()
			
			local reaction = UnitReaction(unit, 'player')
			local _, class = UnitClass(unit)
			
			if UnitIsPlayer(unit) then
				local c = Z.colors.class[class]
				self.mouseglow:SetBackdropBorderColor(c[1], c[2], c[3], 1)
			elseif reaction then
				local c = Z.oUF_colors.reaction[reaction]
				self.mouseglow:SetBackdropBorderColor(c[1], c[2], c[3], 1)
			else
				self.mouseglow:SetBackdropBorderColor(.84, .75, .65, 1)
			end			
		end)
		
		self:HookScript("OnLeave", function(self)
			self.mouseglow:Hide()		
		end)	
	end	
	
	return self
end

oUF:RegisterStyle('ZuiDPSR26R40', Shared)
oUF:Factory(function(self)
	oUF:SetActiveStyle("ZuiDPSR26R40")	
	local raid = self:SpawnHeader("ZuiDPSR26R40", nil, nil,	
		"showRaid", true, 
		"showParty", true,
		"showPlayer", C["raidframes"].showplayerinparty,
		"xoffset", 3,
		"yOffset", -3,
		"point", "LEFT",
		"groupFilter", "1,2,3,4,5,6,7,8",
		"groupingOrder", "1,2,3,4,5,6,7,8",
		"groupBy", "GROUP",
		"maxColumns", 8,
		"unitsPerColumn", 5,
		"columnSpacing", 3,
		"columnAnchorPoint", "TOP"		
	)		
	raid:Point("BOTTOMLEFT", ZuiChatBackgroundLeft, "TOPLEFT", 1, 35)

	local raidToggle = CreateFrame("Frame")
	raidToggle:RegisterEvent("PLAYER_LOGIN")
	raidToggle:RegisterEvent("RAID_ROSTER_UPDATE")
	raidToggle:RegisterEvent("PARTY_LEADER_CHANGED")
	raidToggle:RegisterEvent("PARTY_MEMBERS_CHANGED")
	raidToggle:SetScript("OnEvent", function(self, event)
		if InCombatLockdown() then
			self:RegisterEvent("PLAYER_REGEN_ENABLED")
		else
			self:UnregisterEvent("PLAYER_REGEN_ENABLED")
			local numraid = GetNumRaidMembers()
      if numraid >= 26 and numraid <= 40 then -- between 6 and 25, reminder for when i'm editing
        raid:Show()
      else
        raid:Hide()	
      end
		end
	end)
end)