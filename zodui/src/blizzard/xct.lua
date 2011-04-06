--[[

xCT by affli @ RU-Howling Fjord
All rights reserved.
Thanks ALZA and Shestak for making this mod possible. Thanks Tukz for his wonderful style of coding. Thanks Rostok for some fixes and healing code.

]]--

local Z, C, L = unpack(select(2, ...)) -- Import: Z - functions, constants, variables; C - config; L - locales
--some init

if not C.xct.enable then return end

local ct = {}
ct=C.xct
ct.myname = Z.myname
ct.myclass=Z.myclass
ct.font = C.media.dmgfont
ct.damagefont = C.media.numfont
---------------------------------------------------------------------------------
-- outgoing healing filter, hide this spammy shit, plx
if(ct.healing)then
	ct.healfilter={}
	-- See class-specific config for filtered spells.
end
---------------------------------------------------------------------------------
if(ct.mergeaoespam)then
	ct.aoespam={}
	-- See class-specific config for merged spells.
end
---------------------------------------------------------------------------------
-- class config, overrides general
if ct.myclass=="WARLOCK" then
	if(ct.mergeaoespam)then
		ct.aoespam[27243]=true		-- Seed of Corruption (DoT)
		ct.aoespam[27285]=true		-- Seed of Corruption (Explosion)
		ct.aoespam[87385]=true		-- Seed of Corruption (Explosion Soulburned)
		ct.aoespam[172]=true		-- Corruption
		ct.aoespam[87389]=true		-- Corruption (Soulburn: Seed of Corruption)
		ct.aoespam[30108]=true		-- Unstable Affliction
		ct.aoespam[348]=true		-- Immolate
		ct.aoespam[980]=true		-- Bane of Agony
		ct.aoespam[85455]=true		-- Bane of Havoc
		ct.aoespam[85421]=true		-- Burning Embers
		ct.aoespam[42223]=true		-- Rain of Fire
		ct.aoespam[5857]=true		-- Hellfire Effect
		ct.aoespam[50590]=true		-- Immolation Aura
		ct.aoespam[30213]=true		-- Legion Strike (Felguard)
		ct.aoespam[89753]=true		-- Felstorm (Felguard)
		ct.aoespam[20153]=true		-- Immolation (Infrenal)
	end
	if(ct.healing)then
		ct.healfilter[28176]=true	-- Fel Armor
		ct.healfilter[63106]=true	-- Siphon Life
		ct.healfilter[54181]=true	-- Fel Synergy
		ct.healfilter[89653]=true	-- Drain Life
		ct.healfilter[79268]=true	-- Soul Harvest
		ct.healfilter[30294]=true	-- Soul Leech
	end
elseif ct.myclass=="DRUID"then
	if(ct.mergeaoespam)then
		-- Healer spells
		ct.aoespam[774]=true		-- Rejuvenation (Normal)
		ct.aoespam[64801]=true		-- Rejuvenation (First tick)
		ct.aoespam[48438]=true		-- Wild Growth
		ct.aoespam[8936]=true		-- Regrowth
		ct.aoespam[33763]=true		-- Lifebloom
		ct.aoespam[81269]=true		-- Efflorescence
		-- Damager spells
		ct.aoespam[8921]=true		-- Moonfire
		ct.aoespam[93402]=true		-- Sunfire
		ct.aoespam[5570]=true		-- Insect Swarm
		ct.aoespam[42231]=true		-- Hurricane
		ct.aoespam[50288]=true		-- Starfall
		ct.aoespam[61391]=true		-- Typhoon
		ct.aoespam[1822]=true		-- Rake
		ct.aoespam[62078]=true		-- Swipe (Cat Form)
		ct.aoespam[779]=true		-- Swipe (Bear Form)
		ct.aoespam[33745]=true		-- Lacerate
		ct.aoespam[1079]=true		-- Rip
		
		
	end
elseif ct.myclass=="PALADIN"then
	if(ct.mergeaoespam)then
		ct.aoespam[81297]=true		-- Consecration
		ct.aoespam[2812]=true		-- Holy Wrath
		ct.aoespam[53385]=true		-- Divine Storm
	end
elseif ct.myclass=="PRIEST"then
	if(ct.mergeaoespam)then
		-- Healer spells
		ct.aoespam[47750]=true		-- Penance (Heal Effect)
		ct.aoespam[139]=true		-- Renew
		ct.aoespam[596]=true		-- Prayer of Healing
		ct.aoespam[56161]=true		-- Glyph of Prayer of Healing
		ct.aoespam[64844]=true		-- Divine Hymn
		ct.aoespam[32546]=true		-- Binding Heal
		ct.aoespam[77489]=true		-- Echo of Light
		ct.aoespam[34861]=true		-- Circle of Healing
		ct.aoespam[23455]=true		-- Holy Nova (Healing Effect)
		ct.aoespam[33110]=true		-- Prayer of Mending
		ct.aoespam[63544]=true		-- Divine Touch
		-- Damager spells
		ct.aoespam[47666]=true		-- Penance (Damage Effect)
		ct.aoespam[15237]=true		-- Holy Nova (Damage Effect)
		ct.aoespam[589]=true		-- Shadow Word: Pain
		ct.aoespam[34914]=true		-- Vampiric Touch
		ct.aoespam[2944]=true		-- Devouring Plague
		ct.aoespam[63675]=true		-- Improved Devouring Plague
		ct.aoespam[15407]=true		-- Mind Flay
		ct.aoespam[49821]=true		-- Mind Seer
		ct.aoespam[87532]=true		-- Shadowy Apparition
		
	end
	if(ct.healing)then
		ct.healfilter[2944]=true 	-- Devouring Plague (Healing)
		ct.healfilter[15290]=true	-- Vampiric Embrace
	end
