local Z, C, L = unpack(Zui) -- Import Functions/Constants, Config, Locales
local oUF = zUF or oUF
assert(oUF, "zUI was unable to locate oUF.")

if not C["raidframes"].enable then return end

local RAID_WIDTH
local RAID_HEIGHT
if C["raidframes"].griddps ~= true then
	RAID_WIDTH = Z.Scale(110)*C["raidframes"].scale
	RAID_HEIGHT = Z.Scale(25)*C["raidframes"].scale
else
	RAID_WIDTH = ((ZuiChatBackgroundLeft:GetWidth() / 5) - 2.5)*C["raidframes"].scale
	RAID_HEIGHT = Z.Scale(40)*C["raidframes"].scale
end

local BORDER = 2

local function Shared(self, unit)
	local POWERBAR_WIDTH = RAID_WIDTH - (BORDER*2)
	local POWERBAR_HEIGHT = 8
	
	if C["raidframes"].griddps ~= true then
		POWERBAR_HEIGHT = 7
	end
	
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
	health:Point("BOTTOMLEFT", self, "BOTTOMLEFT", BORDER, BORDER + POWERBAR_HEIGHT)
	if C["raidframes"].griddps ~= true then
		health.value:Point("RIGHT", health, "RIGHT", -2, 0)
	else
		health.value:Point("BOTTOM", health, "BOTTOM", 0, 1)
	end
	health.value:SetFont(C["media"].numfont, (C["raidframes"].fontsize-1)*C["raidframes"].scale, "THINOUTLINE")
	
	self.Health = health
			
	--Power Bar
	local power = Z.ConstructPowerBar(self, true, nil)
	power:Point("TOPLEFT", health.backdrop, "BOTTOMLEFT", BORDER, -(BORDER + 1))
	power:Point("BOTTOMRIGHT", self, "BOTTOMRIGHT", -BORDER, BORDER)

	self.Power = power

	--Name
	self:FontString("Name", C["media"].uffont, (C["unitframes"].fontsize-1)*C["raidframes"].scale, "THINOUTLINE")
	if C["raidframes"].griddps ~= true then
		self.Name:Point("LEFT", health, "LEFT", 2, 0)
	else
		self.Name:Point("TOP", health, "TOP", 0, -3)
	end
	self.Name.frequentUpdates = 0.3
	self:Tag(self.Name, "[Zui:getnamecolor][Zui:nameshort]")

	if C["raidframes"].role == true then
		local LFDRole = self:CreateTexture(nil, "OVERLAY")
		LFDRole:Size(6, 6)
		if C["raidframes"].griddps ~= true then
			LFDRole:Point("BOTTOMRIGHT", health, "BOTTOMRIGHT", -2, -2)
		else
			LFDRole:Point("TOP", self.Name, "BOTTOM", 0, -1)
		end
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
	if C["raidframes"].griddps ~= true then
		RaidIcon:SetPoint('LEFT', self.Name, 'RIGHT')
	else
		RaidIcon:SetPoint('CENTER', self, 'TOP')
	end
	RaidIcon:SetTexture('Interface\\AddOns\\zodui\\resource\\textures\\raidicons.blp')
	self.RaidIcon = RaidIcon
	
	local ReadyCheck = self.Health:CreateTexture(nil, "OVERLAY")
	ReadyCheck:SetHeight(C["raidframes"].fontsize)
	ReadyCheck:SetWidth(C["raidframes"].fontsize)
	if C["raidframes"].griddps ~= true then
		ReadyCheck:Point('LEFT', self.Name, 'RIGHT', 4, 0)
	else	
		ReadyCheck:Point('TOP', self.Name, 'BOTTOM', 0, -2)
	end
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
	
	if C["raidframes"].griddps ~= true then
		local debuffs = CreateFrame('Frame', nil, self)
		debuffs:SetPoint('LEFT', self, 'RIGHT', Z.Scale(6), 0)
		debuffs:SetHeight(RAID_HEIGHT)
		debuffs:SetWidth(RAID_HEIGHT*5)
		debuffs.size = (RAID_HEIGHT)
		debuffs.num = 5
		debuffs.spacing = 2
		
		debuffs.initialAnchor = 'LEFT'
		debuffs.PostCreateIcon = Z.PostCreateAura
		debuffs.PostUpdateIcon = Z.PostUpdateAura
		self.Debuffs = debuffs
		
		-- Debuff Aura Filter
		self.Debuffs.CustomFilter = Z.AuraFilter		
	else
		-- Raid Debuffs (big middle icon)
		local RaidDebuffs = CreateFrame('Frame', nil, self)
		RaidDebuffs:Height(RAID_HEIGHT*0.6)
		RaidDebuffs:Width(RAID_HEIGHT*0.6)
		RaidDebuffs:Point('BOTTOM', self, 'BOTTOM', 0, 1)
		RaidDebuffs:SetFrameLevel(self:GetFrameLevel() + 2)
		
		RaidDebuffs:SetTemplate("Default")
		
		RaidDebuffs.icon = RaidDebuffs:CreateTexture(nil, 'OVERLAY')
		RaidDebuffs.icon:SetTexCoord(.1,.9,.1,.9)
		RaidDebuffs.icon:Point("TOPLEFT", 2, -2)
		RaidDebuffs.icon:Point("BOTTOMRIGHT", -2, 2)
		
		RaidDebuffs.count = RaidDebuffs:CreateFontString(nil, 'OVERLAY')
		RaidDebuffs.count:SetFont(C["media"].numfont, 12*0.75, "THINOUTLINE")
		RaidDebuffs.count:SetPoint('BOTTOMRIGHT', RaidDebuffs, 'BOTTOMRIGHT', 0, 2)
		RaidDebuffs.count:SetTextColor(1, .9, 0)
		
		RaidDebuffs:FontString('time', C["media"].numfont, 12*0.75, "THINOUTLINE")
		RaidDebuffs.time:SetPoint('CENTER')
		RaidDebuffs.time:SetTextColor(1, .9, 0)
		
		self.RaidDebuffs = RaidDebuffs
	end
				
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

