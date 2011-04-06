
local Z, C, L = unpack(select(2, ...)) -- Import Functions/Constants, Config, Locales

if C["others"].raidbuffreminder ~= true then return end

--Locals
local flaskbuffs = Z.BuffReminderRaidBuffs["Flask"]
local battleelixirbuffs = Z.BuffReminderRaidBuffs["BattleElixir"]
local guardianelixirbuffs = Z.BuffReminderRaidBuffs["GuardianElixir"]
local foodbuffs = Z.BuffReminderRaidBuffs["Food"]	
local battleelixired	
local guardianelixired	

--Setup Caster Buffs
local function SetCasterOnlyBuffs()
	Spell3Buff = { --Total Stats
		1126, -- "Mark of the wild"
		--90363, --"Embrace of the Shale Spider"
		20217, --"Greater Blessing of Kings",
	}
	Spell4Buff = { --Total Stamina
		469, -- Commanding
		6307, -- Blood Pact
		--90364, -- Qiraji Fortitude
		--72590, -- Drums of fortitude
		21562, -- Fortitude
	}
	Spell5Buff = { --Total Mana
		--61316, --"Dalaran Brilliance"
		1459, --"Arcane Brilliance"
	}
	Spell6Buff = { --Mana Regen
		5675, --"Mana Spring Totem"
		19740, --"Blessing of Might"
	}
end

--Setup everyone else's buffs
local function SetBuffs()
	Spell3Buff = { --Total Stats
		1126, -- "Mark of the wild"
		--90363, --"Embrace of the Shale Spider"
		20217, --"Greater Blessing of Kings",
	}
	Spell4Buff = { --Total Stamina
		469, -- Commanding
		6307, -- Blood Pact
		--90364, -- Qiraji Fortitude
		--72590, -- Drums of fortitude
		21562, -- Fortitude
	}
	Spell5Buff = { --Total Mana
		--61316, --"Dalaran Brilliance"
		1459, --"Arcane Brilliance"
	}
	Spell6Buff = { --Total AP
		19740, --"Blessing of Might" placing it twice because i like the icon better :D code will stop after this one is read, we want this first 
		30808, --"Unleashed Rage"
		--53138, --Abom Might
		19506, --Trushot
		19740, --"Blessing of Might"
	}
end


-- we need to check if you have two differant elixirs if your not flasked, before we say your not flasked
local function CheckElixir(unit)
	if (battleelixirbuffs and battleelixirbuffs[1]) then
		for i, battleelixirbuffs in pairs(battleelixirbuffs) do
			local spellname = select(1, GetSpellInfo(battleelixirbuffs))
			if UnitAura("player", spellname) then
				FlaskFrame.t:SetTexture(select(3, GetSpellInfo(battleelixirbuffs)))
				battleelixired = true
				break
			else
				battleelixired = false
			end
		end
	end
	
	if (guardianelixirbuffs and guardianelixirbuffs[1]) then
		for i, guardianelixirbuffs in pairs(guardianelixirbuffs) do
			local spellname = select(1, GetSpellInfo(guardianelixirbuffs))
			if UnitAura("player", spellname) then
				guardianelixired = true
				if not battleelixired then
					FlaskFrame.t:SetTexture(select(3, GetSpellInfo(guardianelixirbuffs)))
				end
				break
			else
				guardianelixired = false
			end
		end
	end	
	
	if guardianelixired == true and battleelixired == true then
		FlaskFrame:SetAlpha(0.2)
		return
	else
		FlaskFrame:SetAlpha(1)
	end
end

local function Pulse(self)
	Z.Flash(self, 0.3)
end