elseif ct.myclass=="SHAMAN"then
	if(ct.mergeaoespam)then
		ct.aoespam[421]=true		-- Chain Lightning
		ct.aoespam[8349]=true		-- Fire Nova
		ct.aoespam[77478]=true 		-- Earhquake
		ct.aoespam[51490]=true 		-- Thunderstorm
		ct.aoespam[8187]=true 		-- Magma Totem
	end
elseif ct.myclass=="MAGE"then
	if(ct.mergeaoespam)then
		ct.aoespam[44461]=true		-- Living Bomb Explosion
		ct.aoespam[44457]=true		-- Living Bomb Dot
		ct.aoespam[2120]=true		-- Flamestrike
		ct.aoespam[12654]=true		-- Ignite
		ct.aoespam[11366]=true		-- Pyroblast
		ct.aoespam[31661]=true		-- Dragon's Breath
		ct.aoespam[42208]=true		-- Blizzard
		ct.aoespam[122]=true		-- Frost Nova
		ct.aoespam[1449]=true		-- Arcane Explosion
	end
elseif ct.myclass=="WARRIOR"then
	if(ct.mergeaoespam)then
		ct.aoespam[845]=true		-- Cleave
		ct.aoespam[46968]=true		-- Shockwave
		ct.aoespam[6343]=true		-- Thunder Clap
		ct.aoespam[1680]=true		-- Whirlwind
		ct.aoespam[94009]=true		-- Rend
	end
elseif ct.myclass=="HUNTER"then
	if(ct.mergeaoespam)then
		ct.aoespam[2643]=true		-- Multi-Shot
	end
elseif ct.myclass=="DEATHKNIGHT"then
	if(ct.mergeaoespam)then
		ct.aoespam[55095]=true		-- Frost Fever
		ct.aoespam[55078]=true		-- Blood Plague
		ct.aoespam[55536]=true		-- Unholy Blight
		ct.aoespam[48721]=true		-- Blood Boil
		ct.aoespam[49184]=true		-- Howling Blast
		ct.aoespam[52212]=true		-- Death and Decay
	end
elseif ct.myclass=="ROGUE"then
	if(ct.mergeaoespam)then
		ct.aoespam[51723]=true		-- Fan of Knives
		ct.aoespam[2818]=true		-- Deadly Poison
		ct.aoespam[8680]=true		-- Instant Poison
	end

end
---------------------------------------------------------------------------------
-- character config, overrides general and class
if ct.myname == "Affli" then
	ct["treshold"] = 500
end
---------------------------------------------------------------------------------

--do not edit below unless you know what you are doing

local numf
if(ct.damage or ct.healing)then
	 numf=4
else
	 numf=3
end
-- detect vechile
local function SetUnit()
	if(UnitHasVehicleUI("player"))then
		ct.unit="vehicle"
	else
		ct.unit="player"
	end
	CombatTextSetActiveUnit(ct.unit)
end

--limit lines
local function LimitLines()
	for i=1,#ct.frames do
		f=ct.frames[i]
		f:SetMaxLines(f:GetHeight()/ct.fontsize)
	end
end

-- scrollable frames
local function SetScroll()
	for i=1,#ct.frames do
		ct.frames[i]:EnableMouseWheel(true)
		ct.frames[i]:SetScript("OnMouseWheel", function(self,delta)
			if delta >0 then
				self:ScrollUp()
			elseif delta <0 then
				self:ScrollDown()
			end
		end)
	end
end
	
-- msg flow direction
local function ScrollDirection()
	if (COMBAT_TEXT_FLOAT_MODE=="2") then
		ct.mode="TOP"
	else
		ct.mode="BOTTOM"
	end
	for i=1,#ct.frames do
		ct.frames[i]:Clear()
		ct.frames[i]:SetInsertMode(ct.mode)
	end
