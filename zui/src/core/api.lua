-- Tukui API, see DOCS/API.txt for more informations
local Z, C, L = unpack(select(2, ...)) -- Import: Z - functions, constants, variables; C - config; L - locales

local noop = Z.dummy
local floor = math.floor
local class = Z.myclass
local texture = C.media.blank
local backdropr, backdropg, backdropb, backdropa, borderr, borderg, borderb = 0, 0, 0, 1, 0, 0, 0

-- pixel perfect script of custom ui Scale.
local mult = 768/string.match(GetCVar("gxResolution"), "%d+x(%d+)")/C["general"].uiscale
local Scale = function(x)
    return mult*math.floor(x/mult+.5)
end

Z.Scale = function(x) return Scale(x) end
Z.mult = mult

---------------------------------------------------
-- TEMPLATES
---------------------------------------------------
local function GetTemplate(t)
	if t == "zui" then
		borderr, borderg, borderb = .6, .6, .6
		backdropr, backdropg, backdropb = .1, .1, .1
	elseif t == "ClassColor" then
		local c = Z.colors.class[class]
		borderr, borderg, borderb = c[1], c[2], c[3]
		backdropr, backdropg, backdropb = unpack(C["media"].backdropcolor)
	elseif t == "Elv" then
		borderr, borderg, borderb = .3, .3, .3
		backdropr, backdropg, backdropb = .1, .1, .1	
	elseif t == "Duffed" then
		borderr, borderg, borderb = .2, .2, .2
		backdropr, backdropg, backdropb = .02, .02, .02
	elseif t == "Dajova" then
		borderr, borderg, borderb = .05, .05, .05
		backdropr, backdropg, backdropb = .1, .1, .1
	elseif t == "Eclipse" then
		borderr, borderg, borderb = .1, .1, .1
		backdropr, backdropg, backdropb = 0, 0, 0
	elseif t == "Hydra" then
		borderr, borderg, borderb = .2, .2, .2
		backdropr, backdropg, backdropb = .075, .075, .075
	else
		borderr, borderg, borderb = unpack(C["media"].bordercolor)
		backdropr, backdropg, backdropb = unpack(C["media"].backdropcolor)
	end
end

---------------------------------------------------
-- END OF TEMPLATES
---------------------------------------------------

local function Size(frame, width, height)
	frame:SetSize(Scale(width), Scale(height or width))
end

local function Width(frame, width)
	frame:SetWidth(Scale(width))
end

local function Height(frame, height)
	frame:SetHeight(Scale(height))
end

local function Point(obj, arg1, arg2, arg3, arg4, arg5)
	-- anyone has a more elegant way for this?
	if type(arg1)=="number" then arg1 = Scale(arg1) end
	if type(arg2)=="number" then arg2 = Scale(arg2) end
	if type(arg3)=="number" then arg3 = Scale(arg3) end
	if type(arg4)=="number" then arg4 = Scale(arg4) end
	if type(arg5)=="number" then arg5 = Scale(arg5) end

	obj:SetPoint(arg1, arg2, arg3, arg4, arg5)
end

local function SetTemplate(f, t, tex)
	if tex then texture = C.media.norm else texture = C.media.blank end
	
	GetTemplate(t)
		
	f:SetBackdrop({
	  bgFile = texture, 
	  edgeFile = C.media.blank, 
	  tile = false, tileSize = 0, edgeSize = mult, 
	  insets = { left = -mult, right = -mult, top = -mult, bottom = -mult}
	})
	
	if t == "Transparent" then backdropa = 0.8 else backdropa = 1 end
	
	f:SetBackdropColor(backdropr, backdropg, backdropb, backdropa)
	f:SetBackdropBorderColor(borderr, borderg, borderb)
end