--Main Script
RaidReminderShown = true
local function OnAuraChange(self, event, arg1, unit)
	if (event == "UNIT_AURA" and arg1 ~= "player") then 
		return
	end
	
	if event == "PLAYER_ENTERING_WORLD" then
		reminderoverride = false
	end
	
	--If We're a caster we may want to see differant buffs
	--if Z.Role == "Caster" then 
	--	SetCasterOnlyBuffs() 
	--else
		SetBuffs()
	--end
	
	--Start checking buffs to see if we can find a match from the list
	if (flaskbuffs and flaskbuffs[1]) then
		FlaskFrame.t:SetTexture(select(3, GetSpellInfo(flaskbuffs[1])))
		for i, flaskbuffs in pairs(flaskbuffs) do
			local spellname = select(1, GetSpellInfo(flaskbuffs))
			if UnitAura("player", spellname) then
				FlaskFrame.t:SetTexture(select(3, GetSpellInfo(flaskbuffs)))
				FlaskFrame:SetAlpha(0.2)
				break
			else
				CheckElixir()
			end
		end
	end
	
	if (foodbuffs and foodbuffs[1]) then
		FoodFrame.t:SetTexture(select(3, GetSpellInfo(foodbuffs[1])))
		for i, foodbuffs in pairs(foodbuffs) do
			local spellname = select(1, GetSpellInfo(foodbuffs))
			if UnitAura("player", spellname) then
				FoodFrame:SetAlpha(0.2)
				FoodFrame.t:SetTexture(select(3, GetSpellInfo(foodbuffs)))
				break
			else
				FoodFrame:SetAlpha(1)
			end
		end
	end
	
	for i, Spell3Buff in pairs(Spell3Buff) do
		local spellname = select(1, GetSpellInfo(Spell3Buff))
		if UnitAura("player", spellname) then
			Spell3Frame:SetAlpha(0.2)
			Spell3Frame.t:SetTexture(select(3, GetSpellInfo(Spell3Buff)))
			break
		else
			Spell3Frame:SetAlpha(1)
			Spell3Frame.t:SetTexture(select(3, GetSpellInfo(Spell3Buff)))
		end
	end
	
	for i, Spell4Buff in pairs(Spell4Buff) do
		local spellname = select(1, GetSpellInfo(Spell4Buff))
		if UnitAura("player", spellname) then
			Spell4Frame:SetAlpha(0.2)
			Spell4Frame.t:SetTexture(select(3, GetSpellInfo(Spell4Buff)))
			break
		else
			Spell4Frame:SetAlpha(1)
			Spell4Frame.t:SetTexture(select(3, GetSpellInfo(Spell4Buff)))
		end
	end
	
	for i, Spell5Buff in pairs(Spell5Buff) do
		local spellname = select(1, GetSpellInfo(Spell5Buff))
		if UnitAura("player", spellname) then
			Spell5Frame:SetAlpha(0.2)
			Spell5Frame.t:SetTexture(select(3, GetSpellInfo(Spell5Buff)))
			break
		else
			Spell5Frame:SetAlpha(1)
			Spell5Frame.t:SetTexture(select(3, GetSpellInfo(Spell5Buff)))
		end
	end	

	for i, Spell6Buff in pairs(Spell6Buff) do
		local spellname = select(1, GetSpellInfo(Spell6Buff))
		if UnitAura("player", spellname) then
			Spell6Frame:SetAlpha(0.2)
			Spell6Frame.t:SetTexture(select(3, GetSpellInfo(Spell6Buff)))
			break
		else
			Spell6Frame:SetAlpha(1)
			Spell6Frame.t:SetTexture(select(3, GetSpellInfo(Spell6Buff)))
		end
	end
	
	
	local inInstance, instanceType = IsInInstance()
	if inInstance and (instanceType ==  "party" or instanceType == "raid" or instanceType == "pvp" or instanceType == "arena") then
		if RaidReminderShown ~= true and reminderoverride ~= true then
			UIFrameFadeIn(self, 0.4)
			ZuiCubeRight.text:SetTextColor(1,1,1)
			RaidReminderShown = true
		end
	else
		if RaidReminderShown ~= false and reminderoverride ~= true then
			ZuiCubeRight.text:SetTextColor(unpack(C["media"].valuecolor))
			UIFrameFadeOut(self, 0.4)
			RaidReminderShown = false
		end
	end
	
	--Check if your incombat and are missing a buff
	if RaidReminderShown == true and inInstance and (instanceType == "raid") and InCombatLockdown() and (FlaskFrame:GetAlpha() == 1 or Spell3Frame:GetAlpha() == 1 or Spell4Frame:GetAlpha() == 1 or Spell5Frame:GetAlpha() == 1 or Spell6Frame:GetAlpha() == 1) then
		self:SetScript("OnUpdate", function(self)
			if reminderoverride == true then return end
			Pulse(self)
		end)
	else
		self:SetScript("OnUpdate", function() end)
		Z.StopFlash(self)
	end
	
	
end

local bsize = ((144- (Z.Scale(4) * 7)) / 6)

--Create the Main bar
local raidbuff_reminder = CreateFrame("Frame", "RaidBuffReminder", ZuiMinimap)
raidbuff_reminder:CreatePanel("Default", 144, bsize + Z.Scale(8), "TOPLEFT", ZuiMinimap, "BOTTOMLEFT", 0, Z.Scale(-3))
raidbuff_reminder:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
raidbuff_reminder:RegisterEvent("UNIT_INVENTORY_CHANGED")
raidbuff_reminder:RegisterEvent("UNIT_AURA")
raidbuff_reminder:RegisterEvent("PLAYER_REGEN_ENABLED")
raidbuff_reminder:RegisterEvent("PLAYER_REGEN_DISABLED")
raidbuff_reminder:RegisterEvent("PLAYER_ENTERING_WORLD")
raidbuff_reminder:RegisterEvent("UPDATE_BONUS_ACTIONBAR")
raidbuff_reminder:RegisterEvent("CHARACTER_POINTS_CHANGED")
raidbuff_reminder:RegisterEvent("ZONE_CHANGED_NEW_AREA")
raidbuff_reminder:SetScript("OnEvent", OnAuraChange)
Z.SetUpAnimGroup(RaidBuffReminder)