end
-- partial resists styler
local part="-%s (%s %s)"
local r,g,b
-- the function, handles everything
local function OnEvent(self,event,subevent,...)
if(event=="COMBAT_TEXT_UPDATE")then
	local arg2,arg3 = ...
	if (SHOW_COMBAT_TEXT=="0")then
		return
	else
	if subevent=="DAMAGE"then
		xCT1:AddMessage("-"..arg2,.75,.1,.1)
	elseif subevent=="DAMAGE_CRIT"then
		xCT1:AddMessage(ct.critprefix.."-"..arg2..ct.critpostfix,1,.1,.1)
	elseif subevent=="SPELL_DAMAGE"then
		xCT1:AddMessage("-"..arg2,.75,.3,.85)
	elseif subevent=="SPELL_DAMAGE_CRIT"then
		xCT1:AddMessage(ct.critprefix.."-"..arg2..ct.critpostfix,1,.3,.5)

	elseif subevent=="HEAL"then
		if(arg3>=ct.healtreshold)then
			xCT2:AddMessage("+"..arg3,.1,.75,.1)
		end
	elseif subevent=="HEAL_CRIT"then
		if(arg3>=ct.healtreshold)then
			xCT2:AddMessage("+"..ct.critprefix..arg3..ct.critpostfix,.1,1,.1)
		end
	elseif subevent=="PERIODIC_HEAL"then
		if(arg3>=ct.healtreshold)then
			xCT2:AddMessage("+"..arg3,.1,.5,.1)
		end

	elseif subevent=="SPELL_CAST"then
		xCT3:AddMessage(arg2,1,.82,0)

	
	elseif subevent=="MISS"and(COMBAT_TEXT_SHOW_DODGE_PARRY_MISS=="1")then
		xCT1:AddMessage(MISS,.5,.5,.5)
	elseif subevent=="DODGE"and(COMBAT_TEXT_SHOW_DODGE_PARRY_MISS=="1")then
		xCT1:AddMessage(DODGE,.5,.5,.5)
	elseif subevent=="PARRY"and(COMBAT_TEXT_SHOW_DODGE_PARRY_MISS=="1")then
		xCT1:AddMessage(PARRY,.5,.5,.5)
	elseif subevent=="EVADE"and(COMBAT_TEXT_SHOW_DODGE_PARRY_MISS=="1")then
		xCT1:AddMessage(EVADE,.5,.5,.5)
	elseif subevent=="IMMUNE"and(COMBAT_TEXT_SHOW_DODGE_PARRY_MISS=="1")then
		xCT1:AddMessage(IMMUNE,.5,.5,.5)
	elseif subevent=="DEFLECT"and(COMBAT_TEXT_SHOW_DODGE_PARRY_MISS=="1")then
		xCT1:AddMessage(DEFLECT,.5,.5,.5)
	elseif subevent=="REFLECT"and(COMBAT_TEXT_SHOW_DODGE_PARRY_MISS=="1")then
		xCT1:AddMessage(REFLECT,.5,.5,.5)
	elseif subevent=="SPELL_MISS"and(COMBAT_TEXT_SHOW_DODGE_PARRY_MISS=="1")then
		xCT1:AddMessage(MISS,.5,.5,.5)
	elseif subevent=="SPELL_DODGE"and(COMBAT_TEXT_SHOW_DODGE_PARRY_MISS=="1")then
		xCT1:AddMessage(DODGE,.5,.5,.5)
	elseif subevent=="SPELL_PARRY"and(COMBAT_TEXT_SHOW_DODGE_PARRY_MISS=="1")then
		xCT1:AddMessage(PARRY,.5,.5,.5)
	elseif subevent=="SPELL_EVADE"and(COMBAT_TEXT_SHOW_DODGE_PARRY_MISS=="1")then
		xCT1:AddMessage(EVADE,.5,.5,.5)
	elseif subevent=="SPELL_IMMUNE"and(COMBAT_TEXT_SHOW_DODGE_PARRY_MISS=="1")then
		xCT1:AddMessage(IMMUNE,.5,.5,.5)
	elseif subevent=="SPELL_DEFLECT"and(COMBAT_TEXT_SHOW_DODGE_PARRY_MISS=="1")then
		xCT1:AddMessage(DEFLECT,.5,.5,.5)
	elseif subevent=="SPELL_REFLECT"and(COMBAT_TEXT_SHOW_DODGE_PARRY_MISS=="1")then
		xCT1:AddMessage(REFLECT,.5,.5,.5)

	elseif subevent=="RESIST"then
		if(arg3)then
			if(COMBAT_TEXT_SHOW_RESISTANCES=="1") then
				xCT1:AddMessage(part:format(arg2,RESIST,arg3),.75,.5,.5)
			else
				xCT1:AddMessage(arg2,.75,.1,.1)
			end
		elseif(COMBAT_TEXT_SHOW_RESISTANCES=="1")then
			xCT1:AddMessage(RESIST,.5,.5,.5)
		end
	elseif subevent=="BLOCK"then
		if(arg3)then
			if(COMBAT_TEXT_SHOW_RESISTANCES=="1")then
				xCT1:AddMessage(part:format(arg2,BLOCK,arg3),.75,.5,.5)
			else
				xCT1:AddMessage(arg2,.75,.1,.1)
			end
		elseif(COMBAT_TEXT_SHOW_RESISTANCES=="1")then
			xCT1:AddMessage(BLOCK,.5,.5,.5)
		end
	elseif subevent=="ABSORB"then
		if(arg3)then
			if(COMBAT_TEXT_SHOW_RESISTANCES=="1")then
				xCT1:AddMessage(part:format(arg2,ABSORB,arg3),.75,.5,.5)
			else
				xCT1:AddMessage(arg2,.75,.1,.1)
			end
		elseif(COMBAT_TEXT_SHOW_RESISTANCES=="1")then
			xCT1:AddMessage(ABSORB,.5,.5,.5)
		end
	elseif subevent=="SPELL_RESIST"then
		if(arg3)then
			if(COMBAT_TEXT_SHOW_RESISTANCES=="1") then
				xCT1:AddMessage(part:format(arg2,RESIST,arg3),.5,.3,.5)
			else
				xCT1:AddMessage(arg2,.75,.3,.85)
			end
		elseif(COMBAT_TEXT_SHOW_RESISTANCES=="1")then
			xCT1:AddMessage(RESIST,.5,.5,.5)
		end
	elseif subevent=="SPELL_BLOCK"then
		if (arg3)then
			if(COMBAT_TEXT_SHOW_RESISTANCES=="1")then
				xCT1:AddMessage(part:format(arg2,BLOCK,arg3),.5,.3,.5)
			else
				xCT1:AddMessage("-"..arg2,.75,.3,.85)
			end
		elseif(COMBAT_TEXT_SHOW_RESISTANCES=="1")then
			xCT1:AddMessage(BLOCK,.5,.5,.5)
		end
	elseif subevent=="SPELL_ABSORB"then
		if(arg3)then
			if(COMBAT_TEXT_SHOW_RESISTANCES=="1")then
				xCT1:AddMessage(part:format(arg2,ABSORB,arg3),.5,.3,.5)
			else
				xCT1:AddMessage(arg2,.75,.3,.85)
			end
		elseif(COMBAT_TEXT_SHOW_RESISTANCES=="1")then
			xCT1:AddMessage(ABSORB,.5,.5,.5)
		end

	elseif subevent=="ENERGIZE"and(COMBAT_TEXT_SHOW_ENERGIZE=="1")then
		if  tonumber(arg2)>0 then
			if(arg3 and arg3=="MANA" or arg3=="RAGE" or arg3=="FOCUS" or arg3=="ENERGY" or arg3=="RUINIC_POWER" or arg3=="SOUL_SHARDS")then
				xCT3:AddMessage("+"..arg2.." ".._G[arg3],PowerBarColor[arg3].r,PowerBarColor[arg3].g,PowerBarColor[arg3].b)
			end
		end

	elseif subevent=="PERIODIC_ENERGIZE"and(COMBAT_TEXT_SHOW_PERIODIC_ENERGIZE=="1")then
		if  tonumber(arg2)>0 then
			if(arg3 and arg3=="MANA" or arg3=="RAGE" or arg3=="FOCUS" or arg3=="ENERGY" or arg3=="RUINIC_POWER" or arg3=="SOUL_SHARDS")then
				xCT3:AddMessage("+"..arg2.." ".._G[arg3],PowerBarColor[arg3].r,PowerBarColor[arg3].g,PowerBarColor[arg3].b)
			end
		end
	elseif subevent=="SPELL_AURA_START"and(COMBAT_TEXT_SHOW_AURAS=="1")then
		xCT3:AddMessage("+"..arg2,1,.5,.5)
	elseif subevent=="SPELL_AURA_END"and(COMBAT_TEXT_SHOW_AURAS=="1")then
		xCT3:AddMessage("-"..arg2,.5,.5,.5)
	elseif subevent=="SPELL_AURA_START_HARMFUL"and(COMBAT_TEXT_SHOW_AURAS=="1")then
		xCT3:AddMessage("+"..arg2,1,.1,.1)
	elseif subevent=="SPELL_AURA_END_HARMFUL"and(COMBAT_TEXT_SHOW_AURAS=="1")then
		xCT3:AddMessage("-"..arg2,.1,1,.1)

	elseif subevent=="HONOR_GAINED"and(COMBAT_TEXT_SHOW_HONOR_GAINED=="1")then
		arg2=tonumber(arg2)
		if(arg2 and abs(arg2)>1) then
			arg2=floor(arg2)
			if (arg2>0)then
				xCT3:AddMessage(HONOR.." +"..arg2,.1,.1,1)
			end
		end

	elseif subevent=="FACTION"and(COMBAT_TEXT_SHOW_REPUTATION=="1")then
		xCT3:AddMessage(arg2.." +"..arg3,.1,.1,1)

	elseif subevent=="SPELL_ACTIVE"and(COMBAT_TEXT_SHOW_REACTIVES=="1")then
		xCT3:AddMessage(arg2,1,.82,0)
	end