local function CreatePanel(f, t, w, h, a1, p, a2, x, y)
	GetTemplate(t)
	
	if t == "Transparent" then backdropa = 0.8 else backdropa = 1 end
	
	local sh = Scale(h)
	local sw = Scale(w)
	f:SetFrameLevel(1)
	f:SetHeight(sh)
	f:SetWidth(sw)
	f:SetFrameStrata("BACKGROUND")
	f:SetPoint(a1, p, a2, Scale(x), Scale(y))
	f:SetBackdrop({
	  bgFile = C["media"].blank, 
	  edgeFile = C["media"].blank, 
	  tile = false, tileSize = 0, edgeSize = mult, 
	  insets = { left = -mult, right = -mult, top = -mult, bottom = -mult}
	})
	f:SetBackdropColor(backdropr, backdropg, backdropb, backdropa)
	f:SetBackdropBorderColor(borderr, borderg, borderb)
end

local function SetBorder(f)
	f:SetBackdropColor(.075, .075, .075, 0.7)
	f:SetBackdropBorderColor(unpack(C["media"].bordercolor))
	border = CreateFrame("Frame", nil, f)
	border:SetPoint("TOPLEFT", f, "TOPLEFT", Z.Scale(-1), Z.Scale(1))
	border:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", Z.Scale(1), Z.Scale(-1))
	border:SetFrameStrata("BACKGROUND")
	border:SetFrameLevel(1)
	border:SetBackdrop { edgeFile = C["media"].blank, edgeSize = Z.Scale(3), insets = {left = 0, right = 0, top = 0, bottom = 0} }
	border:SetBackdropColor(unpack(C["media"].backdropcolor))
	border:SetBackdropBorderColor(unpack(C["media"].backdropcolor))
end

local function CreateShadow(f, t)
	if f.shadow then return end -- we seriously don't want to create shadow 2 times in a row on the same frame.	
	borderr, borderg, borderb = 0, 0, 0
	backdropr, backdropg, backdropb = 0, 0, 0
	if t == "ClassColor" then
		local c = Z.colors.class[class]
		borderr, borderg, borderb = c[1], c[2], c[3]
		backdropr, backdropg, backdropb = unpack(C["media"].backdropcolor)
	end
	local shadow = CreateFrame("Frame", nil, f)
	shadow:SetFrameLevel(1)
	shadow:SetFrameStrata(f:GetFrameStrata())
	shadow:Point("TOPLEFT", -3, 3)
	shadow:Point("BOTTOMLEFT", -3, -3)
	shadow:Point("TOPRIGHT", 3, 3)
	shadow:Point("BOTTOMRIGHT", 3, -3)
	shadow:SetBackdrop( { 
		edgeFile = C["media"].glow, edgeSize = Z.Scale(3),
		insets = {left = Z.Scale(5), right = Z.Scale(5), top = Z.Scale(5), bottom = Z.Scale(5)},
	})
	shadow:SetBackdropColor(backdropr, backdropg, backdropb, 0)
	shadow:SetBackdropBorderColor(borderr, borderg, borderb, 0.8)
	f.shadow = shadow
end

local function Kill(object)
	if object.UnregisterAllEvents then
		object:UnregisterAllEvents()
	end
	object.Show = noop
	object:Hide()
end

local color = RAID_CLASS_COLORS[Z.myclass] -- did this for button hover, pushed
-- styleButton function authors are Chiril & Karudon.
local function StyleButton(b, c) 
    local name = b:GetName()
    local button          = _G[name]
    local icon            = _G[name.."Icon"]
    local count           = _G[name.."Count"]
    local border          = _G[name.."Border"]
    local hotkey          = _G[name.."HotKey"]
    local cooldown        = _G[name.."Cooldown"]
    local nametext        = _G[name.."Name"]
    local flash           = _G[name.."Flash"]
    local normaltexture   = _G[name.."NormalTexture"]
	local icontexture     = _G[name.."IconTexture"]
	
	local hover = b:CreateTexture("frame", nil, self) -- hover
	hover:SetTexture(color.r, color.g, color.b,0.3)
	hover:SetHeight(button:GetHeight())
	hover:SetWidth(button:GetWidth())
	hover:Point("TOPLEFT",button,2,-2)
	hover:Point("BOTTOMRIGHT",button,-2,2)
	button:SetHighlightTexture(hover)

	local pushed = b:CreateTexture("frame", nil, self) -- pushed
	pushed:SetTexture(.075,.075,.075,.9)
	pushed:SetHeight(button:GetHeight())
	pushed:SetWidth(button:GetWidth())
	pushed:Point("TOPLEFT",button,2,-2)
	pushed:Point("BOTTOMRIGHT",button,-2,2)
	button:SetPushedTexture(pushed)
 
	if c then
		local checked = b:CreateTexture("frame", nil, self) -- checked
		checked:SetTexture(color.r, color.g, color.b,.5)
		checked:SetHeight(button:GetHeight())
		checked:SetWidth(button:GetWidth())
		checked:Point("TOPLEFT",button,2,-2)
		checked:Point("BOTTOMRIGHT",button,-2,2)
		button:SetCheckedTexture(checked)
	end
