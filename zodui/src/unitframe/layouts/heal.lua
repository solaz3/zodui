local E, C, L, DB = unpack(select(2, ...)) -- Import Functions/Constants, Config, Locales

if not C["unitframes"].enable == true then return end

------------------------------------------------------------------------
--	Constants
------------------------------------------------------------------------

local PLAYER_WIDTH = C["unitframes"].playtarwidth*E.ResScale
local PLAYER_HEIGHT = C["unitframes"].playtarheight*E.ResScale
local TARGET_WIDTH = C["unitframes"].playtarwidth*E.ResScale
local TARGET_HEIGHT = C["unitframes"].playtarheight*E.ResScale
local SMALL_WIDTH = C["unitframes"].smallwidth*E.ResScale
local SMALL_HEIGHT = C["unitframes"].smallheight*E.ResScale
local TANK_WIDTH = C["unitframes"].assisttankwidth*E.ResScale
local TANK_HEIGHT = C["unitframes"].assisttankheight*E.ResScale
local BOSS_WIDTH = C["unitframes"].arenabosswidth*E.ResScale
local BOSS_HEIGHT = C["unitframes"].arenabossheight*E.ResScale
local BORDER = 2*E.ResScale
local SPACING = 1*E.ResScale
local FONTSIZE = C["unitframes"].fontsize*E.ResScale
local FONT = C["media"].uffont
local NORMTEX = C["media"].normTex
local POWERTHEME = C["unitframes"].mini_powerbar

--[[
	Constuctor Functions (inside uf_functions.lua)
	
	E.ContructHealthBar(arg1, arg2, arg3):
		arg1 - first argument should always be self
		arg2 - [true/false] OPTIONAL create a backdrop
		arg3 - [true/false] OPTIONAL create health value text
		
	E.ContructPowerBar(arg1, arg2, arg3):
		arg1 - first argument should always be self
		arg2 - [true/false] OPTIONAL create a backdrop 
		arg3 - [true/false] OPTIONAL create power value text

	E.ConstructCastBar(arg1, arg2, arg3, arg4):
		arg1 - first argument should always be self
		arg2 - width of entire bar, cast icon is calculated in already
		arg3 - height of entire bar
		arg4 - ["Left", "Right"] side that you want the cast icon to go on, if cast icons are enabled.
		
	
	Note: These functions do not make the element active, you have to do that manually.
	
	Example:
		local health = E.ContructHealthBar(self, true, true)
		health:Point("TOPRIGHT", self, "TOPRIGHT", -BORDER, -BORDER)
		
		self.Health = health
]]