end

elseif event=="UNIT_HEALTH"and(COMBAT_TEXT_SHOW_LOW_HEALTH_MANA=="1")then
	if subevent==ct.unit then
		if(UnitHealth(ct.unit)/UnitHealthMax(ct.unit)<=COMBAT_TEXT_LOW_HEALTH_THRESHOLD)then
			if (not lowHealth) then
				xCT3:AddMessage(HEALTH_LOW,1,.1,.1)
				lowHealth=true
			end
		else
			lowHealth=nil
		end
	end

elseif event=="UNIT_MANA"and(COMBAT_TEXT_SHOW_LOW_HEALTH_MANA=="1")then
	if subevent==ct.unit then
		local _,powerToken=UnitPowerType(ct.unit)
		if (powerToken=="MANA"and(UnitPower(ct.unit)/UnitPowerMax(ct.unit))<=COMBAT_TEXT_LOW_MANA_THRESHOLD)then
			if (not lowMana)then
				xCT3:AddMessage(MANA_LOW,1,.1,.1)
				lowMana=true
			end
		else
			lowMana=nil
		end
	end

elseif event=="PLAYER_REGEN_ENABLED"and(COMBAT_TEXT_SHOW_COMBAT_STATE=="1")then
		xCT3:AddMessage("-"..LEAVING_COMBAT,.1,1,.1)

elseif event=="PLAYER_REGEN_DISABLED"and(COMBAT_TEXT_SHOW_COMBAT_STATE=="1")then
		xCT3:AddMessage("+"..ENTERING_COMBAT,1,.1,.1)

elseif event=="UNIT_COMBO_POINTS"and(COMBAT_TEXT_SHOW_COMBO_POINTS=="1")then
	if(subevent==ct.unit)then
		local cp=GetComboPoints(ct.unit,"target")
			if(cp>0)then
				r,g,b=1,.82,.0
				if (cp==MAX_COMBO_POINTS)then
					r,g,b=0,.82,1
				end
				xCT3:AddMessage(format(COMBAT_TEXT_COMBO_POINTS,cp),r,g,b)
			end
	end

elseif event=="RUNE_POWER_UPDATE"then
	local arg1,arg2 = subevent,...
	if(arg2==true)then
		local rune=GetRuneType(arg1);
		local msg=COMBAT_TEXT_RUNE[rune];
		if(rune==1)then 
			r=.75
			g=0
			b=0
		elseif(rune==2)then
			r=.75
			g=1
			b=0
		elseif(rune==3)then
			r=0
			g=1
			b=1	
		end
		if(rune and rune<4)then
			xCT3:AddMessage("+"..msg,r,g,b)
		end
	end

elseif event=="UNIT_ENTERED_VEHICLE"or event=="UNIT_EXITING_VEHICLE"then
	if(arg1=="player")then
		SetUnit()
	end

elseif event=="PLAYER_ENTERING_WORLD"then
	SetUnit()
	
--	ScrollDirection()

	
	if(ct.scrollable)then
		SetScroll()
	else
		LimitLines()
	end

	if(ct.damage or ct.healing)then
		ct.pguid=UnitGUID"player"
	end
end
end

-- change damage font (if desired)
if(ct.damagestyle)then
	DAMAGE_TEXT_FONT=ct.font
end