end

local function FontString(parent, name, fontName, fontHeight, fontStyle)
	local fs = parent:CreateFontString(nil, "OVERLAY")
	fs:SetFont(fontName, fontHeight, fontStyle)
	fs:SetJustifyH("LEFT")
	fs:SetShadowColor(0, 0, 0)
	fs:SetShadowOffset(mult, -mult)
	if not name then
		parent.text = fs
	else
		parent[name] = fs
	end	
	return fs
end

local function addapi(object)
	local mt = getmetatable(object).__index
	mt.Size = Size
	mt.Point = Point
	mt.SetTemplate = SetTemplate
	mt.CreatePanel = CreatePanel
	mt.SetBorder = SetBorder -- hydra border
	mt.CreateShadow = CreateShadow
	mt.Kill = Kill
	mt.StyleButton = StyleButton
	mt.Width = Width
	mt.Height = Height
	mt.FontString = FontString
end

local handled = {["Frame"] = true}
local object = CreateFrame("Frame")
addapi(object)
addapi(object:CreateTexture())
addapi(object:CreateFontString())

object = EnumerateFrames()
while object do
	if not handled[object:GetObjectType()] then
		addapi(object)
		handled[object:GetObjectType()] = true
	end
	object = EnumerateFrames(object)
end

-- hydra slide in/out
local function Animate(self, x, y, duration)
	self.anim = self:CreateAnimationGroup("Move_In")
	self.anim.in1 = self.anim:CreateAnimation("Translation")
	self.anim.in1:SetDuration(0)
	self.anim.in1:SetOrder(1)
	self.anim.in2 = self.anim:CreateAnimation("Translation")
	self.anim.in2:SetDuration(duration)
	self.anim.in2:SetOrder(2)
	self.anim.in2:SetSmoothing("OUT")
	self.anim.out1 = self:CreateAnimationGroup("Move_Out")
	self.anim.out2 = self.anim.out1:CreateAnimation("Translation")
	self.anim.out2:SetDuration(duration)
	self.anim.out2:SetOrder(1)
	self.anim.out2:SetSmoothing("IN")
	self.anim.in1:SetOffset(Scale(x), Scale(y))
	self.anim.in2:SetOffset(Scale(-x), Scale(-y))
	self.anim.out2:SetOffset(Scale(x), Scale(y))
	self.anim.out1:SetScript("OnFinished", function() self:Hide() end)
end

Z.SetUpAnimGroup = function(self)
	self.anim = self:CreateAnimationGroup("Flash")
	self.anim.fadein = self.anim:CreateAnimation("ALPHA", "FadeIn")
	self.anim.fadein:SetChange(1)
	self.anim.fadein:SetOrder(2)

	self.anim.fadeout = self.anim:CreateAnimation("ALPHA", "FadeOut")
	self.anim.fadeout:SetChange(-1)
	self.anim.fadeout:SetOrder(1)
end

Z.Flash = function(self, duration)
	if not self.anim then
		Z.SetUpAnimGroup(self)
	end
	self.anim.fadein:SetDuration(duration)
	self.anim.fadeout:SetDuration(duration)
	self.anim:Play()
end

Z.StopFlash = function(self)
	if self.anim then
		self.anim:Finish()
	end
end

