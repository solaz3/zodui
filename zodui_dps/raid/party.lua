local Z, C, L = unpack(Zui) -- Import Functions/Constants, Config, Locales
local oUF = zUF or oUF
assert(oUF, "zUI was unable to locate oUF.")

if not C["raidframes"].enable then return end

local font2 = C["media"].numfont
local font1 = C["media"].uffont
local normTex = C["media"].normTex

--Frame Size
local PARTY_HEIGHT = Z.Scale(35)*C["raidframes"].scale
local PARTY_WIDTH = Z.Scale(140)*C["raidframes"].scale
local PTARGET_HEIGHT = Z.Scale(17)*C["raidframes"].scale
local PTARGET_WIDTH = (PARTY_WIDTH/2)*C["raidframes"].scale
local BORDER = 2

if Z.LoadUFFunctions then Z.LoadUFFunctions("DPS") end

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
  
  self:SetAttribute('initial-height', PARTY_HEIGHT)
	self:SetAttribute('initial-width', PARTY_WIDTH)
	
	if unit == "raidtarget" then
		--Health Bar
		local health = Z.ContructHealthBar(self, true, nil)
		health:Point("TOPRIGHT", self, "TOPRIGHT", -BORDER, -BORDER)
		health:Point("BOTTOMLEFT", self, "BOTTOMLEFT", BORDER, BORDER)
		self.Health = health
		
		--Name
		self:FontString("Name", font1, C["unitframes"].fontsize, "THINOUTLINE")
		self.Name:Point("CENTER", health, "CENTER", 0, 2)
		self.Name.frequentUpdates = 0.5
		self:Tag(self.Name, '[Zui:getnamecolor][Zui:namemedium]')

		-- Debuff Highlight
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
	else
		local POWERBAR_WIDTH = PARTY_WIDTH - (BORDER*2)
		local POWERBAR_HEIGHT = 8
		
		--Health Bar
		local health = Z.ContructHealthBar(self, true, true)
		health:Point("TOPRIGHT", self, "TOPRIGHT", -BORDER, -BORDER)
		health:Point("BOTTOMLEFT", self, "BOTTOMLEFT", BORDER, BORDER + POWERBAR_HEIGHT)
		health.value:Point("RIGHT", health, "RIGHT", -4, 0)
		
		self.Health = health

		--Power Bar
		local power = Z.ConstructPowerBar(self, true, nil)
		power:Point("TOPLEFT", health.backdrop, "BOTTOMLEFT", BORDER, -(BORDER + 1))
		power:Point("BOTTOMRIGHT", self, "BOTTOMRIGHT", -BORDER, BORDER)
		self.Power = power
		
		--Name
		self:FontString("Name", font1, C["unitframes"].fontsize, "THINOUTLINE")
		self.Name:SetJustifyH("LEFT")
		self.Name:Point("LEFT", health, "LEFT", 2, 0)
		self.Name.frequentUpdates = 0.2
		self:Tag(self.Name, '[Zui:getnamecolor][Zui:namelong]')
		
		--Leader Icon
		local leader = self:CreateTexture(nil, "OVERLAY")
		leader:Size(14)
		leader:Point("TOPRIGHT", -4, 8)
		self.Leader = leader
		
		--Master Looter Icon
		local ml = self:CreateTexture(nil, "OVERLAY")
		ml:Size(14)
		self.MasterLooter = ml
		self:RegisterEvent("PARTY_LEADER_CHANGED", Z.MLAnchorUpdate)
		self:RegisterEvent("PARTY_MEMBERS_CHANGED", Z.MLAnchorUpdate)	
			
		--Aggro Glow
		if C["raidframes"].displayaggro == true then
			table.insert(self.__elements, Z.UpdateThreat)
			self:RegisterEvent('PLAYER_TARGET_CHANGED', Z.UpdateThreat)
			self:RegisterEvent('UNIT_THREAT_LIST_UPDATE', Z.UpdateThreat)
			self:RegisterEvent('UNIT_THREAT_SITUATION_UPDATE', Z.UpdateThreat)
		end
		
		local LFDRole = self:CreateTexture(nil, "OVERLAY")
		LFDRole:Size(6, 6)
		LFDRole:Point("TOPRIGHT", health, "TOPRIGHT", -2, -2)
		LFDRole:SetTexture("Interface\\AddOns\\zodui\\res\\textures\\lfdicons.blp")
		self.LFDRole = LFDRole		
		
		--Raid Icon
		local RaidIcon = self:CreateTexture(nil, "OVERLAY")
		RaidIcon:SetTexture("Interface\\AddOns\\zodui\\res\\textures\\raidicons.blp") 
		RaidIcon:Size(18, 18)
		RaidIcon:Point("CENTER", health, "TOP", 0, BORDER)
		self.RaidIcon = RaidIcon

		local ReadyCheck = self:CreateTexture(nil, "OVERLAY")
		ReadyCheck:Size(C["raidframes"].fontsize, C["raidframes"].fontsize)
		ReadyCheck:Point('LEFT', self.Name, 'RIGHT', 4, 0)
		self.ReadyCheck = ReadyCheck

		local debuffs = CreateFrame('Frame', nil, self)
		debuffs:SetPoint('LEFT', self, 'RIGHT', 5, 0)
		debuffs:SetHeight(PARTY_HEIGHT*.9)
		debuffs:SetWidth(200)
		debuffs.size = PARTY_HEIGHT*.9
		debuffs.spacing = 2
		debuffs.initialAnchor = 'LEFT'
		debuffs.num = 5
		debuffs.PostCreateIcon = Z.PostCreateAura
		debuffs.PostUpdateIcon = Z.PostUpdateAura
		debuffs.CustomFilter = Z.AuraFilter
		self.Debuffs = debuffs
		
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