-- the frames
ct.locked=true
ct.frames={}
for i=1,numf do
	local f=CreateFrame("ScrollingMessageFrame","xCT"..i,UIParent)
	f:SetFont(ct.font,ct.fontsize,ct.fontstyle)
	f:SetShadowColor(0,0,0,0)
	f:SetFading(true)
	f:SetFadeDuration(0.5)
	f:SetTimeVisible(ct.timevisible)
	f:SetMaxLines(ct.maxlines)
	f:SetSpacing(2)
	f:SetWidth(128)
	f:SetHeight(128)
	f:SetPoint("CENTER",0,0)
	f:SetMovable(true)
	f:SetResizable(true)
	f:SetMinResize(128,128)
	f:SetMaxResize(768,768)
	f:SetClampedToScreen(true)
	f:SetClampRectInsets(0,0,ct.fontsize,0)
	if(i==1)then
		f:SetJustifyH(ct.justify_1)
    f:SetFont(ct.damagefont,ct.fontsize,ct.fontstyle)
		f:SetPoint("CENTER",-192,-32)
	elseif(i==2)then
		f:SetJustifyH(ct.justify_2)
    f:SetFont(ct.damagefont,ct.fontsize,ct.fontstyle)
		f:SetPoint("CENTER",192,-32)
	elseif(i==3)then
		f:SetJustifyH(ct.justify_3)
		f:SetWidth(256)
		f:SetPoint("CENTER",0,192)
	else
    f:SetFont(ct.damagefont,ct.fontsize,ct.fontstyle)
		f:SetJustifyH(ct.justify_4)
		f:SetPoint("CENTER",320,0)
		local a,_,c=f:GetFont()
		if (ct.damagefontsize=="auto")then
			if ct.icons then
				f:SetFont(a,ct.iconsize/2,c)
			end
		elseif (type(ct.damagefontsize)=="number")then
			f:SetFont(a,ct.damagefontsize,c)
		end
			
	end
	ct.frames[i] = f
end

-- register events
local xCT=CreateFrame"Frame"
xCT:RegisterEvent"COMBAT_TEXT_UPDATE"
xCT:RegisterEvent"UNIT_HEALTH"
xCT:RegisterEvent"UNIT_MANA"
xCT:RegisterEvent"PLAYER_REGEN_DISABLED"
xCT:RegisterEvent"PLAYER_REGEN_ENABLED"
xCT:RegisterEvent"UNIT_COMBO_POINTS"
if(ct.dkrunes and select(2,UnitClass"player")=="DEATHKNIGHT")then
	xCT:RegisterEvent"RUNE_POWER_UPDATE"
end
xCT:RegisterEvent"UNIT_ENTERED_VEHICLE"
xCT:RegisterEvent"UNIT_EXITING_VEHICLE"
xCT:RegisterEvent"PLAYER_ENTERING_WORLD"
xCT:SetScript("OnEvent",OnEvent)

if(ct.killingblow)then
	local xCTkb=CreateFrame"Frame"
	xCTkb:SetScript("OnEvent", function(_, _, _, event, guid, _, _, _, tname)
		if event == "PARTY_KILL" and guid==UnitGUID("player") then
			xCT3:AddMessage("Killing Blow: "..tname, 1, 1, 0)
		end
	end)
	xCTkb:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
end

-- turn off blizz ct
CombatText:UnregisterAllEvents()
CombatText:SetScript("OnLoad",nil)
CombatText:SetScript("OnEvent",nil)
CombatText:SetScript("OnUpdate",nil)

-- steal external messages sent by other addons using CombatText_AddMessage
Blizzard_CombatText_AddMessage=CombatText_AddMessage
function CombatText_AddMessage(message,scrollFunction,r,g,b,displayType,isStaggered)
	xCT3:AddMessage(message,r,g,b)
end

-- hide some blizz options
InterfaceOptionsCombatTextPanelFriendlyHealerNames:Hide()

-- force hide blizz damage/healing, if desired
if not(ct.blizzheadnumbers==true)then
	InterfaceOptionsCombatTextPanelTargetDamage:Hide()
	InterfaceOptionsCombatTextPanelPeriodicDamage:Hide()
	InterfaceOptionsCombatTextPanelPetDamage:Hide()
	InterfaceOptionsCombatTextPanelHealing:Hide()
	SetCVar("CombatLogPeriodicSpells",0)
	SetCVar("PetMeleeDamage",0)
	SetCVar("CombatDamage",0)
	SetCVar("CombatHealing",0)
end


-- hook blizz float mode selector. blizz sucks, because changing  cVar combatTextFloatMode doesn't fire CVAR_UPDATE
--	hooksecurefunc("InterfaceOptionsCombatTextPanelFCTDropDown_OnClick",ScrollDirection)
--	--COMBAT_TEXT_SCROLL_ARC="" --may cause unexpected bugs, use with caution!

InterfaceOptionsCombatTextPanelFCTDropDown:Hide() -- sorry, blizz fucking bug with SCM:SetInsertMode()

-- modify blizz ct options title lol
InterfaceOptionsCombatTextPanelTitle:SetText(COMBAT_TEXT_LABEL.." (powered by |cffFF0000x|rCT)")

-- color printer
local pr = function(msg)
    print("|cffFF0000x|rCT:", tostring(msg))
end