Z.SlideIn = function(self, duration)
  if not self.anim then
    local x = 0
    if self == ZuiChatBackgroundLeft or self == ZuiTabsLeftBackground then
      x = self:GetWidth()/2
    elseif self == ZuiChatBackgroundRight or self == ZuiTabsRightBackground then
      x = -self:GetWidth()/2
    end
		Animate(self, x, -self:GetHeight()/2, duration)
	end
	self.anim.out1:Stop()
	self:Show()
	self.anim:Play()
end

Z.SlideOut = function(self)
	if self.anim then
		self.anim:Finish()
	end

	self.anim:Stop()
	self.anim.out1:Play()
end

-- just for creating text
Z.SetFontString = function(parent, fontName, fontHeight, fontStyle)
	local fs = parent:CreateFontString(nil, "OVERLAY")
	fs:SetFont(fontName, fontHeight, fontStyle)
	fs:SetJustifyH("LEFT")
	fs:SetShadowColor(0, 0, 0)
	-- fs:SetShadowOffset(1.25, -1.25) -- dont need shadow
	return fs
end

-- datatext panel position
Z.SetDataText = function(p, obj)
	local left = ZuiInfoLeft
	local right = ZuiInfoRight
	local mapleft = ZuiMinimapStatsLeft
	local mapright = ZuiMinimapStatsRight
	local tabright = ZuiTabsRightBackground
	local pvedl = PveLeft
	local pvedr = PveRight
	
	if p == 1 then
		obj:SetParent(left)
		obj:SetHeight(left:GetHeight())
		obj:SetPoint("LEFT", left, 20, 0)
		obj:SetPoint('TOP', left, 0, 2)
		obj:SetPoint('BOTTOM', left)
	elseif p == 2 then
		obj:SetParent(left)
		obj:SetHeight(left:GetHeight())
		obj:SetPoint('TOP', left, 0, 2)
		obj:SetPoint('BOTTOM', left)
	elseif p == 3 then
		obj:SetParent(left)
		obj:SetHeight(left:GetHeight())
		obj:SetPoint("RIGHT", left, -20, 0)
		obj:SetPoint('TOP', left, 0, 2)
		obj:SetPoint('BOTTOM', left)
	elseif p == 4 then
		obj:SetParent(right)
		obj:SetHeight(right:GetHeight())
		obj:SetPoint("LEFT", right, 20, 0)
		obj:SetPoint('TOP', right, 0, 2)
		obj:SetPoint('BOTTOM', right)
	elseif p == 5 then
		obj:SetParent(right)
		obj:SetHeight(right:GetHeight())
		obj:SetPoint('TOP', right, 0, 2)
		obj:SetPoint('BOTTOM', right)
	elseif p == 6 then
		obj:SetParent(right)
		obj:SetHeight(right:GetHeight())
		obj:SetPoint("RIGHT", right, -20, 0)
		obj:SetPoint('TOP', right, 0, 2)
		obj:SetPoint('BOTTOM', right)
	elseif p == 7 then
		obj:SetParent(pvedl)
		obj:SetHeight(pvedl:GetHeight())
		obj:SetPoint("CENTER", pvedl, 0, 2)
	elseif p == 8 then
		obj:SetParent(pvedr)
		obj:SetHeight(pvedr:GetHeight())
		obj:SetPoint("CENTER", pvedr, 0, 2)
  elseif p == 9 and tabright then
    obj:SetParent(tabright)
		obj:SetHeight(tabright:GetHeight())
		obj:SetPoint("RIGHT", tabright, -20, 0)
		obj:SetPoint('TOP', tabright, 0, 2)
		obj:SetPoint('BOTTOM', tabright)
	end
end	

Z.DataTextTooltipAnchor = function(self)
	local panel = self:GetParent()
	local anchor = "ANCHOR_TOP"
	local xoff = 0
	local yoff = Z.Scale(3)
	
	if panel == ZuiInfoLeft then
		anchor = "ANCHOR_TOPLEFT"
	elseif panel == ZuiTabsRightBackground then
	    anchor = "ANCHOR_TOPRIGHT"
	elseif panel == ZuiInfoRight then
		anchor = "ANCHOR_TOPRIGHT"
	elseif panel == ZuiMinimapStatsLeft or panel == ZuiMinimapStatsRight then
	local position = ZuiMinimap:GetPoint()
		if position:match("LEFT") then
			anchor = "ANCHOR_BOTTOMRIGHT"
			yoff = Z.Scale(-6)
			xoff = 0 - ZuiMinimapStatsRight:GetWidth()
		elseif position:match("RIGHT") then
			anchor = "ANCHOR_BOTTOMLEFT"
			yoff = Z.Scale(-6)
			xoff = ZuiMinimapStatsRight:GetWidth()
		else
			anchor = "ANCHOR_BOTTOM"
			yoff = Z.Scale(-6)
		end
	end
	
	return anchor, panel, xoff, yoff