--Function to create buttons
local function CreateButton(name, relativeTo, firstbutton)
	local button = CreateFrame("Frame", name, RaidBuffReminder)
	if firstbutton == true then
		button:CreatePanel("Default", bsize, bsize, "LEFT", relativeTo, "LEFT", Z.Scale(4), 0)
	else
		button:CreatePanel("Default", bsize, bsize, "LEFT", relativeTo, "RIGHT", Z.Scale(4), 0)
	end
	button:SetFrameLevel(RaidBuffReminder:GetFrameLevel() + 2)
	button:SetBackdropBorderColor(0,0,0,0)
	if C["general"].sharpborders == true then
		button.iborder:SetBackdropBorderColor(0, 0, 0, 0)
		button.oborder:SetBackdropBorderColor(0, 0, 0, 0)
	end
	
	button.FrameBackdrop = CreateFrame("Frame", nil, button)
	button.FrameBackdrop:SetTemplate("Default")
	
	if C["general"].sharpborders == true then
		button.FrameBackdrop.iborder:SetBackdropBorderColor(0, 0, 0, 0)
		button.FrameBackdrop.oborder:SetBackdropBorderColor(0, 0, 0, 0)
	end
	
	button.FrameBackdrop:SetPoint("TOPLEFT", Z.Scale(-2), Z.Scale(2))
	button.FrameBackdrop:SetPoint("BOTTOMRIGHT", Z.Scale(2), Z.Scale(-2))
	button.FrameBackdrop:SetFrameLevel(button:GetFrameLevel() - 1)	
	button.t = button:CreateTexture(name..".t", "OVERLAY")
	button.t:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	button.t:SetAllPoints(button)
end

--Create Buttons
do
	CreateButton("FlaskFrame", RaidBuffReminder, true)
	CreateButton("FoodFrame", FlaskFrame, false)
	CreateButton("Spell3Frame", FoodFrame, false)
	CreateButton("Spell4Frame", Spell3Frame, false)
	CreateButton("Spell5Frame", Spell4Frame, false)
	CreateButton("Spell6Frame", Spell5Frame, false)
end

--Setup toggle button
do
	--Toggle lock button
	ZuiCubeRight.hovered = false
	ZuiCubeRight:SetScript("OnMouseDown", function(self, btn)
		if btn == "RightButton" then
      if ZuiCubeRight.hovered == true then
        GameTooltip:ClearLines()
        if RaidReminderShown == true then
          GameTooltip:AddDoubleLine(L.raidbufftoggler, SHOW,1,1,1,unpack(C["media"].valuecolor))
          ElvuiInfoRightLButton.text:SetTextColor(unpack(C["media"].valuecolor))
          UIFrameFadeOut(RaidBuffReminder, 0.4)
          RaidReminderShown = false
          reminderoverride = true
        else
          GameTooltip:AddDoubleLine(L.raidbufftoggler, HIDE,1,1,1,unpack(C["media"].valuecolor))
          ZuiCubeRight.text:SetTextColor(1,1,1)
          UIFrameFadeIn(RaidBuffReminder, 0.4)
          RaidReminderShown = true
          reminderoverride = true
        end
      end
    end
	end)
		
	ZuiCubeRight:SetScript("OnEnter", function(self)
		ZuiCubeRight.hovered = true
		if InCombatLockdown() then return end
		GameTooltip:SetOwner(self, "ANCHOR_TOP", 0, Z.Scale(6));
		GameTooltip:ClearAllPoints()
		GameTooltip:SetPoint("BOTTOM", self, "TOP", 0, Z.mult)
		GameTooltip:ClearLines()
		
		if RaidReminderShown == true then
			GameTooltip:AddDoubleLine(L.raidbufftoggler, HIDE,1,1,1,unpack(C["media"].valuecolor))
		else
			GameTooltip:AddDoubleLine(L.raidbufftoggler, SHOW,1,1,1,unpack(C["media"].valuecolor))
		end
		GameTooltip:Show()
	end)
	
	ZuiCubeRight:SetScript("OnLeave", function(self)
		ZuiCubeRight.hovered = false
		GameTooltip:Hide()
	end)
end