oUF:RegisterStyle('ZuiDPSParty', Shared)
oUF:Factory(function(self)
	oUF:SetActiveStyle("ZuiDPSParty")
	local party
	if C["raidframes"].partytarget ~= true then
		party = self:SpawnHeader("ZuiDPSParty", nil, "custom [@raid6,exists] hide;show",      'oUF-initialConfigFunction', [[
				local header = self:GetParent()
				self:SetWidth(header:GetAttribute('initial-width'))
				self:SetHeight(header:GetAttribute('initial-height'))
			]],
      'initial-width', PARTY_WIDTH,
			'initial-height', PARTY_HEIGHT,		
			"showParty", true, 
			"showPlayer", C["raidframes"].showplayerinparty, 
			"showRaid", true, 
      "showSolo", false,
			"yOffset", Z.Scale(-8)
		)
	else
		party = self:SpawnHeader("ZuiDPSParty", nil, "custom [@raid6,exists] hide;show", 
			'oUF-initialConfigFunction', ([[
				local header = self:GetParent()
				local ptarget = header:GetChildren():GetName()
				self:SetWidth(%d)
				self:SetHeight(%d)
				for i = 1, 5 do
					if ptarget == "ZuiDPSPartyUnitButton"..i.."Target" then
						header:GetChildren():SetWidth(%d)
						header:GetChildren():SetHeight(%d)		
					end
				end
			]]):format(PARTY_WIDTH, PARTY_HEIGHT, PTARGET_WIDTH, PTARGET_HEIGHT),			
      "showParty", true, 
			"showPlayer", C["raidframes"].showplayerinparty, 
			"showRaid", true, 
      "showSolo", false,
			"yOffset", Z.Scale(-27),
			'template', 'DPSPartyTarget'
		)
	end
	party:SetPoint("BOTTOMLEFT", ZuiChatBackgroundLeft, "TOPLEFT", Z.Scale(2), Z.Scale(40))
	
	local partyToggle = CreateFrame("Frame")
	partyToggle:RegisterEvent("PLAYER_LOGIN")
	partyToggle:RegisterEvent("RAID_ROSTER_UPDATE")
	partyToggle:RegisterEvent("PARTY_LEADER_CHANGED")
	partyToggle:RegisterEvent("PARTY_MEMBERS_CHANGED")
	partyToggle:SetScript("OnEvent", function(self, event)
		if InCombatLockdown() then
			self:RegisterEvent("PLAYER_REGEN_ENABLED")
		else
			self:UnregisterEvent("PLAYER_REGEN_ENABLED")
			local numraid = GetNumRaidMembers()
      if numraid <= 5 then
        party:Show() 
      elseif numraid <=5 and GetNumPartyMembers() ~= 0 then
        party:Show() 
      else
        party:Hide() 				
      end
		end
    
    --[[local inInstance, instanceType = IsInInstance()
		local _, _, _, _, maxPlayers, _, _ = GetInstanceInfo()
		if event == "PLAYER_REGEN_ENABLED" then self:UnregisterEvent("PLAYER_REGEN_ENABLED") end
		if not InCombatLockdown() then
			if inInstance and instanceType == "raid" and maxPlayers ~= 40 then
				ZuiDPSParty:SetAttribute("showRaid", false)
				ZuiDPSParty:SetAttribute("showParty", false)			
			else
				ZuiDPSParty:SetAttribute("showParty", true)
				ZuiDPSParty:SetAttribute("showRaid", true)
			end
		else
			self:RegisterEvent("PLAYER_REGEN_ENABLED")
		end]]
	end)
end)