------------------------------------------------------------------------
--	Layout
------------------------------------------------------------------------
local function Shared(self, unit)
	-- Set Colors
	self.colors = E.oUF_colors
	
	-- Register Frames for Click
	self:RegisterForClicks("AnyUp")
	self:SetScript('OnEnter', UnitFrame_OnEnter)
	self:SetScript('OnLeave', UnitFrame_OnLeave)
	
	-- Setup Menu
	self.menu = E.SpawnMenu
	
	-- Frame Level
	self:SetFrameLevel(5)
	
	------------------------------------------------------------------------
	--	Player
	------------------------------------------------------------------------
	if unit == "player" then
		local POWERBAR_WIDTH = C["unitframes"].playtarwidth/2*E.ResScale
		local CLASSBAR_WIDTH = (C["unitframes"].playtarwidth - (2*2))*E.ResScale
		local CLASSBAR2_WIDTH = (C["unitframes"].playtarwidth/1.7)*E.ResScale
		local POWERBAR_HEIGHT = 10*E.ResScale
		local CLASSBAR_HEIGHT = 11*E.ResScale
		local CASTBAR_HEIGHT = 20*E.ResScale
		local CASTBAR_WIDTH = C["unitframes"].castplayerwidth*E.ResScale
		local PORTRAIT_WIDTH = 45*E.ResScale
		
		--Threat Glow
		self:CreateShadow("Default")
		self.shadow:SetFrameStrata("BACKGROUND")
		self.shadow:SetBackdropBorderColor(0, 0, 0, 0)
		self.shadow:Point("TOPLEFT", -4, 4)
		self.shadow:Point("TOPRIGHT", 4, 4)
		self.shadow:Point("BOTTOMLEFT", -4, -4)
		self.shadow:Point("BOTTOMRIGHT", 4, -4)		

		if C["unitframes"].charportrait == true then
			PORTRAIT_WIDTH = 0
		else
			PORTRAIT_WIDTH = 0
		end
	
		--Health Bar
		local health = E.ContructHealthBar(self, true, true)
		health:Point("TOPRIGHT", self, "TOPRIGHT", -BORDER, -BORDER)
		if POWERTHEME == true then
			health:Point("BOTTOMLEFT", self, "BOTTOMLEFT", BORDER, BORDER + (POWERBAR_HEIGHT/2))
		else
			health:Point("BOTTOMLEFT", self, "BOTTOMLEFT", BORDER, BORDER + POWERBAR_HEIGHT)
		end

		health.value:Point("RIGHT", health, "RIGHT", -4, 0)
		self.Health = health
		
		--Power Bar
		local power = E.ConstructPowerBar(self, true, true)
		if POWERTHEME == true then
			power:Width(POWERBAR_WIDTH - BORDER*2)
			power:Height(POWERBAR_HEIGHT - BORDER*2)
			power:Point("RIGHT", self, "BOTTOMRIGHT", -(BORDER*2 + 4), BORDER + (POWERBAR_HEIGHT/2))
			power:SetFrameStrata("MEDIUM")
			power:SetFrameLevel(self:GetFrameLevel() + 3)
		else
			power:Point("TOPLEFT", health.backdrop, "BOTTOMLEFT", BORDER, -(BORDER + SPACING))
			power:Point("BOTTOMRIGHT", self, "BOTTOMRIGHT", -BORDER, BORDER)
		end
		power.value:Point("LEFT", health, "LEFT", 4, 0)

		self.Power = power
		
		--Portrait
		if C["unitframes"].charportrait == true then
			local portrait = CreateFrame("PlayerModel", nil, health)
			portrait:SetFrameLevel(health:GetFrameLevel() + 1)
			portrait:SetAllPoints(health)
			portrait.PostUpdate = function(self) self:SetAlpha(0) self:SetAlpha(0.35) end		
			self.Portrait = portrait
				
			local overlay = CreateFrame("Frame", nil, self)
			overlay:SetFrameLevel(self:GetFrameLevel() - 2)
				
			health.bg:ClearAllPoints()
			health.bg:Point('BOTTOMLEFT', health:GetStatusBarTexture(), 'BOTTOMRIGHT')
			health.bg:Point('TOPRIGHT', health)
			health.bg:SetDrawLayer("OVERLAY", 7)
			health.bg:SetParent(overlay)
		end
		
		--Anchor aggro glow to the healthbar if powertheme is on
		if POWERTHEME == true then
			self.shadow:Point("BOTTOMLEFT", health, "BOTTOMLEFT", -4, -6)
			self.shadow:Point("BOTTOMRIGHT", health, "BOTTOMRIGHT", 4, -6)
		end				
				
		--Auras
		if C["unitframes"].playerauras then
			local debuffs = CreateFrame("Frame", nil, self)
			debuffs.num = C["unitframes"].playtarbuffperrow
			debuffs:SetWidth(PLAYER_WIDTH)
			debuffs.spacing = E.Scale(SPACING)
			debuffs.size = ((C["unitframes"].playtarwidth - (debuffs.spacing*(debuffs.num - 1))) / debuffs.num)*E.ResScale
			debuffs:SetHeight(debuffs.size)
			debuffs:Point("BOTTOMLEFT", self, "TOPLEFT", 0, SPACING)	
			debuffs.initialAnchor = 'BOTTOMRIGHT'
			debuffs["growth-y"] = "UP"
			debuffs["growth-x"] = "LEFT"
			debuffs.PostCreateIcon = E.PostCreateAura
			debuffs.PostUpdateIcon = E.PostUpdateAura
			debuffs.CustomFilter = E.AuraFilter
			self.Debuffs = debuffs
			
			if C["unitframes"].playershowonlydebuffs == false then
				local buffs = CreateFrame("Frame", nil, self)
				buffs.num = C["unitframes"].playtarbuffperrow
				buffs:SetWidth(debuffs:GetWidth())
				buffs.spacing = E.Scale(SPACING)
				buffs.size = (((C["unitframes"].playtarwidth - (buffs.spacing*(buffs.num - 1))) / buffs.num))*E.ResScale
				buffs:Point("BOTTOM", debuffs, "TOP", 0, SPACING)
				buffs:SetHeight(debuffs:GetHeight())
				buffs.initialAnchor = 'BOTTOMLEFT'
				buffs["growth-y"] = "UP"	
				buffs["growth-x"] = "RIGHT"
				buffs.PostCreateIcon = E.PostCreateAura
				buffs.PostUpdateIcon = E.PostUpdateAura
				self.Buffs = buffs	
			end
		end

		--Cast Bar
		if C["unitframes"].unitcastbar == true then
			local castbar = E.ConstructCastBar(self, CASTBAR_WIDTH, CASTBAR_HEIGHT, "LEFT")
			castbar:Point("TOPRIGHT", self, "BOTTOMRIGHT", -BORDER, -(BORDER*2+BORDER))
			
			self.Castbar = castbar
		end
		
		-- Debuff Highlight
		if C["unitframes"].debuffhighlight == true then
			local dbh = self:CreateTexture(nil, "OVERLAY")
			if POWERTHEME == true then
				dbh:SetPoint("TOPLEFT")
				dbh:SetPoint("BOTTOMRIGHT", health.backdrop, "BOTTOMRIGHT")
			else
				dbh:SetAllPoints()
			end
			dbh:SetTexture(C["media"].blank)
			dbh:SetBlendMode("ADD")
			dbh:SetVertexColor(0,0,0,0)
			self.DebuffHighlight = dbh
			self.DebuffHighlightFilter = true
			self.DebuffHighlightAlpha = 0.35
		end

		--Combat Feedback
		if C["unitframes"].combatfeedback == true then
			self:FontString("CombatFeedbackText", FONT, FONTSIZE, "OUTLINE")
			self.CombatFeedbackText:SetPoint("CENTER", health, "CENTER", 0, -5)
			
			self.CombatFeedbackText.colors = {
				DAMAGE = {0.69, 0.31, 0.31},
				CRUSHING = {0.69, 0.31, 0.31},
				CRITICAL = {0.69, 0.31, 0.31},
				GLANCING = {0.69, 0.31, 0.31},
				STANDARD = {0.84, 0.75, 0.65},
				IMMUNE = {0.84, 0.75, 0.65},
				ABSORB = {0.84, 0.75, 0.65},
				BLOCK = {0.84, 0.75, 0.65},
				RESIST = {0.84, 0.75, 0.65},
				MISS = {0.84, 0.75, 0.65},
				HEAL = {0.33, 0.59, 0.33},
				CRITHEAL = {0.33, 0.59, 0.33},
				ENERGIZE = {0.31, 0.45, 0.63},
				CRITENERGIZE = {0.31, 0.45, 0.63},
			}
		end
		
		--Low Mana
		self:FontString("ManaLevel", FONT, FONTSIZE, "THINOUTLINE")
		self.ManaLevel:Point("CENTER", health, "CENTER", 0, -5)
		self:HookScript("OnUpdate", E.UpdateManaLevel)
		
		--PvP Text
		self:FontString("PvP", FONT, FONTSIZE, "THINOUTLINE")
		self.PvP:Point("CENTER", health, "CENTER", 0, -5)
		self.PvP:SetTextColor(0.69, 0.31, 0.31)
		self.PvP:Hide()
		self.PvP.Override = E.dummy		
		
		self:HookScript("OnUpdate", E.PvPUpdate)
		self:HookScript("OnEnter", function(self) self.ManaLevel:Hide() self.PvP:Show() end)
		self:HookScript("OnLeave", function(self) self.ManaLevel:Show() self.PvP:Hide() end)
		
		--Combat Icon
		local combat = self:CreateTexture(nil, "OVERLAY")
		combat:Size(19, 19)
		combat:Point("CENTER", health, "CENTER", 0,7)
		combat:SetVertexColor(0.69, 0.31, 0.31)
		self.Combat = combat		
		
		--Leader Icon
		local leader = self:CreateTexture(nil, "OVERLAY")
		leader:Size(14)
		leader:Point("TOPRIGHT", -4, 8)
		self.Leader = leader
		
		--Master Looter Icon
		local ml = self:CreateTexture(nil, "OVERLAY")
		ml:Size(14)
		self.MasterLooter = ml
		self:RegisterEvent("PARTY_LEADER_CHANGED", E.MLAnchorUpdate)
		self:RegisterEvent("PARTY_MEMBERS_CHANGED", E.MLAnchorUpdate)	
			
		--Aggro Glow
		if C["unitframes"].displayaggro == true then
			table.insert(self.__elements, E.UpdateThreat)
			self:RegisterEvent('PLAYER_TARGET_CHANGED', E.UpdateThreat)
			self:RegisterEvent('UNIT_THREAT_LIST_UPDATE', E.UpdateThreat)
			self:RegisterEvent('UNIT_THREAT_SITUATION_UPDATE', E.UpdateThreat)
		end
		
		--Auto Hide
		if C["unitframes"].combat == true then
			self:RegisterEvent("PLAYER_ENTERING_WORLD", E.Fader)
			self:RegisterEvent("PLAYER_REGEN_ENABLED", E.Fader)
			self:RegisterEvent("PLAYER_REGEN_DISABLED", E.Fader)
			self:RegisterEvent("PLAYER_TARGET_CHANGED", E.Fader)
			self:RegisterEvent("PLAYER_FOCUS_CHANGED", E.Fader)
			self:RegisterEvent("UNIT_HEALTH", E.Fader)
			self:RegisterEvent("UNIT_SPELLCAST_START", E.Fader)
			self:RegisterEvent("UNIT_SPELLCAST_STOP", E.Fader)
			self:RegisterEvent("UNIT_SPELLCAST_CHANNEL_START", E.Fader)
			self:RegisterEvent("UNIT_SPELLCAST_CHANNEL_STOP", E.Fader)
			self:RegisterEvent("UNIT_PORTRAIT_UPDATE", E.Fader)
			self:RegisterEvent("UNIT_MODEL_CHANGED", E.Fader)			
			self:HookScript("OnEnter", function(self) E.Fader(self, true) end)
			self:HookScript("OnLeave", function(self) E.Fader(self, false) end)
		end		
		
		--Experience Bar
		if E.level ~= MAX_PLAYER_LEVEL then
			local experience = CreateFrame("StatusBar", nil, self)
			experience:SetStatusBarTexture(NORMTEX)
			experience:SetStatusBarColor(0, 0.4, 1, .8)
			experience:Size(PLAYER_WIDTH -(BORDER*2), POWERBAR_HEIGHT -(BORDER*2))
			experience:Point("TOPRIGHT", self, "BOTTOMRIGHT", -BORDER, -(BORDER*2+BORDER))
			experience:SetFrameStrata("LOW")
			
			experience.Rested = CreateFrame('StatusBar', nil, experience)
			experience.Rested:SetStatusBarTexture(NORMTEX)
			experience.Rested:SetStatusBarColor(1, 0, 1, 0.2)
			experience.Rested:SetFrameLevel(experience:GetFrameLevel() - 1)
			experience.Rested.SetFrameLevel = E.dummy --oUF_Experience thinks its a good idea to set frame level to 1
			experience.Rested:SetAllPoints(experience)
			
			local resting = self:CreateTexture(nil, "OVERLAY")
			resting:Size(22)
			resting:Point("CENTER", health, "TOPLEFT", -5, 6)
			resting:SetTexture([=[Interface\CharacterFrame\UI-StateIcon]=])
			resting:SetTexCoord(0, 0.5, 0, 0.421875)
			resting:Hide()
			self:RegisterEvent("PLAYER_UPDATE_RESTING", E.RestingIconUpdate)
			self.Resting = resting
			
			experience.backdrop = CreateFrame("Frame", nil, experience)
			experience.backdrop:SetTemplate("Default")
			experience.backdrop:Point("TOPLEFT", experience, "TOPLEFT", -2, 2)
			experience.backdrop:Point("BOTTOMRIGHT", experience, "BOTTOMRIGHT", 2, -2)
			experience.backdrop:SetFrameLevel(experience:GetFrameLevel() - 1)
			self.Experience = experience
		end
		
		if E.level == MAX_PLAYER_LEVEL then
			local reputation = CreateFrame("StatusBar", nil, self)
			reputation:SetStatusBarTexture(NORMTEX)
			reputation:SetStatusBarColor(0, 0.4, 1, .8)
			reputation:Size(PLAYER_WIDTH -(BORDER*2), POWERBAR_HEIGHT -(BORDER*2))
			reputation:Point("TOPRIGHT", self, "BOTTOMRIGHT", -BORDER, -(BORDER*2+BORDER))
			reputation:SetFrameStrata("LOW")

			reputation.Tooltip = true


			reputation.backdrop = CreateFrame("Frame", nil, reputation)
			reputation.backdrop:SetTemplate("Default")
			reputation.backdrop:Point("TOPLEFT", reputation, "TOPLEFT", -2, 2)
			reputation.backdrop:Point("BOTTOMRIGHT", reputation, "BOTTOMRIGHT", 2, -2)
			reputation.backdrop:SetFrameLevel(reputation:GetFrameLevel() - 1)
			self.Reputation = reputation
		end

		--Class Resource Bars
		if C["unitframes"].classbar == true and (E.myclass == "PALADIN" or E.myclass == "SHAMAN" or E.myclass == "DRUID" or E.myclass == "DEATHKNIGHT" or E.myclass == "WARLOCK") then
			--Reposition Health Bar for ClassBars
			if POWERTHEME == true then
				health:Point("TOPRIGHT", self, "TOPRIGHT", -BORDER, -BORDER)
				health:Point("TOPLEFT", self, "TOPLEFT", PORTRAIT_WIDTH+BORDER, -BORDER)
			else
				health:Point("TOPRIGHT", self, "TOPRIGHT", -BORDER, -(BORDER+POWERBAR_HEIGHT+SPACING))
				health:Point("TOPLEFT", self, "TOPLEFT", PORTRAIT_WIDTH+BORDER, -(BORDER+POWERBAR_HEIGHT+SPACING))
			end
			
			--Soul Shard / Holy Power Bar
			if E.myclass == "PALADIN" or E.myclass == "WARLOCK" then
				local bars = CreateFrame("Frame", nil, self)
				if POWERTHEME == true then
					bars:Width(CLASSBAR2_WIDTH - BORDER*2)
					bars:Height(CLASSBAR_HEIGHT - BORDER*2)
					bars:Point("LEFT", self, "TOPLEFT", (BORDER*2 + 4), BORDER - (CLASSBAR_HEIGHT/2))
					bars:SetFrameStrata("MEDIUM")
					bars:SetFrameLevel(self:GetFrameLevel() + 3)
				else
					bars:SetFrameStrata("LOW")
					bars:Point("BOTTOMLEFT", health.backdrop, "TOPLEFT", BORDER, BORDER+SPACING)
					bars:Width(CLASSBAR_WIDTH)
					bars:Height(POWERBAR_HEIGHT - (BORDER*2))
				end

				
				for i = 1, 3 do					
					bars[i]=CreateFrame("StatusBar", nil, bars)
					bars[i]:SetHeight(bars:GetHeight())					
					bars[i]:SetStatusBarTexture(NORMTEX)
					bars[i]:GetStatusBarTexture():SetHorizTile(false)

					bars[i].bg = bars[i]:CreateTexture(nil, 'BORDER')
					
					if E.myclass == "WARLOCK" then
						bars[i]:SetStatusBarColor(148/255, 130/255, 201/255)
						bars[i].bg:SetTexture(148/255, 130/255, 201/255)
					elseif E.myclass == "PALADIN" then
						bars[i]:SetStatusBarColor(228/255,225/255,16/255)
						bars[i].bg:SetTexture(228/255,225/255,16/255)
					end
					
					if i == 1 then
						bars[i]:SetPoint("LEFT", bars)
					else
						bars[i]:Point("LEFT", bars[i-1], "RIGHT", SPACING, 0)
					end
					
					bars[i].bg:SetAllPoints(bars[i])
					bars[i]:SetWidth(E.Scale(bars:GetWidth() - 2)/3)
					
					bars[i].bg:SetTexture(NORMTEX)					
					bars[i].bg:SetAlpha(.15)
				end
				
				bars.backdrop = CreateFrame("Frame", nil, bars)
				bars.backdrop:SetTemplate("Default")
				bars.backdrop:Point("TOPLEFT", -BORDER, BORDER)
				bars.backdrop:Point("BOTTOMRIGHT", BORDER, -BORDER)
				bars.backdrop:SetFrameLevel(bars:GetFrameLevel() - 1)
				
				if POWERTHEME == true then
					bars:HookScript("OnShow", function()
						health:Point("TOPRIGHT", self, "TOPRIGHT", -BORDER, -BORDER)
						health:Point("TOPLEFT", self, "TOPLEFT", PORTRAIT_WIDTH+BORDER, -BORDER)
					end)
					bars:HookScript("OnHide", function()
						health:Point("TOPRIGHT", self, "TOPRIGHT", -BORDER, -BORDER)
						health:Point("TOPLEFT", self, "TOPLEFT", PORTRAIT_WIDTH+BORDER, -BORDER)		
					end)
				else
					bars:HookScript("OnShow", function()
						health:Point("TOPRIGHT", self, "TOPRIGHT", -BORDER, -(BORDER+POWERBAR_HEIGHT+SPACING))
						health:Point("TOPLEFT", self, "TOPLEFT", PORTRAIT_WIDTH+BORDER, -(BORDER+POWERBAR_HEIGHT+SPACING))
					end)
					bars:HookScript("OnHide", function()
						health:Point("TOPRIGHT", self, "TOPRIGHT", -BORDER, -BORDER)
						health:Point("TOPLEFT", self, "TOPLEFT", PORTRAIT_WIDTH+BORDER, -BORDER)
					end)
				end			
				
				if E.myclass == "PALADIN" then
					bars.Override = E.UpdateHoly
					self.HolyPower = bars
				else
					bars.Override = E.UpdateShards
					self.SoulShards = bars
				end	
			end
			
			--Rune Bar
			if E.myclass == "DEATHKNIGHT" then
				local runes = CreateFrame("Frame", nil, self)
				if POWERTHEME == true then
					runes:Width(CLASSBAR2_WIDTH - BORDER*2)
					runes:Height(CLASSBAR_HEIGHT - BORDER*2)
					runes:Point("LEFT", self, "TOPLEFT", (BORDER*2 + 4), BORDER - (CLASSBAR_HEIGHT/2))
					runes:SetFrameStrata("MEDIUM")
					runes:SetFrameLevel(self:GetFrameLevel() + 3)
				else
					runes:SetFrameStrata("LOW")
					runes:Point("BOTTOMLEFT", health.backdrop, "TOPLEFT", BORDER, BORDER+SPACING)
					runes:Width(CLASSBAR_WIDTH)
					runes:Height(POWERBAR_HEIGHT - (BORDER*2))
				end

				for i = 1, 6 do
					runes[i] = CreateFrame("StatusBar", nil, runes)
					runes[i]:Height(runes:GetHeight())
					runes[i]:SetWidth(E.Scale(runes:GetWidth() - 5) / 6)

					if (i == 1) then
						runes[i]:SetPoint("LEFT", runes)
					else
						runes[i]:Point("LEFT", runes[i-1], "RIGHT", SPACING, 0)
					end
					runes[i]:SetStatusBarTexture(NORMTEX)
					runes[i]:GetStatusBarTexture():SetHorizTile(false)
				end
				
				runes.backdrop = CreateFrame("Frame", nil, runes)
				runes.backdrop:SetTemplate("Default")
				runes.backdrop:Point("TOPLEFT", -BORDER, BORDER)
				runes.backdrop:Point("BOTTOMRIGHT", BORDER, -BORDER)
				runes.backdrop:SetFrameLevel(runes:GetFrameLevel() - 1)

				if POWERTHEME == true then
					runes:HookScript("OnShow", function()
						health:Point("TOPRIGHT", self, "TOPRIGHT", -BORDER, -BORDER)
						health:Point("TOPLEFT", self, "TOPLEFT", PORTRAIT_WIDTH+BORDER, -BORDER)
					end)
					runes:HookScript("OnHide", function()
						health:Point("TOPRIGHT", self, "TOPRIGHT", -BORDER, -BORDER)
						health:Point("TOPLEFT", self, "TOPLEFT", PORTRAIT_WIDTH+BORDER, -BORDER)		
					end)
				else
					runes:HookScript("OnShow", function()
						health:Point("TOPRIGHT", self, "TOPRIGHT", -BORDER, -(BORDER+POWERBAR_HEIGHT+SPACING))
						health:Point("TOPLEFT", self, "TOPLEFT", PORTRAIT_WIDTH+BORDER, -(BORDER+POWERBAR_HEIGHT+SPACING))
					end)
					runes:HookScript("OnHide", function()
						health:Point("TOPRIGHT", self, "TOPRIGHT", -BORDER, -BORDER)
						health:Point("TOPLEFT", self, "TOPLEFT", PORTRAIT_WIDTH+BORDER, -BORDER)
					end)
				end	
				
				self.Runes = runes
			end
			
			--Totem Bar
			if E.myclass == "SHAMAN" then
				local totems = CreateFrame("Frame", nil, self)
				if POWERTHEME == true then
					totems:Width(CLASSBAR2_WIDTH - BORDER*2)
					totems:Height(CLASSBAR_HEIGHT - BORDER*2)
					totems:Point("LEFT", self, "TOPLEFT", (BORDER*2 + 4), BORDER - (CLASSBAR_HEIGHT/2))
					totems:SetFrameStrata("MEDIUM")
					totems:SetFrameLevel(self:GetFrameLevel() + 3)
				else
					totems:Point("BOTTOMLEFT", health.backdrop, "TOPLEFT", BORDER, BORDER+SPACING)
					totems:SetFrameStrata("LOW")
					totems:Width(CLASSBAR_WIDTH)
					totems:Height(POWERBAR_HEIGHT - (BORDER*2))
				end
				totems.Destroy = true

				for i = 1, 4 do
					totems[i] = CreateFrame("StatusBar", nil, totems)
					totems[i]:SetHeight(totems:GetHeight())
					totems[i]:SetWidth(E.Scale(totems:GetWidth() - 3) / 4)

					if (i == 1) then
						totems[i]:SetPoint("LEFT", totems)
					else
						totems[i]:Point("LEFT", totems[i-1], "RIGHT", SPACING, 0)
					end
					totems[i]:SetStatusBarTexture(NORMTEX)
					totems[i]:GetStatusBarTexture():SetHorizTile(false)
					totems[i]:SetMinMaxValues(0, 1)

					
					totems[i].bg = totems[i]:CreateTexture(nil, "BORDER")
					totems[i].bg:SetAllPoints()
					totems[i].bg:SetTexture(NORMTEX)
					totems[i].bg.multiplier = 0.3
				end
				totems.backdrop = CreateFrame("Frame", nil, totems)
				totems.backdrop:SetTemplate("Default")
				totems.backdrop:Point("TOPLEFT", -BORDER, BORDER)
				totems.backdrop:Point("BOTTOMRIGHT", BORDER, -BORDER)
				totems.backdrop:SetFrameLevel(totems:GetFrameLevel() - 1)
				
				if POWERTHEME == true then
					totems:HookScript("OnShow", function()
						health:Point("TOPRIGHT", self, "TOPRIGHT", -BORDER, -BORDER)
						health:Point("TOPLEFT", self, "TOPLEFT", PORTRAIT_WIDTH+BORDER, -BORDER)
					end)
					totems:HookScript("OnHide", function()
						health:Point("TOPRIGHT", self, "TOPRIGHT", -BORDER, -BORDER)
						health:Point("TOPLEFT", self, "TOPLEFT", PORTRAIT_WIDTH+BORDER, -BORDER)		
					end)
				else
					totems:HookScript("OnShow", function()
						health:Point("TOPRIGHT", self, "TOPRIGHT", -BORDER, -(BORDER+POWERBAR_HEIGHT+SPACING))
						health:Point("TOPLEFT", self, "TOPLEFT", PORTRAIT_WIDTH+BORDER, -(BORDER+POWERBAR_HEIGHT+SPACING))
					end)
					totems:HookScript("OnHide", function()
						health:Point("TOPRIGHT", self, "TOPRIGHT", -BORDER, -BORDER)
						health:Point("TOPLEFT", self, "TOPLEFT", PORTRAIT_WIDTH+BORDER, -BORDER)
					end)
				end

				self.TotemBar = totems			
			end
			
			--Eclipse Bar
			if E.myclass == "DRUID" then
				local eclipseBar = CreateFrame('Frame', nil, self)
				if POWERTHEME == true then
					eclipseBar:Width(CLASSBAR2_WIDTH - BORDER*2)
					eclipseBar:Height(CLASSBAR_HEIGHT - BORDER*2)
					eclipseBar:Point("LEFT", self, "TOPLEFT", (BORDER*2 + 4), BORDER - (CLASSBAR_HEIGHT/2))
					eclipseBar:SetFrameStrata("MEDIUM")
					eclipseBar:SetFrameLevel(self:GetFrameLevel() + 3)
				else
					eclipseBar:Point("BOTTOMLEFT", health.backdrop, "TOPLEFT", BORDER, BORDER+SPACING)
					eclipseBar:SetFrameStrata("LOW")
					eclipseBar:Width(CLASSBAR_WIDTH)
					eclipseBar:Height(POWERBAR_HEIGHT - (BORDER*2))
				end

				local lunarBar = CreateFrame('StatusBar', nil, eclipseBar)
				lunarBar:SetPoint('LEFT', eclipseBar)
				lunarBar:SetSize(eclipseBar:GetWidth(), eclipseBar:GetHeight())
				lunarBar:SetStatusBarTexture(NORMTEX)
				lunarBar:SetStatusBarColor(.30, .52, .90)
				eclipseBar.LunarBar = lunarBar

				local solarBar = CreateFrame('StatusBar', nil, eclipseBar)
				solarBar:SetPoint('LEFT', lunarBar:GetStatusBarTexture(), 'RIGHT')
				solarBar:SetSize(eclipseBar:GetWidth(), eclipseBar:GetHeight())
				solarBar:SetStatusBarTexture(NORMTEX)
				solarBar:SetStatusBarColor(.80, .82,  .60)
				eclipseBar.SolarBar = solarBar

				eclipseBar:FontString("Text", FONT, 10, "THINOUTLINE")
				eclipseBar.Text:SetPoint("CENTER", lunarBar:GetStatusBarTexture(), "RIGHT")
				eclipseBar.Text:SetParent(lunarBar)
				
				eclipseBar.backdrop = CreateFrame("Frame", nil, eclipseBar)
				eclipseBar.backdrop:SetTemplate("Default")
				eclipseBar.backdrop:Point("TOPLEFT", eclipseBar, "TOPLEFT", -BORDER, BORDER)
				eclipseBar.backdrop:Point("BOTTOMRIGHT", lunarBar, "BOTTOMRIGHT", BORDER, -BORDER)
				eclipseBar.backdrop:SetFrameLevel(eclipseBar:GetFrameLevel() - 1)

				if POWERTHEME == true then
					eclipseBar:HookScript("OnShow", function()
						health:Point("TOPRIGHT", self, "TOPRIGHT", -BORDER, -BORDER)
						health:Point("TOPLEFT", self, "TOPLEFT", PORTRAIT_WIDTH+BORDER, -BORDER)
					end)
					eclipseBar:HookScript("OnHide", function()
						health:Point("TOPRIGHT", self, "TOPRIGHT", -BORDER, -BORDER)
						health:Point("TOPLEFT", self, "TOPLEFT", PORTRAIT_WIDTH+BORDER, -BORDER)		
					end)
				else
					eclipseBar:HookScript("OnShow", function()
						health:Point("TOPRIGHT", self, "TOPRIGHT", -BORDER, -(BORDER+POWERBAR_HEIGHT+SPACING))
						health:Point("TOPLEFT", self, "TOPLEFT", PORTRAIT_WIDTH+BORDER, -(BORDER+POWERBAR_HEIGHT+SPACING))
					end)
					eclipseBar:HookScript("OnHide", function()
						health:Point("TOPRIGHT", self, "TOPRIGHT", -BORDER, -BORDER)
						health:Point("TOPLEFT", self, "TOPLEFT", PORTRAIT_WIDTH+BORDER, -BORDER)
					end)
				end
				
				self.EclipseBar = eclipseBar
				self.EclipseBar.PostUpdatePower = E.EclipseDirection
			end
		end
		
		--Druid Mana
		if E.myclass == "DRUID" then
			self:FontString("DruidMana", FONT, FONTSIZE, "THINOUTLINE")
			self.DruidMana:SetTextColor(1, 0.49, 0.04)	
			self:HookScript("OnUpdate", E.UpdateDruidMana)
		end
		
		--Alternative Power Bar
		local altpower = CreateFrame("StatusBar", nil, health)
		altpower:SetStatusBarTexture(NORMTEX)
		altpower:GetStatusBarTexture():SetHorizTile(false)
		altpower:EnableMouse(true)
		altpower:SetFrameStrata("HIGH")
		altpower.PostUpdate = E.AltPowerBarPostUpdate
		altpower:Point("TOPLEFT", ElvuiInfoLeft, "TOPLEFT", BORDER, -BORDER)
		altpower:Point("BOTTOMRIGHT", ElvuiInfoLeft, "BOTTOMRIGHT", -BORDER, BORDER)
		altpower:HookScript("OnShow", E.AltPowerBarOnToggle)
		altpower:HookScript("OnHide", E.AltPowerBarOnToggle)
		
		altpower:FontString("text", FONT, FONTSIZE, "THINOUTLINE")
		altpower.text:SetPoint("CENTER")
		altpower.text:SetJustifyH("CENTER")		
		self.AltPowerBar = altpower
		
		--Incoming Heals
		if C["raidframes"].healcomm == true then
			local mhpb = CreateFrame('StatusBar', nil, health)
			mhpb:SetPoint('BOTTOMLEFT', health:GetStatusBarTexture(), 'BOTTOMRIGHT')
			mhpb:SetPoint('TOPLEFT', health:GetStatusBarTexture(), 'TOPRIGHT')	
			mhpb:SetWidth(POWERBAR_WIDTH)
			mhpb:SetStatusBarTexture(C["media"].blank)
			mhpb:SetStatusBarColor(0, 1, 0.5, 0.25)
			
			local ohpb = CreateFrame('StatusBar', nil, health)
			ohpb:SetPoint('BOTTOMLEFT', mhpb:GetStatusBarTexture(), 'BOTTOMRIGHT', 0, 0)
			ohpb:SetPoint('TOPLEFT', mhpb:GetStatusBarTexture(), 'TOPRIGHT', 0, 0)		
			ohpb:SetWidth(mhpb:GetWidth())
			ohpb:SetStatusBarTexture(C["media"].blank)
			ohpb:SetStatusBarColor(0, 1, 0, 0.25)
			
			self.HealPrediction = {
				myBar = mhpb,
				otherBar = ohpb,
				maxOverflow = 1,
				PostUpdate = function(self)
					if self.myBar:GetValue() == 0 then self.myBar:SetAlpha(0) else self.myBar:SetAlpha(1) end
					if self.otherBar:GetValue() == 0 then self.otherBar:SetAlpha(0) else self.otherBar:SetAlpha(1) end
				end
			}
		end				
	end
	
	------------------------------------------------------------------------
	-- Target
	------------------------------------------------------------------------
	if unit == "target" then
		local POWERBAR_WIDTH = C["unitframes"].playtarwidth/2*E.ResScale
		local CLASSBAR_WIDTH = (C["unitframes"].playtarwidth - (2*2))*E.ResScale
		local POWERBAR_HEIGHT = 10*E.ResScale
		local CASTBAR_HEIGHT = 20*E.ResScale
		local CASTBAR_WIDTH = C["unitframes"].casttargetwidth*E.ResScale
		local PORTRAIT_WIDTH = 45*E.ResScale
	
		if C["unitframes"].charportraithealth == true or C["unitframes"].charportrait == false then
			PORTRAIT_WIDTH = 0
		elseif C["unitframes"].charportrait == true then
			CLASSBAR_WIDTH = math.ceil(((C["unitframes"].playtarwidth - (2*2)) - 45)*E.ResScale)
		end

		--Health Bar
		local health = E.ContructHealthBar(self, true, true)
		health:Point("TOPRIGHT", self, "TOPRIGHT", -BORDER, -BORDER)
		if POWERTHEME == true then
			health:Point("BOTTOMLEFT", self, "BOTTOMLEFT", BORDER, BORDER + (POWERBAR_HEIGHT/2))
		else
			health:Point("BOTTOMLEFT", self, "BOTTOMLEFT", BORDER, BORDER + POWERBAR_HEIGHT)
		end

		health.value:Point("RIGHT", health, "RIGHT", -4, 0)
		self.Health = health

		--Power Bar
		local power = E.ConstructPowerBar(self, true, true)
		if POWERTHEME == true then
			power:Width(POWERBAR_WIDTH - BORDER*2)
			power:Height(POWERBAR_HEIGHT - BORDER*2)
			power:Point("LEFT", self, "BOTTOMLEFT", BORDER*2 + 4, BORDER + (POWERBAR_HEIGHT/2))
			power:SetFrameStrata("MEDIUM")
			power:SetFrameLevel(self:GetFrameLevel() + 3)
		else
			power:Point("TOPRIGHT", health.backdrop, "BOTTOMRIGHT", -BORDER, -(BORDER + SPACING))
			power:Point("BOTTOMLEFT", self, "BOTTOMLEFT", BORDER, BORDER)
		end		
		power.value:Point("LEFT", health, "LEFT", 4, 0)
		
		self.Power = power

		--Name
		self:FontString("Name", FONT, FONTSIZE, "THINOUTLINE")
		self.Name:SetJustifyH("LEFT")
		self.Name:SetShadowColor(0, 0, 0, 0)
		self.Name.frequentUpdates = 0.2
		self:Tag(self.Name, '[Elvui:getnamecolor][Elvui:namelong] [Elvui:diffcolor][level] [shortclassification]')
		
		--Portrait
		if C["unitframes"].charportrait == true then
			if C["unitframes"].charportraithealth == true then
				local portrait = CreateFrame("PlayerModel", nil, health)
				portrait:SetFrameLevel(health:GetFrameLevel() + 1)
				portrait:SetAllPoints(health)
				portrait.PostUpdate = function(self) self:SetAlpha(0) self:SetAlpha(0.35) end		
				self.Portrait = portrait
				
				local overlay = CreateFrame("Frame", nil, self)
				overlay:SetFrameLevel(self:GetFrameLevel() - 2)
				
				health.bg:ClearAllPoints()
				health.bg:Point('BOTTOMLEFT', health:GetStatusBarTexture(), 'BOTTOMRIGHT')
				health.bg:Point('TOPRIGHT', health)
				health.bg:SetDrawLayer("OVERLAY", 7)
				health.bg:SetParent(overlay)
			else
				--Reposition Health
				health:Point("TOPRIGHT", -(PORTRAIT_WIDTH+BORDER), -BORDER)
				
				local portrait = CreateFrame("PlayerModel", nil, self)
				portrait:SetFrameStrata("LOW")
				portrait.backdrop = CreateFrame("Frame", nil, portrait)
				portrait.backdrop:SetTemplate("Default")
				portrait.backdrop:SetPoint("TOPRIGHT", self, "TOPRIGHT")
				if POWERTHEME == true then
					portrait.backdrop:Point("BOTTOMLEFT", health.backdrop, "BOTTOMRIGHT", SPACING, 0)
				else
					portrait.backdrop:Point("BOTTOMLEFT", power.backdrop, "BOTTOMRIGHT", SPACING, 0)
				end				
				portrait.backdrop:SetFrameLevel(portrait:GetFrameLevel() - 1)
				
				portrait:Point('BOTTOMLEFT', portrait.backdrop, 'BOTTOMLEFT', BORDER, BORDER)		
				portrait:Point('TOPRIGHT', portrait.backdrop, 'TOPRIGHT', -BORDER, -BORDER)
				
				self.Portrait = portrait
			end
		end
				
		--Auras
		if C["unitframes"].targetauras then
			local buffs = CreateFrame("Frame", nil, self)
			buffs.num = C["unitframes"].playtarbuffperrow
			buffs:SetWidth(TARGET_WIDTH)
			buffs.spacing = E.Scale(SPACING)
			buffs.size = (((C["unitframes"].playtarwidth - (buffs.spacing*(buffs.num - 1))) / buffs.num))*E.ResScale
			buffs:Point("BOTTOM", self, "TOP", 0, SPACING)
			buffs:SetHeight(buffs.size)
			buffs.initialAnchor = 'BOTTOMLEFT'
			buffs["growth-y"] = "UP"	
			buffs["growth-x"] = "RIGHT"
			buffs.PostCreateIcon = E.PostCreateAura
			buffs.PostUpdateIcon = E.PostUpdateAura
			self.Buffs = buffs	
			
			local debuffs = CreateFrame("Frame", nil, self)
			debuffs.num = C["unitframes"].playtarbuffperrow
			debuffs:SetWidth(TARGET_WIDTH)
			debuffs.spacing = E.Scale(SPACING)
			debuffs.size = ((C["unitframes"].playtarwidth - (debuffs.spacing*(debuffs.num - 1))) / debuffs.num)*E.ResScale
			debuffs:SetHeight(debuffs.size)
			debuffs:Point("BOTTOM", buffs, "TOP", 0, SPACING)	
			debuffs.initialAnchor = 'BOTTOMRIGHT'
			debuffs["growth-y"] = "UP"
			debuffs["growth-x"] = "LEFT"
			debuffs.PostCreateIcon = E.PostCreateAura
			debuffs.PostUpdateIcon = E.PostUpdateAura
			debuffs.CustomFilter = E.AuraFilter
			self.Debuffs = debuffs
		end

		--Cast Bar
		if C["unitframes"].unitcastbar == true then
			local castbar = E.ConstructCastBar(self, CASTBAR_WIDTH, CASTBAR_HEIGHT, "RIGHT")
			castbar:Point("TOPLEFT", self, "BOTTOMLEFT", BORDER, -(BORDER*2+BORDER))
			
			self.Castbar = castbar
		end
		
		-- Debuff Highlight
		if C["unitframes"].debuffhighlight == true then
			local dbh = self:CreateTexture(nil, "OVERLAY")
			if POWERTHEME == true then
				dbh:SetPoint("TOPLEFT")
				dbh:SetPoint("BOTTOMRIGHT", health.backdrop, "BOTTOMRIGHT")
			else
				dbh:SetAllPoints()
			end
			dbh:SetTexture(C["media"].blank)
			dbh:SetBlendMode("ADD")
			dbh:SetVertexColor(0,0,0,0)
			self.DebuffHighlight = dbh
			self.DebuffHighlightFilter = true
			self.DebuffHighlightAlpha = 0.35
		end

		--Combat Feedback
		if C["unitframes"].combatfeedback == true then
			self:FontString("CombatFeedbackText", FONT, FONTSIZE, "OUTLINE")
			self.CombatFeedbackText:SetPoint("CENTER", health, "CENTER", 0, -5)
			
			self.CombatFeedbackText.colors = {
				DAMAGE = {0.69, 0.31, 0.31},
				CRUSHING = {0.69, 0.31, 0.31},
				CRITICAL = {0.69, 0.31, 0.31},
				GLANCING = {0.69, 0.31, 0.31},
				STANDARD = {0.84, 0.75, 0.65},
				IMMUNE = {0.84, 0.75, 0.65},
				ABSORB = {0.84, 0.75, 0.65},
				BLOCK = {0.84, 0.75, 0.65},
				RESIST = {0.84, 0.75, 0.65},
				MISS = {0.84, 0.75, 0.65},
				HEAL = {0.33, 0.59, 0.33},
				CRITHEAL = {0.33, 0.59, 0.33},
				ENERGIZE = {0.31, 0.45, 0.63},
				CRITENERGIZE = {0.31, 0.45, 0.63},
			}
		end

		--Combo Bar
		local combo = CreateFrame("Frame", nil, self)
		combo:Point("BOTTOMLEFT", health.backdrop, "TOPLEFT", BORDER, BORDER+SPACING)
		combo:SetFrameStrata("LOW")
		combo:Width(CLASSBAR_WIDTH)
		combo:Height(POWERBAR_HEIGHT - (BORDER*2))

		for i = 1, 5 do					
			combo[i] = CreateFrame("StatusBar", nil, combo)
			combo[i]:SetHeight(combo:GetHeight())					
			combo[i]:SetStatusBarTexture(NORMTEX)
			combo[i]:GetStatusBarTexture():SetHorizTile(false)
							
			if i == 1 then
				combo[i]:SetPoint("LEFT", combo)
			else
				combo[i]:Point("LEFT", combo[i-1], "RIGHT", SPACING, 0)
			end
			combo[i]:SetAlpha(0.15)
			combo[i]:SetWidth(E.Scale(CLASSBAR_WIDTH - 4)/5)
		end
		
		combo[1]:SetStatusBarColor(0.69, 0.31, 0.31)		
		combo[2]:SetStatusBarColor(0.69, 0.31, 0.31)
		combo[3]:SetStatusBarColor(0.65, 0.63, 0.35)
		combo[4]:SetStatusBarColor(0.65, 0.63, 0.35)
		combo[5]:SetStatusBarColor(0.33, 0.59, 0.33)
		
		combo.backdrop = CreateFrame("Frame", nil, combo)
		combo.backdrop:SetTemplate("Default")
		combo.backdrop:Point("TOPLEFT", -BORDER, BORDER)
		combo.backdrop:Point("BOTTOMRIGHT", BORDER, -BORDER)
		combo.backdrop:SetFrameLevel(combo:GetFrameLevel() - 1)
		
		--[[This is a little differant than everything else because we have to take into account 
		the combobar is movable with the /moveele command, this should make it work correctly only 
		after a reloadui.]]
		combo:HookScript("OnShow", function()			
			if ElementsPos and HealComboBar and ElementsPos["HealComboBar"]["moved"] and E.CreatedMoveEleFrames["HealComboBar"] then return end
			combo:ClearAllPoints()
			combo:Point("BOTTOMLEFT", health.backdrop, "TOPLEFT", BORDER, BORDER+SPACING)
			
			health:Point("TOPRIGHT", self, "TOPRIGHT", -(BORDER+PORTRAIT_WIDTH), -(BORDER+POWERBAR_HEIGHT+SPACING))
		end)
		combo:HookScript("OnHide", function()
			health:Point("TOPRIGHT", self, "TOPRIGHT", -(BORDER+PORTRAIT_WIDTH), -BORDER)
		end)
		combo:SetScript("OnUpdate", function()
			if C["general"].classcolortheme == true and combo:IsShown() then
				combo.backdrop:SetBackdropBorderColor(self.Health:GetStatusBarColor())
			elseif C["general"].classcolortheme ~= true then
				combo:SetScript("OnUpdate", nil)
			end			
		end)		
		combo:Hide()
		
		combo.Override = E.ComboDisplay
		self.CPoints = combo
		
		--Incoming Heals
		if C["raidframes"].healcomm == true then
			local mhpb = CreateFrame('StatusBar', nil, health)
			mhpb:SetPoint('BOTTOMLEFT', health:GetStatusBarTexture(), 'BOTTOMRIGHT')
			mhpb:SetPoint('TOPLEFT', health:GetStatusBarTexture(), 'TOPRIGHT')	
			mhpb:SetWidth(POWERBAR_WIDTH)
			mhpb:SetStatusBarTexture(C["media"].blank)
			mhpb:SetStatusBarColor(0, 1, 0.5, 0.25)
			
			local ohpb = CreateFrame('StatusBar', nil, health)
			ohpb:SetPoint('BOTTOMLEFT', mhpb:GetStatusBarTexture(), 'BOTTOMRIGHT', 0, 0)
			ohpb:SetPoint('TOPLEFT', mhpb:GetStatusBarTexture(), 'TOPRIGHT', 0, 0)		
			ohpb:SetWidth(mhpb:GetWidth())
			ohpb:SetStatusBarTexture(C["media"].blank)
			ohpb:SetStatusBarColor(0, 1, 0, 0.25)
			
			self.HealPrediction = {
				myBar = mhpb,
				otherBar = ohpb,
				maxOverflow = 1,
				PostUpdate = function(self)
					if self.myBar:GetValue() == 0 then self.myBar:SetAlpha(0) else self.myBar:SetAlpha(1) end
					if self.otherBar:GetValue() == 0 then self.otherBar:SetAlpha(0) else self.otherBar:SetAlpha(1) end
				end
			}
		end				
	end
	
	------------------------------------------------------------------------
	--	TargetofTarget, Pet, PetTarget, Focus, FocusTarget
	------------------------------------------------------------------------
	if (unit == "targettarget" or unit == "pet" or unit == "pettarget" or unit == "focustarget" or unit == "focus") then
		local POWERBAR_WIDTH = C["unitframes"].smallwidth/1.5*E.ResScale
		local POWERBAR_HEIGHT = 8
		local CASTBAR_WIDTH = C["unitframes"].castfocuswidth*E.ResScale
		
		--Health Bar
		local health = E.ContructHealthBar(self, true, nil)
		health:Point("TOPRIGHT", self, "TOPRIGHT", -BORDER, -BORDER)
		if POWERTHEME == true then
			health:Point("BOTTOMLEFT", self, "BOTTOMLEFT", BORDER, BORDER + (POWERBAR_HEIGHT/2))
		else
			health:Point("BOTTOMLEFT", self, "BOTTOMLEFT", BORDER, BORDER + POWERBAR_HEIGHT)
		end
		
		self.Health = health

		--Power Bar
		if unit ~= "pettarget" then
			local power = E.ConstructPowerBar(self, true, nil)
			if POWERTHEME == true then
				power:Width(POWERBAR_WIDTH - BORDER*2)
				power:Height(POWERBAR_HEIGHT - BORDER*2)
				power:Point("CENTER", self, "BOTTOM", 0, BORDER + (POWERBAR_HEIGHT/2))
				power:SetFrameStrata("MEDIUM")
				power:SetFrameLevel(self:GetFrameLevel() + 3)
			else
				power:Point("TOPLEFT", health.backdrop, "BOTTOMLEFT", BORDER, -(BORDER + SPACING))
				power:Point("BOTTOMRIGHT", self, "BOTTOMRIGHT", -BORDER, BORDER)
			end					
			
			self.Power = power
		end
		
		--Name
		self:FontString("Name", FONT, FONTSIZE, "THINOUTLINE")
		self.Name:Point("CENTER", health, "CENTER", 0, 2)
		self.Name:SetShadowColor(0, 0, 0, 0)
		self.Name.frequentUpdates = 0.5
		self:Tag(self.Name, '[Elvui:getnamecolor][Elvui:namemedium]')		
		
		--Auras
		if (unit == "targettarget" and C["unitframes"].totdebuffs == true) or (unit == "focus" and C["unitframes"].focusdebuffs == true) then	
			local debuffs = CreateFrame("Frame", nil, self)
			debuffs.num = C["unitframes"].smallbuffperrow
			debuffs:SetWidth(SMALL_WIDTH)
			debuffs.spacing = E.Scale(SPACING)
			debuffs.size = ((C["unitframes"].smallwidth - (debuffs.spacing*(debuffs.num - 1))) / debuffs.num)*E.ResScale
			debuffs:SetHeight(debuffs.size)
			debuffs:Point("TOP", self, "BOTTOM", 0, -SPACING)	
			debuffs.initialAnchor = 'BOTTOMRIGHT'
			debuffs["growth-y"] = "UP"
			debuffs["growth-x"] = "LEFT"
			debuffs.PostCreateIcon = E.PostCreateAura
			debuffs.PostUpdateIcon = E.PostUpdateAura
			debuffs.CustomFilter = E.AuraFilter
			self.Debuffs = debuffs
		end
	
		-- Debuff Highlight
		if C["unitframes"].debuffhighlight == true then
			local dbh = self:CreateTexture(nil, "OVERLAY")
			if POWERTHEME == true then
				dbh:SetPoint("TOPLEFT")
				dbh:SetPoint("BOTTOMRIGHT", health.backdrop, "BOTTOMRIGHT")
			else
				dbh:SetAllPoints()
			end
			dbh:SetTexture(C["media"].blank)
			dbh:SetBlendMode("ADD")
			dbh:SetVertexColor(0,0,0,0)
			self.DebuffHighlight = dbh
			self.DebuffHighlightFilter = true
			self.DebuffHighlightAlpha = 0.35
		end
		
		if unit == "pet" then
			--Dummy Cast Bar, so we don't see an extra castbar while in vehicle
			if (C["unitframes"].unitcastbar == true) then
				local castbar = CreateFrame("StatusBar", nil, self)
				self.Castbar = castbar
			end
			
			--Incoming Pet Heals
			if C["raidframes"].raidunitbuffwatch == true then
				E.createAuraWatch(self,unit)
			end
			
			--Autohide in combat
			if C["unitframes"].combat == true then
				self:HookScript("OnEnter", function(self) E.Fader(self, true) end)
				self:HookScript("OnLeave", function(self) E.Fader(self, false) end)
			end
		elseif unit == "focus" and C["unitframes"].unitcastbar == true	then
			--Cast Bar
			local castbar = E.ConstructCastBar(self, CASTBAR_WIDTH, 20, "LEFT")
			castbar:Point("TOP", UIParent, "TOP", 0, -150)
			
			self.Castbar = castbar
		end
	end
	
	------------------------------------------------------------------------
	--	Arena and Boss
	------------------------------------------------------------------------
	if (unit and unit:find("arena%d") and C["unitframes"].arena == true) or (unit and unit:find("boss%d") and C["unitframes"].showboss == true) then
		local POWERBAR_WIDTH = C["unitframes"].arenabosswidth/2*E.ResScale
		local TRINKET_WIDTH = BOSS_HEIGHT * 0.9
		local POWERBAR_HEIGHT = 7
		local CASTBAR_HEIGHT = 16*E.ResScale
		local CASTBAR_WIDTH = BOSS_WIDTH

		if unit:find("arena%d") then
			POWERBAR_WIDTH = C["unitframes"].arenabosswidth/2.3*E.ResScale
		end
		
		-- Right-click focus on arena or boss units
		self:SetAttribute("type2", "focus")
		
		--Health Bar
		local health = E.ContructHealthBar(self, true, true)
		health:Point("TOPRIGHT", self, "TOPRIGHT", -BORDER, -BORDER)
		if POWERTHEME == true then
			health:Point("BOTTOMLEFT", self, "BOTTOMLEFT", BORDER, BORDER + (POWERBAR_HEIGHT/2))
		else
			health:Point("BOTTOMLEFT", self, "BOTTOMLEFT", BORDER, BORDER + POWERBAR_HEIGHT)
		end

		health.value:Point("TOPRIGHT", health, "TOPRIGHT", 0, -2)
		self.Health = health
		
		--Power Bar
		local power = E.ConstructPowerBar(self, true, true)
		if POWERTHEME == true then
			power:Width(POWERBAR_WIDTH - BORDER*2)
			power:Height(POWERBAR_HEIGHT - BORDER*2)
			power:Point("LEFT", self, "BOTTOMLEFT", BORDER*2 + 4, BORDER + (POWERBAR_HEIGHT/2))
			power:SetFrameStrata("MEDIUM")
			power:SetFrameLevel(self:GetFrameLevel() + 3)
		else
			power:Point("TOPRIGHT", health.backdrop, "BOTTOMRIGHT", -BORDER, -(BORDER + SPACING))
			power:Point("BOTTOMLEFT", self, "BOTTOMLEFT", BORDER, BORDER)
		end		
		power.value:Point("BOTTOMRIGHT", health, "BOTTOMRIGHT")
		
		self.Power = power
				
		--Name & Trinkets
		if (unit and unit:find('arena%d')) then
			health:Point("TOPRIGHT", self, "TOPRIGHT", -(TRINKET_WIDTH + BORDER), -BORDER)
			
			local trinket = CreateFrame("Frame", nil, self)
			trinket.trinketUseAnnounce = true
			
			trinket.bg = CreateFrame("Frame", nil, trinket)
			trinket.bg:Point("TOPRIGHT", self, "TOPRIGHT")
			if POWERTHEME == true then
				trinket.bg:SetPoint("BOTTOMLEFT", health.backdrop, "BOTTOMRIGHT", SPACING, 0)
			else
				trinket.bg:SetPoint("BOTTOMLEFT", power.backdrop, "BOTTOMRIGHT", SPACING, 0)		
			end
			trinket.bg:SetTemplate("Default")
			trinket.bg:SetFrameLevel(trinket:GetFrameLevel() - 1)
			
			trinket:Point("TOPLEFT", trinket.bg, BORDER, -BORDER)
			trinket:Point("BOTTOMRIGHT", trinket.bg, -BORDER, BORDER)
			
			self.Trinket = trinket			
		end
		
		--Name & AltPowerBar
		if (unit and unit:find('boss%d')) then
			local altpower = CreateFrame("StatusBar", nil, self)
			altpower:SetStatusBarTexture(NORMTEX)
			altpower:GetStatusBarTexture():SetHorizTile(false)
			altpower.PostUpdate = E.AltPowerBarPostUpdate
			
			altpower.bg = CreateFrame("Frame", nil, altpower)
			altpower.bg:Point("BOTTOMLEFT", health.backdrop, "TOPLEFT", 0, SPACING)
			altpower.bg:Point("TOPRIGHT", self, "TOPRIGHT")
			altpower.bg:SetTemplate("Default")
			altpower.bg:SetFrameLevel(altpower:GetFrameLevel() - 1)

			altpower:Point("TOPLEFT", altpower.bg, "TOPLEFT", BORDER, -BORDER)
			altpower:Point("BOTTOMRIGHT", altpower.bg, "BOTTOMRIGHT", -BORDER, BORDER)
			altpower:HookScript("OnShow", function(self) 			
				health:Point("TOPRIGHT", self:GetParent(), "TOPRIGHT", -BORDER, -(POWERBAR_HEIGHT + BORDER))	
			end)
			
			altpower:HookScript("OnHide", function(self) 
				health:Point("TOPRIGHT", self:GetParent(), "TOPRIGHT", -BORDER, -BORDER)			
			end)
			
			altpower:FontString("text", FONT, FONTSIZE, "THINOUTLINE")
			altpower.text:Point("RIGHT", power.value, "LEFT", 2, E.mult)		
			
			self.AltPowerBar = altpower
		end
		
		--Name
		self:FontString("Name", FONT, FONTSIZE, "THINOUTLINE")
		self.Name:Point("LEFT", health, "LEFT", 4, 0)
		self.Name:SetShadowColor(0, 0, 0, 0)
		self.Name.frequentUpdates = 0.5
		self:Tag(self.Name, '[Elvui:getnamecolor][Elvui:namemedium]')
				
		--Auras
		local buffs = CreateFrame("Frame", nil, self)
		buffs.num = 3
		buffs:SetWidth(BOSS_WIDTH)
		buffs.spacing = E.Scale(SPACING)
		if POWERTHEME == true then
			buffs.size = BOSS_HEIGHT - (POWERBAR_HEIGHT - BORDER - SPACING)
		else
			buffs.size = BOSS_HEIGHT
		end
		buffs:Point("TOPRIGHT", self, "TOPLEFT", -4, 0)
		buffs:SetHeight(buffs.size)
		buffs.initialAnchor = 'RIGHT'
		buffs["growth-y"] = "UP"	
		buffs["growth-x"] = "LEFT"
		buffs.PostCreateIcon = E.PostCreateAura
		buffs.PostUpdateIcon = E.PostUpdateAura
		if (unit and unit:find('arena%d')) then
			buffs.CustomFilter = E.AuraFilter
		end
		self.Buffs = buffs	
		
		local debuffs = CreateFrame("Frame", nil, self)
		debuffs.num = 3
		debuffs:SetWidth(BOSS_WIDTH)
		debuffs.spacing = E.Scale(2)
		if POWERTHEME == true then
			debuffs.size = BOSS_HEIGHT - (POWERBAR_HEIGHT - BORDER - SPACING)
		else
			debuffs.size = BOSS_HEIGHT
		end
		debuffs:SetHeight(debuffs.size)
		debuffs:Point("TOPLEFT", self, "TOPRIGHT", 4, 0)
		debuffs.initialAnchor = 'LEFT'
		debuffs["growth-y"] = "UP"
		debuffs["growth-x"] = "RIGHT"
		debuffs.PostCreateIcon = E.PostCreateAura
		debuffs.PostUpdateIcon = E.PostUpdateAura
		debuffs.CustomFilter = E.AuraFilter
		self.Debuffs = debuffs

		--Cast Bar
		if C["unitframes"].unitcastbar == true then
			local castbar = E.ConstructCastBar(self, CASTBAR_WIDTH, CASTBAR_HEIGHT, "RIGHT")
			castbar:Point("TOPLEFT", self, "BOTTOMLEFT", BORDER, -BORDER*2)
			
			self.Castbar = castbar
		end
	end

	------------------------------------------------------------------------
	--	Main tanks and Main Assists
	------------------------------------------------------------------------
	if unit == "raid" or unit == "raidtarget" then
		--Health Bar
		local health = E.ContructHealthBar(self, true, nil)
		health:Point("TOPRIGHT", self, "TOPRIGHT", -BORDER, -BORDER)
		health:Point("BOTTOMLEFT", self, "BOTTOMLEFT", BORDER, BORDER)
		self.Health = health
	
		--Name
		self:FontString("Name", FONT, FONTSIZE, "THINOUTLINE")
		self.Name:Point("CENTER", health, "CENTER", 0, 2)
		self.Name.frequentUpdates = 0.5
		self.Name:SetShadowColor(0, 0, 0, 0)
		self:Tag(self.Name, '[Elvui:getnamecolor][Elvui:namemedium]')			
	end
	
	------------------------------------------------------------------------
	--	All Units
	------------------------------------------------------------------------
	if unit ~= "party" then
		local RaidIcon = self:CreateTexture(nil, "OVERLAY")
		RaidIcon:SetTexture("Interface\\AddOns\\ElvUI\\media\\textures\\raidicons.blp") 
		RaidIcon:Size(18, 18)
		RaidIcon:Point("CENTER", self.Health, "TOP", 0, BORDER)
		self.RaidIcon = RaidIcon
	end
		
	return self