end

Z.ShiftBarUpdate = function()
	local numForms = GetNumShapeshiftForms()
	local texture, name, isActive, isCastable
	local button, icon, cooldown
	local start, duration, enable
	for i = 1, NUM_SHAPESHIFT_SLOTS do
		button = _G["ShapeshiftButton"..i]
		icon = _G["ShapeshiftButton"..i.."Icon"]
		if i <= numForms then
			texture, name, isActive, isCastable = GetShapeshiftFormInfo(i)
			icon:SetTexture(texture)
			
			cooldown = _G["ShapeshiftButton"..i.."Cooldown"]
			if texture then
				cooldown:SetAlpha(1)
			else
				cooldown:SetAlpha(0)
			end
			
			start, duration, enable = GetShapeshiftFormCooldown(i)
			CooldownFrame_SetTimer(cooldown, start, duration, enable)
			
			if isActive then
				ShapeshiftBarFrame.lastSelected = button:GetID()
				button:SetChecked(1)
			else
				button:SetChecked(0)
			end

			if isCastable then
				icon:SetVertexColor(1.0, 1.0, 1.0)
			else
				icon:SetVertexColor(0.4, 0.4, 0.4)
			end
		end
	end
end

Z.PetBarUpdate = function(self, event)
	local petActionButton, petActionIcon, petAutoCastableTexture, petAutoCastShine
	for i=1, NUM_PET_ACTION_SLOTS, 1 do
		local buttonName = "PetActionButton" .. i
		petActionButton = _G[buttonName]
		petActionIcon = _G[buttonName.."Icon"]
		petAutoCastableTexture = _G[buttonName.."AutoCastable"]
		petAutoCastShine = _G[buttonName.."Shine"]
		local name, subtext, texture, isToken, isActive, autoCastAllowed, autoCastEnabled = GetPetActionInfo(i)
		
		if not isToken then
			petActionIcon:SetTexture(texture)
			petActionButton.tooltipName = name
		else
			petActionIcon:SetTexture(_G[texture])
			petActionButton.tooltipName = _G[name]
		end
		
		petActionButton.isToken = isToken
		petActionButton.tooltipSubtext = subtext

		if isActive and name ~= "PET_ACTION_FOLLOW" then
			petActionButton:SetChecked(1)
			if IsPetAttackAction(i) then
				PetActionButton_StartFlash(petActionButton)
			end
		else
			petActionButton:SetChecked(0)
			if IsPetAttackAction(i) then
				PetActionButton_StopFlash(petActionButton)
			end			
		end
		
		if autoCastAllowed then
			petAutoCastableTexture:Show()
		else
			petAutoCastableTexture:Hide()
		end
		
		if autoCastEnabled then
			AutoCastShine_AutoCastStart(petAutoCastShine)
		else
			AutoCastShine_AutoCastStop(petAutoCastShine)
		end
		
		-- grid display
		if name then
			if not C["actionbar"].showgrid then
				petActionButton:SetAlpha(1)
			end			
		else
			if not C["actionbar"].showgrid then
				petActionButton:SetAlpha(0)
			end
		end
		
		if texture then
			if GetPetActionSlotUsable(i) then
				SetDesaturation(petActionIcon, nil)
			else
				SetDesaturation(petActionIcon, 1)
			end
			petActionIcon:Show()
		else
			petActionIcon:Hide()
		end
		
		-- between level 1 and 10 on cata, we don't have any control on Pet. (I lol'ed so hard)
		-- Setting desaturation on button to true until you learn the control on class trainer.
		-- you can at least control "follow" button.
		if not PetHasActionBar() and texture and name ~= "PET_ACTION_FOLLOW" and Z.isctm then
			PetActionButton_StopFlash(petActionButton)
			SetDesaturation(petActionIcon, 1)
			petActionButton:SetChecked(0)
		end
	end