-- awesome configmode and testmode
local StartConfigmode=function()
	if not InCombatLockdown()then
		for i=1,#ct.frames do
			f=ct.frames[i]
			f:SetBackdrop({
				bgFile="Interface/Tooltips/UI-Tooltip-Background",
				edgeFile="Interface/Tooltips/UI-Tooltip-Border",
				tile=false,tileSize=0,edgeSize=2,
				insets={left=0,right=0,top=0,bottom=0}})
			f:SetBackdropColor(.1,.1,.1,.8)
			f:SetBackdropBorderColor(.1,.1,.1,.5)

			f.fs=f:CreateFontString(nil,"OVERLAY")
			f.fs:SetFont(ct.font,ct.fontsize,ct.fontstyle)
			f.fs:SetPoint("BOTTOM",f,"TOP",0,0)
			if(i==1)then
				f.fs:SetText(DAMAGE.." (drag me)")
				f.fs:SetTextColor(1,.1,.1,.9)
			elseif(i==2)then
				f.fs:SetText(SHOW_COMBAT_HEALING.."(drag me)")
				f.fs:SetTextColor(.1,1,.1,.9)
			elseif(i==3)then
				f.fs:SetText(COMBAT_TEXT_LABEL.."(drag me)")
				f.fs:SetTextColor(.1,.1,1,.9)
			else
				f.fs:SetText(SCORE_DAMAGE_DONE.." / "..SCORE_HEALING_DONE)
				f.fs:SetTextColor(1,1,0,.9)
			end

			f.t=f:CreateTexture"ARTWORK"
			f.t:SetPoint("TOPLEFT",f,"TOPLEFT",1,-1)
			f.t:SetPoint("TOPRIGHT",f,"TOPRIGHT",-1,-19)
			f.t:SetHeight(20)
			f.t:SetTexture(.5,.5,.5)
			f.t:SetAlpha(.3)

			f.d=f:CreateTexture"ARTWORK"
			f.d:SetHeight(16)
			f.d:SetWidth(16)
			f.d:SetPoint("BOTTOMRIGHT",f,"BOTTOMRIGHT",-1,1)
			f.d:SetTexture(.5,.5,.5)
			f.d:SetAlpha(.3)

			f.tr=f:CreateTitleRegion()
			f.tr:SetPoint("TOPLEFT",f,"TOPLEFT",0,0)
			f.tr:SetPoint("TOPRIGHT",f,"TOPRIGHT",0,0)
			f.tr:SetHeight(20)

			f:EnableMouse(true)
			f:RegisterForDrag"LeftButton"
			f:SetScript("OnDragStart",f.StartSizing)
			if not(ct.scrollable)then
			f:SetScript("OnSizeChanged",function(self)
				self:SetMaxLines(self:GetHeight()/ct.fontsize)
				self:Clear()
			end)
			end

			f:SetScript("OnDragStop",f.StopMovingOrSizing)
			ct.locked=false
		end
		pr("unlocked.")
	else
		pr("can't be configured in combat.")
	end
end

local function EndConfigmode()
	for i=1,#ct.frames do
		f=ct.frames[i]
		f:SetBackdrop(nil)
		f.fs:Hide()
		f.fs=nil
		f.t:Hide()
		f.t=nil
		f.d:Hide()
		f.d=nil
		f.tr=nil
		f:EnableMouse(false)
		f:SetScript("OnDragStart",nil)
		f:SetScript("OnDragStop",nil)
	end
	ct.locked=true
	pr("Window positions unsaved, don't forget to reload UI.")
end