end

------------------------------------------------------------------------
--	Default Positions
------------------------------------------------------------------------
local function LoadHealLayout()
	local oUF = ElvUF or oUF
	assert(oUF, "ElvUI was unable to locate oUF.")
	
	if E.LoadUFFunctions then E.LoadUFFunctions("ElvHeal") end
	oUF:RegisterStyle('Elv', Shared)

	-- Player
	local player = oUF:Spawn('player', "ElvHeal_player")
	player:Point("BOTTOMRIGHT", ElvuiSplitActionBarLeftBackground, "TOPRIGHT", 0, 200)
	player:Size(PLAYER_WIDTH, PLAYER_HEIGHT)

	-- Target
	local target = oUF:Spawn('target', "ElvHeal_target")
	target:Point("BOTTOMLEFT", ElvuiSplitActionBarRightBackground, "TOPLEFT", 0, 200)
	target:SetSize(TARGET_WIDTH, TARGET_HEIGHT)

	-- Target's Target
	local tot = oUF:Spawn('targettarget', "ElvHeal_targettarget")
	tot:Point("TOPRIGHT", ElvHeal_target, "BOTTOMRIGHT", 0, -42)
	tot:Size(SMALL_WIDTH, SMALL_HEIGHT)
	
	-- Focus
	local focus = oUF:Spawn('focus', "ElvHeal_focus")
	focus:Point("TOPLEFT", ElvHeal_player, "BOTTOMLEFT", 0, -42)
	focus:Size(SMALL_WIDTH, SMALL_HEIGHT)

	-- Player's Pet
	local pet = oUF:Spawn('pet', "ElvHeal_pet")
	pet:Point("TOPRIGHT", ElvHeal_player, "BOTTOMRIGHT", 0, -42)
	pet:Size(SMALL_WIDTH, SMALL_HEIGHT)
	pet:SetParent(player)

	-- Focus's target
	if C["unitframes"].showfocustarget == true then
		local focustarget = oUF:Spawn('focustarget', "ElvHeal_focustarget")
		focustarget:Point("TOP", ElvHeal_focus, "BOTTOM", 0, -32)
		focustarget:Size(SMALL_WIDTH, SMALL_HEIGHT)
	end


	if C.unitframes.arena then
		local arena = {}
		for i = 1, 5 do
			arena[i] = oUF:Spawn("arena"..i, "ElvHealArena"..i)
			if i == 1 then
				arena[i]:Point("BOTTOMLEFT", ChatRBackground2, "TOPLEFT", -80, 285)
			else
				arena[i]:Point("BOTTOM", arena[i-1], "TOP", 0, 38)
			end
			arena[i]:Size(BOSS_WIDTH, BOSS_HEIGHT)
		end
	end

	if C["unitframes"].showboss then
		local boss = {}
		for i = 1, MAX_BOSS_FRAMES do
			boss[i] = oUF:Spawn("boss"..i, "ElvHealBoss"..i)
			if i == 1 then
				boss[i]:Point("BOTTOMLEFT", ChatRBackground2, "TOPLEFT", -80, 285)
			else
				boss[i]:Point('BOTTOM', boss[i-1], 'TOP', 0, 38)             
			end
			boss[i]:Size(BOSS_WIDTH, BOSS_HEIGHT)
		end
	end


	if C["raidframes"].maintank == true then
		local tank = oUF:SpawnHeader('ElvHealMainTank', nil, 'raid', 
			'oUF-initialConfigFunction', ([[
				self:SetWidth(%d)
				self:SetHeight(%d)
			]]):format(TANK_WIDTH, TANK_HEIGHT),
			'showRaid', true, 
			'groupFilter', 'MAINTANK', 
			'yOffset', 7, 
			'point' , 'BOTTOM',
			'template', 'Elv_Mtt'
		)
		tank:Point("LEFT", UIParent, "LEFT", 6, 250)
	end

	if C["raidframes"].mainassist == true then
		local assist = oUF:SpawnHeader("ElvHealMainAssist", nil, 'raid', 
			'oUF-initialConfigFunction', ([[
				self:SetWidth(%d)
				self:SetHeight(%d)
			]]):format(TANK_WIDTH, TANK_HEIGHT),
			'showRaid', true, 
			'groupFilter', 'MAINASSIST', 
			'yOffset', 7, 
			'point' , 'BOTTOM',
			'template', 'Elv_Mtt'
		)
		if C["raidframes"].maintank == true then 
			assist:Point("TOPLEFT", ElvHealMainTank, "BOTTOMLEFT", 0, -50)
		else
			assist:Point("LEFT", UIParent, "LEFT", 6, 250)
		end
	end

	local party
	if C["raidframes"].disableblizz == true then --seriosly lazy addon authors can suck my dick
		for i = 1,MAX_BOSS_FRAMES do
			local t_boss = _G["Boss"..i.."TargetFrame"]
			t_boss:UnregisterAllEvents()
			t_boss.Show = E.dummy
			t_boss:Hide()
			_G["Boss"..i.."TargetFrame".."HealthBar"]:UnregisterAllEvents()
			_G["Boss"..i.."TargetFrame".."ManaBar"]:UnregisterAllEvents()
		end
		
		party = oUF:SpawnHeader("oUF_noParty", nil, "party", "showParty", true)
		local blizzloader = CreateFrame("Frame")
		blizzloader:RegisterEvent("ADDON_LOADED")
		blizzloader:SetScript("OnEvent", function(self, event, addon)
			if addon == "Elvui_RaidHeal" then 
				CompactRaidFrameContainer:Kill()
				CompactPartyFrame:Kill()
			end
		end)
	end
	
	E.LoadMoveElements("Heal")
	if C["classtimer"].enable == true then
		E.LoadClassTimers(ElvHeal_player, ElvHeal_target)
	end