end

-- Define action bar buttons size
Z.buttonsize = Z.Scale(C.actionbar.buttonsize)
Z.buttonspacing = Z.Scale(C.actionbar.buttonspacing)
Z.petbuttonsize = Z.Scale(C.actionbar.petbuttonsize)
Z.petbuttonspacing = Z.Scale(C.actionbar.buttonspacing)

Z.TotemBarOrientation = function(revert)
	local position = ZuiShiftBar:GetPoint()
	if position:match("TOP") then
		revert = true
	else
		revert = false
	end
	
	return revert
end

Z.Round = function(number, decimals)
	if not decimals then decimals = 0 end
    return (("%%.%df"):format(decimals)):format(number)
end

Z.RGBToHex = function(r, g, b)
	r = r <= 1 and r >= 0 and r or 0
	g = g <= 1 and g >= 0 and g or 0
	b = b <= 1 and b >= 0 and b or 0
	return string.format("|cff%02x%02x%02x", r*255, g*255, b*255)
end

--Check Player's Role 
if Z.isctm then -- we dont have this shit on WLK
  local RoleUpdater = CreateFrame("Frame")
  local function CheckRole(self, event, unit)
    local tree = GetPrimaryTalentTree()
    local resilience
    local resilperc = GetCombatRatingBonus(COMBAT_RATING_RESILIENCE_PLAYER_DAMAGE_TAKEN)
    if resilperc > GetDodgeChance() and resilperc > GetParryChance() then
      resilience = true
    else
      resilience = false
    end
    if ((Z.myclass == "PALADIN" and tree == 2) or
    (Z.myclass == "WARRIOR" and tree == 3) or
    (Z.myclass == "DEATHKNIGHT" and tree == 1)) and
    resilience == false or
    (Z.myclass == "DRUID" and tree == 2 and GetBonusBarOffset() == 3) then
      Z.role = "Tank"
    else
      local playerint = select(2, UnitStat("player", 4))
      local playeragi	= select(2, UnitStat("player", 2))
      local base, posBuff, negBuff = UnitAttackPower("player");
      local playerap = base + posBuff + negBuff;

      if (((playerap > playerint) or (playeragi > playerint)) and not (Z.myclass == "SHAMAN" and tree ~= 1 and tree ~= 3) and not (UnitBuff("player", GetSpellInfo(24858)) or UnitBuff("player", GetSpellInfo(65139)))) or Z.myclass == "ROGUE" or Z.myclass == "HUNTER" or (Z.myclass == "SHAMAN" and tree == 2) then
        T.role = "Melee"
      else
        T.role = "Caster"
      end
    end
  end
  RoleUpdater:RegisterEvent("PLAYER_ENTERING_WORLD")
  RoleUpdater:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
  RoleUpdater:RegisterEvent("PLAYER_TALENT_UPDATE")
  RoleUpdater:RegisterEvent("CHARACTER_POINTS_CHANGED")
  RoleUpdater:RegisterEvent("UNIT_INVENTORY_CHANGED")
  RoleUpdater:RegisterEvent("UPDATE_BONUS_ACTIONBAR")
  RoleUpdater:SetScript("OnEvent", CheckRole)
  CheckRole()
end

--Return short value of a number
Z.ShortValue = function(v)
	if v >= 1e6 then
		return ("%.1fm"):format(v / 1e6):gsub("%.?0+([km])$", "%1")
	elseif v >= 1e3 or v <= -1e3 then
		return ("%.1fk"):format(v / 1e3):gsub("%.?0+([km])$", "%1")
	else
		return v
	end
end

Z.ShortValueNegative = function(v)
	if v <= 999 then return v end
	if v >= 1000000 then
		local value = string.format("%.1fm", v/1000000)
		return value
	elseif v >= 1000 then
		local value = string.format("%.1fk", v/1000)
		return value
	end
end