oUF:RegisterStyle('ZuiDPSR6R25', Shared)
oUF:Factory(function(self)
	oUF:SetActiveStyle("ZuiDPSR6R25")	
	local raid
	if C["raidframes"].griddps ~= true then
		raid = self:SpawnHeader("ZuiDPSR6R25", nil, nil,	
			"showRaid", true, 
			"showParty", true,
			--"showSolo", false,
			"point", "BOTTOM",
			"showPlayer", C["raidframes"].showplayerinparty,
			"groupFilter", "1,2,3,4,5",
			"groupingOrder", "1,2,3,4,5",
			"groupBy", "GROUP",	
			"yOffset", Z.Scale(6)
		)	
		raid:Point("BOTTOMLEFT", ZuiChatBackgroundLeft, "TOPLEFT", 1, 40)
	else
		raid = self:SpawnHeader("ZuiDPSR6R25", nil,nil,	
			"showRaid", true, 
			"showParty", true,
			"showPlayer", C["raidframes"].showplayerinparty,
			"xoffset", 3,
			"yOffset", -3,
			"point", "LEFT",
			"groupFilter", "1,2,3,4,5",
			"groupingOrder", "1,2,3,4,5",
			"groupBy", "GROUP",
			"maxColumns", 5,
			"unitsPerColumn", 5,
			"columnSpacing", 3,
			"columnAnchorPoint", "TOP"		
		)	
		raid:Point("BOTTOMLEFT", ZuiChatBackgroundLeft, "TOPLEFT", 1, 35)	
	end
	
	local function ChangeVisibility(visibility)
		if(visibility) then
			local type, list = string.split(' ', visibility, 2)
			if(list and type == 'custom') then
				RegisterAttributeDriver(ZuiDPSR6R25, 'state-visibility', list)
			end
		end	
	end
	
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
      if numraid >= 6 and numraid <= 25 then -- between 6 and 25, reminder for when i'm editing
        raid:Show()
      else
        raid:Hide()	
			end
		end
	end)
end)