local function StartTestMode()
--init really random number generator.
	local random=math.random
	random(time());random(); random(time())
	
	local TimeSinceLastUpdate=0
	local UpdateInterval
	if(ct.damagecolor)then
		ct.dmindex={}
		ct.dmindex[1]=1
		ct.dmindex[2]=2
		ct.dmindex[3]=4
		ct.dmindex[4]=8
		ct.dmindex[5]=16
		ct.dmindex[6]=32
		ct.dmindex[7]=64
	end

	
	for i=1,#ct.frames do
	ct.frames[i]:SetScript("OnUpdate",function(self,elapsed)
		UpdateInterval=random(65,1000)/250
		TimeSinceLastUpdate=TimeSinceLastUpdate+elapsed
		if(TimeSinceLastUpdate>UpdateInterval)then
			if(i==1)then
			ct.frames[i]:AddMessage("-"..random(100000),1,random(255)/255,random(255)/255)
			elseif(i==2)then
			ct.frames[i]:AddMessage("+"..random(50000),.1,random(128,255)/255,.1)
			elseif(i==3)then
			ct.frames[i]:AddMessage(COMBAT_TEXT_LABEL,random(255)/255,random(255)/255,random(255)/255)
			elseif(i==4)then
				local msg
				local icon
				local color={}
				msg=random(40000)
				if(ct.icons)then
					_,_,icon=GetSpellInfo(msg)
				end
				if(icon)then
					msg=msg.." \124T"..icon..":"..ct.iconsize..":"..ct.iconsize..":0:0:64:64:5:59:5:59\124t"
					if(ct.damagecolor)then
						color=ct.dmgcolor[ct.dmindex[random(#ct.dmindex)]]
					else
						color={1,1,0}
					end
				elseif(ct.damagecolor) and not(ct.icons)then
					color=ct.dmgcolor[ct.dmindex[random(#ct.dmindex)]]
				elseif not(ct.damagecolor)then
					color={1,1,random(0,1)}
				end
				ct.frames[i]:AddMessage(msg,unpack(color))
				
			end
			TimeSinceLastUpdate = 0
		end
		end)		
	ct.testmode=true
end
end

local function EndTestMode()
	for i=1,#ct.frames do
		ct.frames[i]:SetScript("OnUpdate",nil)
		ct.frames[i]:Clear()
	end
	if(ct.damagecolor)then
		ct.dmindex=nil
	end
	ct.testmode=false
	end

-- /xct lock popup dialog
StaticPopupDialogs["XCT_LOCK"]={
	text="To save |cffFF0000x|rCT window positions you need to reload your UI.\n Click "..ACCEPT.." to reload UI.\nClick "..CANCEL.." to do it later.",
	button1=ACCEPT,
	button2=CANCEL,
	OnAccept=function() if not InCombatLockdown() then ReloadUI() else EndConfigmode() end end,
	OnCancel=EndConfigmode,
	timeout=0,
	whileDead=1,
	hideOnEscape=true,
	showAlert=true,
}

-- slash commands
SLASH_XCT1="/xct"
SlashCmdList["XCT"]=function(input)
	input=string.lower(input)
	if(input=="unlock")then
		if (ct.locked)then
			StartConfigmode()
		else
			pr("already unlocked.")
		end
	elseif(input=="lock")then
		if (ct.locked) then
			pr("already locked.")
		else
			StaticPopup_Show("XCT_LOCK")
		end
	elseif(input=="test")then
		if (ct.testmode) then
			EndTestMode()
			pr("test mode disabled.")
		else
			StartTestMode()
			pr("test mode enabled.")
		end
	elseif(input=="mypos")then
		xCT1:ClearAllPoints()
		xCT1:SetPoint("CENTER",UIParent, "CENTER", -90, -8)
		xCT1:SetHeight(142)
		xCT1:SetWidth(128)
		xCT2:ClearAllPoints()
		xCT2:SetPoint("CENTER",UIParent, "CENTER", 90, -8)
		xCT2:SetHeight(142)
		xCT2:SetWidth(128)
		xCT3:ClearAllPoints()
		xCT3:SetPoint("TOP",UIParent, "TOP", -2, -34)
		xCT3:SetHeight(264)
		xCT3:SetWidth(216)
		xCT4:ClearAllPoints()
		xCT4:SetPoint("CENTER",UIParent, "CENTER", 444, 152)
		xCT4:SetHeight(172)
		xCT4:SetWidth(136)
	else
		pr("use |cffFF0000/xct unlock|r to move and resize frames.")
		pr("use |cffFF0000/xct lock|r to lock frames.")
		pr("use |cffFF0000/xct test|r to toggle testmode (sample xCT output).")
	end
end

-- awesome shadow priest helper
if(ct.stopvespam and ct.myclass=="PRIEST")then
	local sp=CreateFrame("Frame")
	sp:SetScript("OnEvent",function(...)
		if(GetShapeshiftForm()==1)then
			if(ct.blizzheadnumbers)then
				SetCVar('CombatHealing',0)
			end
		else
			if(ct.blizzheadnumbers)then
				SetCVar('CombatHealing',1)
			end
		end
	end)
	sp:RegisterEvent("PLAYER_ENTERING_WORLD")	
	sp:RegisterEvent("UPDATE_SHAPESHIFT_FORM")
	sp:RegisterEvent("UPDATE_SHAPESHIFT_FORMS")
end

-- spam merger
local SQ
if(ct.mergeaoespam)then
	if (ct.damage or ct.healing) then
		if (not ct.mergeaoespamtime or ct.mergeaoespamtime<1) then
			ct.mergeaoespamtime=1
		end
		local pairs=pairs
		SQ={}
		for k,v in pairs(ct.aoespam) do
			SQ[k]={queue = 0, msg = "", color={}, count=0, utime=0, locked=false}
		end
		ct.SpamQueue=function(spellId, add)
			local amount
			local spam=SQ[spellId]["queue"]
			if (spam and type(spam=="number"))then
				amount=spam+add
			else
				amount=add
			end
			return amount
		end
		local tslu=0
		local xCTspam=CreateFrame"Frame"
		xCTspam:SetScript("OnUpdate", function(self, elapsed)
			local count
			tslu=tslu+elapsed
			if tslu > 0.5 then
				tslu=0
			local utime=time()
				for k,v in pairs(SQ) do
					if not SQ[k]["locked"] and SQ[k]["queue"]>0 and SQ[k]["utime"]+ct.mergeaoespamtime<=utime then
						if SQ[k]["count"]>1 then
							count=" |cffFFFFFF x "..SQ[k]["count"].."|r"
						else
							count=""
						end
						xCT4:AddMessage(SQ[k]["queue"]..SQ[k]["msg"]..count, unpack(SQ[k]["color"]))
						SQ[k]["queue"]=0
						SQ[k]["count"]=0
					end
				end
			end
		end)
	end
end

-- damage
if(ct.damage)then
	local unpack,select,time=unpack,select,time
	local	gflags=bit.bor(	COMBATLOG_OBJECT_AFFILIATION_MINE,
 			COMBATLOG_OBJECT_REACTION_FRIENDLY,
 			COMBATLOG_OBJECT_CONTROL_PLAYER,
 			COMBATLOG_OBJECT_TYPE_GUARDIAN
 			)
	local xCTd=CreateFrame"Frame"
	if(ct.damagecolor)then
		ct.dmgcolor={}
		ct.dmgcolor[1]={1,1,0} -- physical
		ct.dmgcolor[2]={1,.9,.5} -- holy
		ct.dmgcolor[4]={1,.5,0} -- fire
		ct.dmgcolor[8]={.3,1,.3} -- nature
		ct.dmgcolor[16]={.5,1,1} -- frost
		ct.dmgcolor[32]={.5,.5,1} -- shadow
		ct.dmgcolor[64]={1,.5,1} -- arcane
	end
	
	if(ct.icons)then
		ct.blank=zuiDB["media"].xct
	end

	local dmg=function(self,event,...) 
		local msg,icon
		local timestamp, eventType, sourceGUID, sourceName, sourceFlags, destGUID, destName, destFlags = select(1,...)
		if(sourceGUID==ct.pguid and destGUID~=ct.pguid)or(sourceGUID==UnitGUID"pet" and ct.petdamage)or(sourceFlags==gflags)then
			if(eventType=="SWING_DAMAGE")then
				local amount,_,_,_,_,_,critical=select(9,...)
				if(amount>=ct.treshold)then
					msg=amount
					if (critical) then
						msg=ct.critprefix..msg..ct.critpostfix
					end
					if(ct.icons)then
						if(sourceGUID==UnitGUID"pet") or (sourceFlags==gflags)then
							icon=PET_ATTACK_TEXTURE
						else
						--	icon=GetSpellTexture(1, BOOKTYPE_SPELL)
						--	_,_,icon=GetSpellInfo(6603)
							icon=GetSpellTexture(6603)
						end
						msg=msg.." \124T"..icon..":"..ct.iconsize..":"..ct.iconsize..":0:0:64:64:5:59:5:59\124t"
					end
	
					xCT4:AddMessage(msg)
				end
			elseif(eventType=="RANGE_DAMAGE")then
				local spellId,_,_,amount,_,_,_,_,_,critical=select(9,...)
				if(amount>=ct.treshold)then
					msg=amount
					if (critical) then
						msg=ct.critprefix..msg..ct.critpostfix
					end
					if(ct.icons)then
						--_,_,icon=GetSpellInfo(spellId)
						icon=GetSpellTexture(spellId)
						msg=msg.." \124T"..icon..":"..ct.iconsize..":"..ct.iconsize..":0:0:64:64:5:59:5:59\124t"
					end
	
					xCT4:AddMessage(msg)
				end
	
			elseif(eventType=="SPELL_DAMAGE")or(eventType=="SPELL_PERIODIC_DAMAGE" and ct.dotdamage)then
				local spellId,_,spellSchool,amount,_,_,_,_,_,critical=select(9,...)
				if(amount>=ct.treshold)then
					local color={}
					local rawamount=amount
					if (critical) then
						amount=ct.critprefix..amount..ct.critpostfix
					end
	
					if(ct.icons)then
					--	_,_,icon=GetSpellInfo(spellId)
						icon=GetSpellTexture(spellId)
					end
					if(ct.damagecolor)then
						if(ct.dmgcolor[spellSchool])then
							color=ct.dmgcolor[spellSchool]
						else
							color=ct.dmgcolor[1]
						end
					else
						color={1,1,0}
					end
					if (icon) then
						msg=" \124T"..icon..":"..ct.iconsize..":"..ct.iconsize..":0:0:64:64:5:59:5:59\124t"
					elseif(ct.icons)then
						msg=" \124T"..ct.blank..":"..ct.iconsize..":"..ct.iconsize..":0:0:64:64:5:59:5:59\124t"
					else
						msg=""
					end
					if ct.mergeaoespam and ct.aoespam[spellId] then
						SQ[spellId]["locked"]=true
						SQ[spellId]["queue"]=ct.SpamQueue(spellId, rawamount)
						SQ[spellId]["msg"]=msg
						SQ[spellId]["color"]=color
						SQ[spellId]["count"]=SQ[spellId]["count"]+1
						if SQ[spellId]["count"]==1 then
							SQ[spellId]["utime"]=time()
						--	SQ[spellId]["utime"]=timestamp  -- cant use now, cause log timestamps differ from time() return value by 2+ seconds (CL is in the future)
						--	print("timestamp: "..timestamp)
						--	print("time():"..time())
						end
						SQ[spellId]["locked"]=false
						return
					end
					xCT4:AddMessage(amount..""..msg,unpack(color))
				end
	
			elseif(eventType=="SWING_MISSED")then
				local missType,_=select(9,...)
				if(ct.icons)then
					if(sourceGUID==UnitGUID"pet") or (sourceFlags==gflags)then
						icon=PET_ATTACK_TEXTURE
					else
					--	icon=GetSpellTexture(1, BOOKTYPE_SPELL)
					--	_,_,icon=GetSpellInfo(6603)
						icon=GetSpellTexture(6603)
					end
					missType=missType.." \124T"..icon..":"..ct.iconsize..":"..ct.iconsize..":0:0:64:64:5:59:5:59\124t"
				end
	
				xCT4:AddMessage(missType)
	
			elseif(eventType=="SPELL_MISSED")or(eventType=="RANGE_MISSED")then
				local spellId,_,_,missType,_ = select(9,...)
				if(ct.icons)then
				--	_,_,icon=GetSpellInfo(spellId)
					icon=GetSpellTexture(spellId)
					missType=missType.." \124T"..icon..":"..ct.iconsize..":"..ct.iconsize..":0:0:64:64:5:59:5:59\124t"
				end 
				xCT4:AddMessage(missType)
	
			
			end
		end
	end
	xCTd:RegisterEvent"COMBAT_LOG_EVENT_UNFILTERED"
	xCTd:SetScript("OnEvent",dmg)
end

-- healing
if(ct.healing)then
	local unpack,select,time=unpack,select,time
	local xCTh=CreateFrame"Frame"
	if(ct.icons)then
		ct.blank=zuiDB["media"].xct
	end
	local heal=function(self,event,...) 	
		local msg,icon
		local timestamp, eventType, sourceGUID, sourceName, sourceFlags, destGUID, destName, destFlags = select(1,...)
		if(sourceGUID==ct.pguid)then
			if(eventType=='SPELL_HEAL')or(eventType=='SPELL_PERIODIC_HEAL'and ct.showhots)then
				if(ct.healing)then
					local spellId,spellName,spellSchool,amount,overhealing,absorbed,critical = select(9,...)
					if(ct.healfilter[spellId]) then
						return
					end
					if(amount>=ct.healtreshold)then
						local color={}
						local rawamount=amount
						if (critical) then 
							amount=ct.critprefix..amount..ct.critpostfix
							color={.1,1,.1}
						else
							
							color={.1,.65,.1}
						end 
						if(ct.icons)then
						--	_,_,icon=GetSpellInfo(spellId)
							icon=GetSpellTexture(spellId)
						else
							msg=""
						end
               					if (icon) then 
                					msg=' \124T'..icon..':'..ct.iconsize..':'..ct.iconsize..':0:0:64:64:5:59:5:59\124t'
						elseif(ct.icons)then
							msg=" \124T"..ct.blank..":"..ct.iconsize..":"..ct.iconsize..":0:0:64:64:5:59:5:59\124t"
                				end
						if ct.mergeaoespam and ct.aoespam[spellId] then
							SQ[spellId]["locked"]=true
							SQ[spellId]["queue"]=ct.SpamQueue(spellId, rawamount)
							SQ[spellId]["msg"]=msg
							SQ[spellId]["color"]=color
							SQ[spellId]["count"]=SQ[spellId]["count"]+1
							if SQ[spellId]["count"]==1 then
								SQ[spellId]["utime"]=time()
							end
							SQ[spellId]["locked"]=false
							return
					end 
						xCT4:AddMessage(amount..""..msg,unpack(color))
					end
				end
			end
		end
	end
	xCTh:RegisterEvent"COMBAT_LOG_EVENT_UNFILTERED"
	xCTh:SetScript("OnEvent",heal)
end
