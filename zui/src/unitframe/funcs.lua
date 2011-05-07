------------------------------------------------------------------------
--	UnitFrame Functions
------------------------------------------------------------------------
local Z, C, L = unpack(select(2, ...)) -- Import Functions/Constants, Config, Locales
local _, ns = ...

--Z.LoadUnitFrame = function(layout)
	local oUF = zUF or oUF
	assert(oUF, "Zui was unable to locate oUF.")

	function Z.BuildHealthBar(self, bg, text)
		local health = CreateFrame('StatusBar', nil, self)
		health:SetStatusBarTexture(C["media"].norm)
		health:SetFrameStrata("LOW")
		health.frequentUpdates = 0.2
		health.PostUpdate = Z.PostUpdateHealth
    health.Smooth = true
		
		if bg then
			health.bg = health:CreateTexture(nil, 'BORDER')
			health.bg:SetAllPoints()
			health.bg:SetTexture(C["media"].blank)
			
			if not C["unitframes"].healthbackdrop then
				health.bg.multiplier = 0.25
			else
				health.bg:SetTexture(unpack(C["media"].backdropcolor))
				health.bg.SetVertexColor = Z.dummy
			end
		end
		
		if text then
			health:FontString("value", C["media"].pxfont, 12, "OUTLINEMONOCHROME")
			health.value:SetShadowColor(0, 0, 0, 0)
			health.value:SetParent(self)
		end
		
		if not C["unitframes"].classcolor then
			health.colorTapping = true
			if C["unitframes"].healthcolorbyvalue then
				health.colorSmooth = true
			else
				health.colorHealth = true
			end
		else
			health.colorTapping = true	
			health.colorClass = true
			health.colorReaction = true
		end
		health.colorDisconnected = true
		
		health.backdrop = CreateFrame('Frame', nil, health)
		health.backdrop:SetTemplate("Default")
		health.backdrop:Point("TOPRIGHT", health, "TOPRIGHT", Z.Scale(2), Z.Scale(2))
		health.backdrop:Point("BOTTOMLEFT", health, "BOTTOMLEFT", Z.Scale(-2), Z.Scale(-2))
		health.backdrop:SetFrameLevel(health:GetFrameLevel() - 1)		
		
		return health
	end

	function Z.BuildPowerBar(self, bg, text)
		local power = CreateFrame('StatusBar', nil, self)
		power:SetStatusBarTexture(C["media"].norm)
		power.frequentUpdates = 0.2
		power:SetFrameStrata("LOW")
		power.PostUpdate = Z.PostUpdatePower
    power.Smooth = true
		
		if bg then
			power.bg = power:CreateTexture(nil, 'BORDER')
			power.bg:SetAllPoints()
			power.bg:SetTexture(C["media"].blank)
			power.bg.multiplier = 0.2
		end
		
		if text then
			power:FontString("value", C["media"].pxfont, 12, "OUTLINEMONOCHROME")
			power.value:SetShadowColor(0, 0, 0, 0)			
			power.value:SetParent(self)
		end
		
		power.colorDisconnected = true
		power.colorPower = true
		power.colorTapping = false
		
		power.backdrop = CreateFrame('Frame', nil, power)
		power.backdrop:SetTemplate("Default")
		power.backdrop:Point("TOPRIGHT", power, "TOPRIGHT", Z.Scale(2), Z.Scale(2))
		power.backdrop:Point("BOTTOMLEFT", power, "BOTTOMLEFT", Z.Scale(-2), Z.Scale(-2))
		power.backdrop:SetFrameLevel(power:GetFrameLevel() - 1)
	
		return power
	end	
		
	function Z.BuildCastBar(self, width, height, direction)
		local castbar = CreateFrame("StatusBar", nil, self)
		castbar:SetStatusBarTexture(C["media"].norm)
		castbar:Height(height)
		castbar:Width(width - Z.Scale(4))
		castbar.CustomDelayText = Z.CustomCastDelayText
		castbar.PostCastStart = Z.PostCastStart
		castbar.PostChannelStart = Z.PostCastStart		
				
		castbar.bg = CreateFrame("Frame", nil, castbar)
		castbar.bg:SetTemplate("Default")
		castbar.bg:SetBackdropBorderColor(unpack(C["media"].bordercolor))
		castbar.bg:Point("TOPLEFT", Z.Scale(-2), Z.Scale(2))
		castbar.bg:Point("BOTTOMRIGHT", Z.Scale(2), Z.Scale(-2))
		castbar.bg:SetFrameLevel(castbar:GetFrameLevel() - 1)
		
		castbar:FontString("Time", C["media"].pxfont, 12, "OUTLINEMONOCHROME")
		castbar.Time:SetShadowColor(0, 0, 0, 0)	
		castbar.Time:Point("RIGHT", castbar, "RIGHT", -4, 0)
		castbar.Time:SetTextColor(0.84, 0.75, 0.65)
		castbar.Time:SetJustifyH("RIGHT")
		castbar.CustomTimeText = Z.CustomCastTimeText

		castbar:FontString("Text", C["media"].uffont, Z.Scale(C["unitframes"].fontsize), "THINOUTLINE")
		castbar.Text:SetPoint("LEFT", castbar, "LEFT", 4, 0)
		castbar.Text:SetTextColor(0.84, 0.75, 0.65)
		castbar.Text:SetShadowColor(0, 0, 0, 0)
		
		-- cast bar latency on player
		if C["unitframes"].cblatency == true and self.unit == "player" then
			castbar.SafeZone = castbar:CreateTexture(nil, "OVERLAY")
			castbar.SafeZone:SetTexture(C["media"].normTex)
			castbar.SafeZone:SetVertexColor(0.69, 0.31, 0.31, 0.75)
		end			

		if C["unitframes"].cbicons then
			local button = CreateFrame("Frame", nil, castbar)
			button:Height(height + Z.Scale(4))
			button:Width(height +  Z.Scale(4))
			button:SetTemplate("Default")
			button:SetBackdropBorderColor(unpack(C["media"].bordercolor))
			if direction == "LEFT" then
				button:Point("RIGHT", castbar, "LEFT",  Z.Scale(-4), 0)
			else
				button:Point("LEFT", castbar, "RIGHT",  Z.Scale(4), 0)
			end
			castbar.Button = button
      
			castbar.Icon = castbar.Button:CreateTexture(nil, "ARTWORK")
			castbar.Icon:Point("TOPLEFT", castbar.Button,  Z.Scale(2),  Z.Scale(-2))
			castbar.Icon:Point("BOTTOMRIGHT", castbar.Button,  Z.Scale(-2), Z.Scale(2))
			castbar.Icon:SetTexCoord(0.08, 0.92, 0.08, .92)
			
			castbar:Width(width - button:GetWidth() - 6)
		end
	
		return castbar
	end
	
	local function CreateSwingStatusBar(parent, text)
		local sbar = CreateFrame("Statusbar", nil, parent)
		sbar:SetPoint("TOPLEFT")
		sbar:SetPoint("BOTTOMRIGHT")
		sbar:SetStatusBarTexture(C["media"].norm)
		sbar:SetStatusBarColor(unpack(C["media"].bordercolor))
		sbar:SetFrameLevel(20)
		sbar:SetFrameStrata("LOW")
		sbar:Hide()
		
		if text then
			sbar:FontString("Text", C["media"].pxfont, 12, "OUTLINEMONOCHROME")
			sbar.Text:Point("CENTER", sbar, "CENTER")
			sbar.Text:SetTextColor(0.84, 0.75, 0.65)
		end
		
		sbar.backdrop = CreateFrame("Frame", nil, sbar)
		sbar.backdrop:SetFrameLevel(sbar:GetFrameLevel() - 1)
		sbar.backdrop:Point("TOPLEFT", parent, "TOPLEFT", Z.Scale(-2), Z.Scale(2))
		sbar.backdrop:Point("BOTTOMRIGHT", parent, "BOTTOMRIGHT", Z.Scale(2), Z.Scale(-2))
		sbar.backdrop:SetTemplate("Default")
		return sbar
	end
	
	function Z.BuildSwingBar(self, width, height, text)
		local swing = CreateFrame("Frame", nil, self)
		swing.Twohand = CreateSwingStatusBar(swing, text)
		swing.Mainhand = CreateSwingStatusBar(swing, text)
		swing.Offhand = CreateSwingStatusBar(swing, text)
		swing.hideOoc = true
		swing:SetWidth(Z.Scale(width))
		swing:SetHeight(Z.Scale(height))
		return swing
	end
	
	function Z.SpawnMenu(self)
		local unit = self.unit:gsub("(.)", string.upper, 1)
		if self.unit == "targettarget" or unit == "focustarget" or unit == "pettarget" then return end
		if _G[unit.."FrameDropDown"] then
			ToggleDropDownMenu(1, nil, _G[unit.."FrameDropDown"], "cursor")
		elseif (self.unit:match("party")) then
			ToggleDropDownMenu(1, nil, _G["PartyMemberFrame"..self.id.."DropDown"], "cursor")
		else
			FriendsDropDown.unit = self.unit
			FriendsDropDown.id = self.id
			FriendsDropDown.initialize = RaidFrameDropDown_Initialize
			ToggleDropDownMenu(1, nil, FriendsDropDown, "cursor")
		end
	end

	local frameshown = true
	local unitlist = {}
	local function FadeFramesInOut(fade)
		for frames, unitlist in pairs(unitlist) do
			if not UnitExists(_G[unitlist].unit) then return end
			if fade == true then
				UIFrameFadeIn(_G[unitlist], 0.15)
			else
				UIFrameFadeOut(_G[unitlist], 0.15)
			end
		end
	end

	Z.Fader = function(self, arg1, arg2)	
		if arg1 == "UNIT_HEALTH" and self.unit ~= arg2 then return end
		
		local unit = self.unit
		if arg2 == true then self = self:GetParent() end
		if not unitlist[tostring(self:GetName())] then tinsert(unitlist, tostring(self:GetName())) end
		
		local cur = UnitHealth("player")
		local max = UnitHealthMax("player")
		
		if (UnitCastingInfo("player") or UnitChannelInfo("player")) and frameshown ~= true then
			FadeFramesInOut(true)
			frameshown = true	
		elseif cur ~= max and frameshown ~= true then
			FadeFramesInOut(true)
			frameshown = true	
		elseif (UnitExists("target") or UnitExists("focus")) and frameshown ~= true then
			FadeFramesInOut(true)
			frameshown = true	
		elseif arg1 == true and frameshown ~= true then
			FadeFramesInOut(true)
			frameshown = true
		else
			if InCombatLockdown() and frameshown ~= true then
				FadeFramesInOut(true)
				frameshown = true	
			elseif not UnitExists("target") and not InCombatLockdown() and not UnitExists("focus") and (cur == max) and not (UnitCastingInfo("player") or UnitChannelInfo("player")) then
				FadeFramesInOut(false)
				frameshown = false
			end
		end
	end

	Z.AuraFilter = function(icons, unit, icon, name, rank, texture, count, dtype, duration, timeLeft, caster, isStealable, shouldConsolidate, spellID)	
		local header = icon:GetParent():GetParent():GetParent():GetName()
		local inInstance, instanceType = IsInInstance()
		icon.owner = caster
		icon.isStealable = isStealable
		
		if (unit and unit:find("arena%d")) then --Arena frames
			if dtype then
				if Z.DebuffWhiteList[name] then
					return true
				else
					return false
				end			
			else
				if Z.ArenaBuffWhiteList[name] then
					return true
				else
					return false
				end		
			end
		elseif unit == "target" or (unit and unit:find("boss%d")) then --Target/Boss Only
			if C["unitframes"].playerdebuffsonly then
				-- Show all debuffs on friendly targets
				if UnitIsFriend("player", "target") then return true end
				
				local isPlayer
				
				if(caster == 'player' or caster == 'vehicle') then
					isPlayer = true
				else
					isPlayer = false
				end

				if isPlayer then
					return true
				elseif Z.DebuffWhiteList[name] or (inInstance and ((instanceType == "pvp" or instanceType == "arena") and Z.TargetPVPOnly[name])) then
					return true
				else
					return false
				end
			else
				return true
			end
		else --Everything else
			if unit ~= "player" and unit ~= "targettarget" and unit ~= "focus" and C["unitframes"].arenadebuffs and inInstance and (instanceType == "pvp" or instanceType == "arena") then
				if Z.DebuffWhiteList[name] or Z.TargetPVPOnly[name] then
					return true
				else
					return false
				end
			else
				if Z.DebuffBlacklist[name] then
					return false
				else
					return true
				end
			end
		end
	end

	Z.PostUpdateHealth = function(health, unit, min, max)
		local r, g, b = health:GetStatusBarColor()
		if C["general"].classcolortheme == true then
			health.backdrop:SetBackdropBorderColor(r, g, b)
			if health:GetParent().Portrait and health:GetParent().Portrait.backdrop then
				health:GetParent().Portrait.backdrop:SetBackdropBorderColor(r, g, b)
			end
		end
		
		if C["unitframes"].classcolor and C["unitframes"].healthcolorbyvalue and not (UnitIsTapped(unit) and not UnitIsTappedByPlayer(unit)) then
			local newr, newg, newb = oUF.ColorGradient(min / max, 1, 0, 0, 1, 1, 0, r, g, b)
	
			health:SetStatusBarColor(newr, newg, newb)
			if health.bg and health.bg.multiplier then
				local mu = health.bg.multiplier
				health.bg:SetVertexColor(newr * mu, newg * mu, newb * mu)
			end
		end
		
		if not health.value then return end
		
		local header = health:GetParent():GetParent():GetName()
		if header == "ZuiHealParty" or header == "ZuiDPSParty" or header == "ZuiHealR6R25" or header == "ZuiDPSR6R25" or header == "ZuiHealR26R40" or header == "ZuiDPSR26R40" then --Raid/Party Layouts
			if not UnitIsConnected(unit) or UnitIsDead(unit) or UnitIsGhost(unit) then
				if not UnitIsConnected(unit) then
					--health.value:SetText("|cffD7BEA5"..L.unitframes_ouf_offline.."|r")
          health.value:SetText("|cffD7BEA5Offline|r")
				elseif UnitIsDead(unit) then
					health.value:SetText("|cffD7BEA5Dead|r")
				elseif UnitIsGhost(unit) then
					health.value:SetText("|cffD7BEA5Ghost|r")
				end
			else
				if min ~= max and C["raidframes"].healthdeficit then
					health.value:SetText("|cff559655-"..Z.ShortValueNegative(max-min).."|r")
				else
					health.value:SetText("")
				end
			end
		else
			if not UnitIsConnected(unit) or UnitIsDead(unit) or UnitIsGhost(unit) then
				if not UnitIsConnected(unit) then
					--health.value:SetText("|cffD7BEA5"..L.unitframes_ouf_offline.."|r")
          health.value:SetText("|cffD7BEA5Offline|r")
				elseif UnitIsDead(unit) then
					--health.value:SetText("|cffD7BEA5"..L.unitframes_ouf_dead.."|r")
          health.value:SetText("|cffD7BEA5Dead|r")
				elseif UnitIsGhost(unit) then
					--health.value:SetText("|cffD7BEA5"..L.unitframes_ouf_ghost.."|r")
          health.value:SetText("|cffD7BEA5Ghost|r")
				end
			else
				if min ~= max then
					local r, g, b
					r, g, b = oUF.ColorGradient(min/max, 0.69, 0.31, 0.31, 0.65, 0.63, 0.35, 0.33, 0.59, 0.33)
					if unit == "player" and health:GetAttribute("normalUnit") ~= "pet" then
						if C["unitframes"].showtotalhpmp then
							health.value:SetFormattedText("|cff559655%s|r|cffD7BEA5|||r|cff559655%s|r", Z.ShortValue(min), Z.ShortValue(max))
						else
							health.value:SetFormattedText("|cffAF5050%s|r|cffD7BEA5-|r|cff%02x%02x%02x%d%%|r", Z.ShortValue(min), r * 255, g * 255, b * 255, floor(min / max * 100))
						end
					elseif unit == "target" or unit == "focus" or (unit and unit:find("boss%d")) then
						if C["unitframes"].showtotalhpmp then
							health.value:SetFormattedText("|cff559655%s|r|cffD7BEA5|||r|cff559655%s|r", Z.ShortValue(min), Z.ShortValue(max))
						else
							health.value:SetFormattedText("|cffAF5050%s|r|cffD7BEA5-|r|cff%02x%02x%02x%d%%|r", Z.ShortValue(min), r * 255, g * 255, b * 255, floor(min / max * 100))
						end
					elseif (unit and unit:find("arena%d")) then
						health.value:SetText("|cff559655"..Z.ShortValue(min).."|r")
					else
						health.value:SetFormattedText("|cffAF5050%s|r|cffD7BEA5-|r|cff%02x%02x%02x%d%%|r", Z.ShortValue(min), r * 255, g * 255, b * 255, floor(min / max * 100))
					end
				else
					if unit == "player" and health:GetAttribute("normalUnit") ~= "pet" then
						health.value:SetText("|cff559655"..Z.ShortValue(max).."|r")
					elseif unit == "target" or unit == "focus" or (unit and unit:find("arena%d")) then
						health.value:SetText("|cff559655"..Z.ShortValue(max).."|r")
					else
						health.value:SetText("|cff559655"..Z.ShortValue(max).."|r")
					end
				end
			end
		end
	end

	Z.PostNamePosition = function(self)
		self.Name:ClearAllPoints()
		if (self.Power.value:GetText() and UnitIsPlayer("target") and C["unitframes"].targetpowerplayeronly == true) or (self.Power.value:GetText() and C["unitframes"].targetpowerplayeronly == false) then
			self.Power.value:SetAlpha(1)
			self.Name:SetPoint("CENTER", self.Health, "CENTER")
		else
			self.Power.value:SetAlpha(0)
			self.Name:SetPoint("LEFT", self.Health, "LEFT", 4, 0)
		end
	end

	Z.PostUpdatePower = function(power, unit, min, max)
		local self = power:GetParent()
		local pType, pToken, altR, altG, altB = UnitPowerType(unit)
		local color = Z.oUF_colors.power[pToken]
		if C["general"].classcolortheme == true then
			power.backdrop:SetBackdropBorderColor(power:GetParent().Health.backdrop:GetBackdropBorderColor())
		end
		
		if not power.value then return end		
	
		if color then
			power.value:SetTextColor(color[1], color[2], color[3])
		else
			power.value:SetTextColor(altR, altG, altB, 1)
		end	
			
		if min == 0 then 
			power.value:SetText() 
		else
			if (not UnitIsPlayer(unit) and not UnitPlayerControlled(unit) or not UnitIsConnected(unit)) and not (unit and unit:find("boss%d")) then
				power.value:SetText()
			elseif UnitIsDead(unit) or UnitIsGhost(unit) then
				power.value:SetText()
			else
				if min ~= max then
					if pType == 0 then
						if unit == "target" then
							if C["unitframes"].showtotalhpmp then
								power.value:SetFormattedText("%s|cffD7BEA5|||r%s", Z.ShortValue(max - (max - min)), Z.ShortValue(max))
							else
								power.value:SetFormattedText("%d%%|cffD7BEA5-|r%s", floor(min / max * 100), Z.ShortValue(max - (max - min)))
							end
						elseif unit == "player" and self:GetAttribute("normalUnit") == "pet" or unit == "pet" then
							if C["unitframes"].showtotalhpmp then
								power.value:SetFormattedText("%s|cffD7BEA5|||r%s", Z.ShortValue(max - (max - min)), Z.ShortValue(max))
							else
								power.value:SetFormattedText("%d%%", floor(min / max * 100))
							end
						elseif (unit and unit:find("arena%d")) then
							power.value:SetText(Z.ShortValue(min))
						elseif (unit and unit:find("boss%d")) then
							power.value:SetFormattedText("%d%%", floor(min / max * 100))					
						else
							if C["unitframes"].showtotalhpmp then
								power.value:SetFormattedText("%s|cffD7BEA5|||r%s", Z.ShortValue(max - (max - min)), Z.ShortValue(max))
							else
								power.value:SetFormattedText("%d%%|cffD7BEA5-|r%s", floor(min / max * 100), Z.ShortValue(max - (max - min)))
							end
						end
					else
						power.value:SetText(max - (max - min))
					end
				else
					if unit == "pet" or unit == "target" or (unit and unit:find("arena%d")) then
						power.value:SetText(Z.ShortValue(min))
					else
						power.value:SetText(Z.ShortValue(min))
					end
				end
			end
		end
		
		if self.Name and unit == "target"  then
			Z.PostNamePosition(self)
		end
	end
	
	local delay = 0
	Z.UpdateManaLevel = function(self, elapsed)
		delay = delay + elapsed
		if self.unit ~= "player" or delay < 0.2 or UnitIsDeadOrGhost("player") or UnitPowerType("player") ~= 0 then return end
		delay = 0

		local percMana = UnitMana("player") / UnitManaMax("player") * 100

		if percMana <= 20 then
			self.ManaLevel:SetText("|cffaf5050"..L.unitframes_ouf_lowmana.."|r")
			Z.Flash(self.ManaLevel, 0.3)
		else
			self.ManaLevel:SetText()
			Z.StopFlash(self.ManaLevel)
		end
	end
	
	Z.MLAnchorUpdate = function(self)
		if self.Leader:IsShown() then
			self.MasterLooter:Point("TOPRIGHT", -18, 9)
		else
			self.MasterLooter:Point("TOPRIGHT", -4, 9)
		end
	end
  
	if Z.isctm then
    Z.UpdateShards = function(self, event, unit, powerType)
      if(self.unit ~= unit or (powerType and powerType ~= 'SOUL_SHARDS')) then return end
      local num = UnitPower(unit, SPELL_POWER_SOUL_SHARDS)
      for i = 1, SHARD_BAR_NUM_SHARDS do
        if(i <= num) then
          self.SoulShards[i]:SetAlpha(1)
        else
          self.SoulShards[i]:SetAlpha(.2)
        end
      end
    end

    Z.UpdateHoly = function(self, event, unit, powerType)
      if(self.unit ~= unit or (powerType and powerType ~= 'HOLY_POWER')) then return end
      local num = UnitPower(unit, SPELL_POWER_HOLY_POWER)
      for i = 1, MAX_HOLY_POWER do
        if(i <= num) then
          self.HolyPower[i]:SetAlpha(1)
        else
          self.HolyPower[i]:SetAlpha(.2)
        end
      end
    end	
	
    Z.EclipseDirection = function(self)
      if ( GetEclipseDirection() == "sun" ) then
        self.Text:SetText(">")
        self.Text:SetTextColor(.2,.2,1,1)
      elseif ( GetEclipseDirection() == "moon" ) then
        self.Text:SetText("<")
        self.Text:SetTextColor(1,1,.3, 1)
      else
        self.Text:SetText("")
      end
    end
  end

	Z.CustomCastTimeText = function(self, duration)
		self.Time:SetText(("%.1f/%.1f"):format(self.channeling and duration or self.max - duration, self.max))
	end

	Z.CustomCastDelayText = function(self, duration)
		self.Time:SetText(("%.1f|cffaf5050%s%.1f|r"):format(self.channeling and duration or self.max - duration, self.channeling and "- " or "+", self.delay))
	end

	local FormatTime = function(s, reverse)
		local day, hour, minute, second = 86400, 3600, 60, 1
		if s >= day then
			return format("%dd", ceil(s / hour))
		elseif s >= hour then
			return format("%dh", ceil(s / hour))
		elseif s >= minute then
			return format("%dm", ceil(s / minute))
		elseif s >= minute / 12 then
			return floor(s)
		end
		
		if reverse and reverse == true and s >= second then
			return floor(s)
		else	
			return format("%.1f", s)
		end
	end
	
	local abs = math.abs --faster
	local CreateAuraTimer = function(self, elapsed)	
		if self.timeLeft then
			self.elapsed = (self.elapsed or 0) + elapsed
			if self.elapsed >= 0.1 then
				if not self.first then
					self.timeLeft = self.timeLeft - self.elapsed
				else
					self.timeLeft = self.timeLeft - GetTime()
					self.first = false
				end
				if self.timeLeft > 0 then
					local time = FormatTime(self.timeLeft)
					if self.reverse then time = FormatTime(abs(self.timeLeft - self.duration), true) end
					self.text:SetText(time)
					if self.timeLeft <= 5 then
						self.text:SetTextColor(0.99, 0.31, 0.31)
					else
						self.text:SetTextColor(1, 1, 1)
					end
				else
					self.text:Hide()
					self:SetScript("OnUpdate", nil)
				end
				if (not self.debuff) and C["unitframes"].classcolortheme then
					local r, g, b = self:GetParent():GetParent().Health.backdrop:GetBackdropBorderColor()
					self:SetBackdropBorderColor(r, g, b)
				end
				self.elapsed = 0
			end
		end
	end

	function Z.PvPUpdate(self, elapsed)
		if(self.elapsed and self.elapsed > 0.2) then
			local unit = self.unit
			local time = GetPVPTimer()

			local min = format("%01.f", floor((time/1000)/60))
			local sec = format("%02.f", floor((time/1000) - min *60)) 
			if(self.PvP) then
				if(UnitIsPVPFreeForAll(unit)) then
					if time ~= 301000 and time ~= -1 then
						self.PvP:SetText(PVP.."("..min..":"..sec..")")
					else
						self.PvP:SetText(PVP)
					end
				elseif UnitIsPVP(unit) then
					if time ~= 301000 and time ~= -1 then
						self.PvP:SetText(PVP.."("..min..":"..sec..")")
					else
						self.PvP:SetText(PVP)
					end
				else
					self.PvP:SetText("")
				end
			end
			self.elapsed = 0
		else
			self.elapsed = (self.elapsed or 0) + elapsed
		end
	end

	function Z.PostCreateAura(element, button)
		local unit = button:GetParent():GetParent().unit
		local header = button:GetParent():GetParent():GetParent():GetName()
		
		if unit == "focus" or unit == "targettarget" or header == "ZuiHealParty" then
			button:FontString(nil, C["media"].pxfont, 12*.85, "OUTLINEMONOCHROME")
		else
			button:FontString(nil, C["media"].pxfont, 12, "OUTLINEMONOCHROME")
		end
		
		button:SetTemplate("Default")
		button.text:SetPoint("CENTER", Z.Scale(0), Z.mult)
		button.cd.noOCC = true		 	-- hide OmniCC CDs
		button.cd.noCooldownCount = true	-- hide CDC CDs
		
		button.cd:SetReverse()
		button.icon:Point("TOPLEFT", Z.Scale(2), Z.Scale(-2))
		button.icon:Point("BOTTOMRIGHT", Z.Scale(-2), Z.Scale(2))
		button.icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
		button.icon:SetDrawLayer('ARTWORK')
		
		button.count:Point("BOTTOMRIGHT", Z.mult, 1.5)
		button.count:SetJustifyH("RIGHT")
		button.count:SetFont(C["media"].pxfont, 12, "OUTLINEMONOCHROME")

		button.overlayFrame = CreateFrame("frame", nil, button, nil)
		button.cd:SetFrameLevel(button:GetFrameLevel() + 1)
		button.cd:ClearAllPoints()
		button.cd:Point("TOPLEFT", button, "TOPLEFT", Z.Scale(2), Z.Scale(-2))
		button.cd:Point("BOTTOMRIGHT", button, "BOTTOMRIGHT", Z.Scale(-2), Z.Scale(2))
		button.overlayFrame:SetFrameLevel(button.cd:GetFrameLevel() + 2)	   
		button.overlay:SetParent(button.overlayFrame)
		button.count:SetParent(button.overlayFrame)
		button.text:SetParent(button.overlayFrame)
		
		local highlight = button:CreateTexture(nil, "HIGHLIGHT")
		highlight:SetTexture(1,1,1,0.45)
		highlight:SetAllPoints(button.icon)	
	end

	function Z.PostUpdateAura(icons, unit, icon, index, offset, filter, isDebuff, duration, timeLeft)
		local name, _, _, _, dtype, duration, expirationTime, unitCaster, _, _, spellID = UnitAura(unit, index, icon.filter)
		
		if(icon.debuff) then
			if(not UnitIsFriend("player", unit) and icon.owner ~= "player" and icon.owner ~= "vehicle") and (not Z.DebuffWhiteList[name]) then
				icon:SetBackdropBorderColor(unpack(C["media"].bordercolor))
				icon.icon:SetDesaturated(true)
			else
				local color = DebuffTypeColor[dtype] or DebuffTypeColor.none
				if (name == "Unstable Affliction" or name == "Vampiric Touch") and Z.myclass ~= "WARLOCK" then
					icon:SetBackdropBorderColor(0.05, 0.85, 0.94)
				else
					icon:SetBackdropBorderColor(color.r * 0.6, color.g * 0.6, color.b * 0.6)
				end
				icon.icon:SetDesaturated(false)
			end
		else
			if (icon.isStealable or ((Z.myclass == "PRIEST" or Z.myclass == "SHAMAN") and dtype == "Magic")) and not UnitIsFriend("player", unit) then
				icon:SetBackdropBorderColor(237/255, 234/255, 142/255)
			else
        icon:SetBackdropBorderColor(unpack(C["media"].bordercolor))		
			end
		end
		
		if duration and duration > 0 then
			if C["unitframes"].auratimer then
				icon.text:Show()
			else
				icon.text:Hide()
			end
		else
			icon.text:Hide()
		end
		
		icon.duration = duration
		icon.timeLeft = expirationTime
		icon.first = true
		
		
		if Z.ReverseTimerSpells and Z.ReverseTimerSpells[spellID] then icon.reverse = true end
		icon:SetScript("OnUpdate", CreateAuraTimer)
	end

	Z.PostCastStart = function(self, unit, name, rank, castid)
		if unit == "vehicle" then unit = "player" end
		--Fix blank castbar with opening text
		if name == "Opening" then
			self.Text:SetText(OPENING)
		else
			self.Text:SetText(string.sub(name, 0, math.floor((((32/245) * self:GetWidth()) / C["unitframes"].fontsize) * 12)))
		end
		
		if self.interrupt and unit ~= "player" then
			if UnitCanAttack("player", unit) then
				self:SetStatusBarColor(unpack(C["unitframes"].nointerruptcolor))
			else
				self:SetStatusBarColor(unpack(C["unitframes"].castbarcolor))	
			end
		else
      self:SetStatusBarColor(unpack(C["unitframes"].castbarcolor))
		end
	end

	Z.ComboDisplay = function(self, event, unit)
		if(unit == 'pet') then return end
		
		local cpoints = self.CPoints
		local cp
		if (UnitHasVehicleUI("player") or UnitHasVehicleUI("vehicle")) then
			cp = GetComboPoints('vehicle', 'target')
		else
			cp = GetComboPoints('player', 'target')
		end

		for i=1, MAX_COMBO_POINTS do
			if(i <= cp) then
				cpoints[i]:SetAlpha(1)
			else
				cpoints[i]:SetAlpha(0.15)
			end
		end
		
		if cpoints[1]:GetAlpha() == 1 then
			cpoints:Show()
		else
			cpoints:Hide()
		end
	end

	Z.RestingIconUpdate = function (self)
		if IsResting() then
			self.Resting:Show()
		else
			self.Resting:Hide()
		end
	end

	Z.UpdateDruidMana = function(self)
		if self.unit ~= "player" then return end

		local num, str = UnitPowerType("player")
		if num ~= 0 then
			local min = UnitPower("player", 0)
			local max = UnitPowerMax("player", 0)

			local percMana = min / max * 100
			if percMana <= C["unitframes"].lowThreshold then
				self.ManaLevel:SetText("|cffaf5050"..L.unitframes_ouf_lowmana.."|r")
				Z.Flash(self.ManaLevel, 0.3)
			else
				self.ManaLevel:SetText()
				Z.StopFlash(self.ManaLevel)
			end

			if min ~= max then
				if self.Power.value:GetText() then
					self.DruidMana:SetPoint("LEFT", self.Power.value, "RIGHT", -3, 0)
					self.DruidMana:SetFormattedText("|cffD7BEA5-|r%d%%|r", floor(min / max * 100))
				else
					self.DruidMana:SetPoint("LEFT", self.Health, "LEFT", 4, 1)
					self.DruidMana:SetFormattedText("%d%%", floor(min / max * 100))
				end
			else
				self.DruidMana:SetText()
			end

			self.DruidMana:SetAlpha(1)
		else
			self.DruidMana:SetAlpha(0)
		end
	end

	function Z.UpdateThreat(self, event, unit)
		if (self.unit ~= unit) or not unit then return end
		
		local threat = UnitThreatSituation(unit)
		if threat and threat > 1 then
			local r, g, b = GetThreatStatusColor(threat)			
			if self.shadow then
				self.shadow:SetBackdropBorderColor(r, g, b)
			elseif self.Health.backdrop then
				self.Health.backdrop:SetBackdropBorderColor(r, g, b)
				
				if self.Power and self.Power.backdrop then
					self.Power.backdrop:SetBackdropBorderColor(r, g, b)
				end
			end
		else		
			if self.shadow then
				self.shadow:SetBackdropBorderColor(0, 0, 0, 0)
			elseif self.Health.backdrop then
				self.Health.backdrop:SetTemplate("Default")
				
				if self.Power and self.Power.backdrop then
					self.Power.backdrop:SetTemplate("Default")
				end
			end
		end 
	end
  
  if Z.isctm then
    function Z.AltPowerBarOnToggle(self)
      local unit = self:GetParent().unit or self:GetParent():GetParent().unit
      
      if unit == nil or unit ~= "player" then return end
      
      if self:IsShown() then
        --for _, text in pairs(Z.LeftDatatexts) do text:Hide() end
        local type = select(10, UnitAlternatePowerInfo(unit))
        if self.text and type then self.text:SetText(type..": 0%") end
      else
        --for _, text in pairs(Z.LeftDatatexts) do text:Show() end		
      end
    end
	
    function Z.AltPowerBarPostUpdate(self, min, cur, max)
      local perc = math.floor((cur/max)*100)
      
      if perc < 35 then
        self:SetStatusBarColor(0, 1, 0)
      elseif perc < 70 then
        self:SetStatusBarColor(1, 1, 0)
      else
        self:SetStatusBarColor(1, 0, 0)
      end
      
      local unit = self:GetParent().unit or self:GetParent():GetParent().unit
      
      if unit == "player" and self.text then 
        local type = select(10, UnitAlternatePowerInfo(unit))
            
        if perc > 0 then
          self.text:SetText(type..":"..format("%d%%", perc))
        else
          self.text:SetText(type..":0%")
        end
      elseif unit and unit:find("boss%d") and self.text then
        self.text:SetTextColor(self:GetStatusBarColor())
        if not self:GetParent().Power.value:GetText() or self:GetParent().Power.value:GetText() == "" then
          self.text:Point("BOTTOMRIGHT", self:GetParent().Health, "BOTTOMRIGHT")
        else
          self.text:Point("RIGHT", self:GetParent().Power.value.value, "LEFT", 2, Z.mult)	
        end
        if perc > 0 then
          self.text:SetText("|cffD7BEA5[|r"..format("%d%%", perc).."|cffD7BEA5]|r")
        else
          self.text:SetText(nil)
        end
      end
    end
  end


	--------------------------------------------------------------------------------------------
	-- THE AURAWATCH FUNCTION ITSELF. HERE BE DRAGONS!
	--------------------------------------------------------------------------------------------

	Z.countOffsets = {
		TOPLEFT = {6, 1},
		TOPRIGHT = {-6, 1},
		BOTTOMLEFT = {6, 1},
		BOTTOMRIGHT = {-6, 1},
		LEFT = {6, 1},
		RIGHT = {-6, 1},
		TOP = {0, 0},
		BOTTOM = {0, 0},
	}

	function Z.CreateAuraWatchIcon(self, icon)
		if (icon.cd) then
			icon.cd:SetReverse()
		end 	
	end

	function Z.createAuraWatch(self, unit)
		local auras = CreateFrame("Frame", nil, self)
		auras:SetPoint("TOPLEFT", self.Health, 2, -2)
		auras:SetPoint("BOTTOMRIGHT", self.Health, -2, 2)
		auras.presentAlpha = 1
		auras.missingAlpha = 0
		auras.icons = {}
		auras.PostCreateIcon = Z.CreateAuraWatchIcon

		if (not C["unitframes"].auratimer) then
			auras.hideCooldown = true
		end

		local buffs = {}
		if IsAddOnLoaded("zui_dps") then
			if (Z.DPSBuffIDs["ALL"]) then
				for key, value in pairs(Z.DPSBuffIDs["ALL"]) do
					tinsert(buffs, value)
				end
			end

			if (Z.DPSBuffIDs[Z.myclass]) then
				for key, value in pairs(Z.DPSBuffIDs[Z.myclass]) do
					tinsert(buffs, value)
				end
			end	
		else
			if (Z.HealerBuffIDs["ALL"]) then
				for key, value in pairs(Z.HealerBuffIDs["ALL"]) do
					tinsert(buffs, value)
				end
			end

			if (Z.HealerBuffIDs[Z.myclass]) then
				for key, value in pairs(Z.HealerBuffIDs[Z.myclass]) do
					tinsert(buffs, value)
				end
			end
		end
		
		if Z.PetBuffs[Z.myclass] then
			for key, value in pairs(Z.PetBuffs[Z.myclass]) do
				tinsert(buffs, value)
			end
		end

		-- "Cornerbuffs"
		if (buffs) then
			for key, spell in pairs(buffs) do
				local icon = CreateFrame("Frame", nil, auras)
				icon.spellID = spell[1]
				icon.anyUnit = spell[4]
				icon:SetWidth(Z.Scale(C["raidframes"].buffindicatorsize))
				icon:SetHeight(Z.Scale(C["raidframes"].buffindicatorsize))
				icon:SetPoint(spell[2], 0, 0)

				local tex = icon:CreateTexture(nil, "OVERLAY")
				tex:SetAllPoints(icon)
				tex:SetTexture(C["media"].blank)
				if (spell[3]) then
					tex:SetVertexColor(unpack(spell[3]))
				else
					tex:SetVertexColor(0.8, 0.8, 0.8)
				end
				
				local border = icon:CreateTexture(nil, "ARTWORK")
				border:Point("TOPLEFT", -Z.mult, Z.mult)
				border:Point("BOTTOMRIGHT", Z.mult, -Z.mult)
				border:SetTexture(C["media"].blank)
				border:SetVertexColor(0, 0, 0)

				local count = icon:CreateFontString(nil, "OVERLAY")
				count:SetFont(C["media"].pxfont, 12, "OUTLINEMONOCHROME")
				count:SetPoint("CENTER", unpack(Z.countOffsets[spell[2]]))
				icon.count = count

				auras.icons[spell[1]] = icon
			end
		end

		self.AuraWatch = auras
	end

do
	local ORD = ns.oUF_RaidDebuffs or oUF_RaidDebuffs

	if not ORD then return end
	ORD.ShowDispelableDebuff = true
	ORD.FilterDispellableDebuff = true
	ORD.MatchBySpellName = true

	ORD:RegisterDebuffs(Z.RaidDebuffs)	
	
	--Z.LoadUnitFrame = nil
end