end

E.Layouts["Heal"] = LoadHealLayout
------------------------------------------------------------------------
--	Right-Click on unit frames menu.
------------------------------------------------------------------------

do
	UnitPopupMenus["SELF"] = { "PVP_FLAG", "LOOT_METHOD", "LOOT_THRESHOLD", "OPT_OUT_LOOT_TITLE", "LOOT_PROMOTE", "DUNGEON_DIFFICULTY", "RAID_DIFFICULTY", "RESET_INSTANCES", "RAID_TARGET_ICON", "SELECT_ROLE", "CONVERT_TO_PARTY", "CONVERT_TO_RAID", "LEAVE", "CANCEL" };
	UnitPopupMenus["PET"] = { "PET_PAPERDOLL", "PET_RENAME", "PET_ABANDON", "PET_DISMISS", "CANCEL" };
	UnitPopupMenus["PARTY"] = { "MUTE", "UNMUTE", "PARTY_SILENCE", "PARTY_UNSILENCE", "RAID_SILENCE", "RAID_UNSILENCE", "BATTLEGROUND_SILENCE", "BATTLEGROUND_UNSILENCE", "WHISPER", "PROMOTE", "PROMOTE_GUIDE", "LOOT_PROMOTE", "VOTE_TO_KICK", "UNINVITE", "INSPECT", "ACHIEVEMENTS", "TRADE", "FOLLOW", "DUEL", "RAID_TARGET_ICON", "SELECT_ROLE", "PVP_REPORT_AFK", "RAF_SUMMON", "RAF_GRANT_LEVEL", "CANCEL" }
	UnitPopupMenus["PLAYER"] = { "WHISPER", "INSPECT", "INVITE", "ACHIEVEMENTS", "TRADE", "FOLLOW", "DUEL", "RAID_TARGET_ICON", "RAF_SUMMON", "RAF_GRANT_LEVEL", "CANCEL" }
	UnitPopupMenus["RAID_PLAYER"] = { "MUTE", "UNMUTE", "RAID_SILENCE", "RAID_UNSILENCE", "BATTLEGROUND_SILENCE", "BATTLEGROUND_UNSILENCE", "WHISPER", "INSPECT", "ACHIEVEMENTS", "TRADE", "FOLLOW", "DUEL", "RAID_TARGET_ICON", "SELECT_ROLE", "RAID_LEADER", "RAID_PROMOTE", "RAID_DEMOTE", "LOOT_PROMOTE", "RAID_REMOVE", "PVP_REPORT_AFK", "RAF_SUMMON", "RAF_GRANT_LEVEL", "CANCEL" };
	UnitPopupMenus["RAID"] = { "MUTE", "UNMUTE", "RAID_SILENCE", "RAID_UNSILENCE", "BATTLEGROUND_SILENCE", "BATTLEGROUND_UNSILENCE", "RAID_LEADER", "RAID_PROMOTE", "RAID_MAINTANK", "RAID_MAINASSIST", "RAID_TARGET_ICON", "SELECT_ROLE", "LOOT_PROMOTE", "RAID_DEMOTE", "RAID_REMOVE", "PVP_REPORT_AFK", "CANCEL" };
	UnitPopupMenus["VEHICLE"] = { "RAID_TARGET_ICON", "VEHICLE_LEAVE", "CANCEL" }
	UnitPopupMenus["TARGET"] = { "RAID_TARGET_ICON", "CANCEL" }
	UnitPopupMenus["ARENAENEMY"] = { "CANCEL" }
	UnitPopupMenus["FOCUS"] = { "RAID_TARGET_ICON", "CANCEL" }
	UnitPopupMenus["BOSS"] = { "RAID_TARGET_ICON", "CANCEL" }
end