local Z, C, L = unpack(select(2, ...)) -- Import:Z - functions, constants, variables; C - config; L - locales

if not C["buff"].enable then return end

local ZuiPlayerBuffs = CreateFrame("Frame", "ZuiPlayerBuffs", UIParent)
ZuiPlayerBuffs:Width(300)
ZuiPlayerBuffs:Height(94)
ZuiPlayerBuffs:SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", -155, -5)
ZuiPlayerBuffs:SetTemplate("Default")
ZuiPlayerBuffs:SetBackdropBorderColor(1, 0, 0)
ZuiPlayerBuffs:SetClampedToScreen(true)
ZuiPlayerBuffs:SetMovable(true)
ZuiPlayerBuffs:SetAlpha(0)
ZuiPlayerBuffs.text = Z.SetFontString(ZuiPlayerBuffs, C.media.font, 12, "THINOUTLINE")
ZuiPlayerBuffs.text:SetPoint("CENTER")
ZuiPlayerBuffs.text:SetText(L.move_buffs)

local ZuiPlayerDebuffs = CreateFrame("Frame", "ZuiPlayerDebuffs", UIParent)
ZuiPlayerDebuffs:Width(300)
ZuiPlayerDebuffs:Height(47)
ZuiPlayerDebuffs:SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", -155, -105)
ZuiPlayerDebuffs:SetTemplate("Default")
ZuiPlayerDebuffs:SetBackdropBorderColor(1, 0, 0)
ZuiPlayerDebuffs:SetClampedToScreen(true)
ZuiPlayerDebuffs:SetMovable(true)
ZuiPlayerDebuffs:SetAlpha(0)
ZuiPlayerDebuffs.text = Z.SetFontString(ZuiPlayerDebuffs, C.media.font, 12, "THINOUTLINE")
ZuiPlayerDebuffs.text:SetPoint("CENTER")
ZuiPlayerDebuffs.text:SetText(L.move_debuffs)

ConsolidatedBuffs:ClearAllPoints()
ConsolidatedBuffs:SetPoint("LEFT", ZuiMinimap, "LEFT", 2, 0)
ConsolidatedBuffs:SetSize(16, 16)
ConsolidatedBuffsIcon:SetTexture(nil)
ConsolidatedBuffs.SetPoint = Z.dummy

local mainhand, _, _, offhand = GetWeaponEnchantInfo()
local rowbuffs = 16

TemporaryEnchantFrame:ClearAllPoints()
TemporaryEnchantFrame:SetPoint("TOPRIGHT", ZuiPlayerBuffs, "TOPRIGHT", 0, 0)
TemporaryEnchantFrame.SetPoint = Z.dummy

TempEnchant1:ClearAllPoints()
TempEnchant2:ClearAllPoints()
TempEnchant1:SetPoint("TOPRIGHT", ZuiPlayerBuffs, "TOPRIGHT", -8, 0)
TempEnchant2:SetPoint("RIGHT", TempEnchant1, "LEFT", -4, 0)

WorldStateAlwaysUpFrame:SetFrameStrata("BACKGROUND")
WorldStateAlwaysUpFrame:SetFrameLevel(0)

for i = 1, 2 do
	local f = CreateFrame("Frame", nil, _G["TempEnchant"..i])
	f:CreatePanel("Default", 30, 30, "CENTER", _G["TempEnchant"..i], "CENTER", 0, 0)	
	_G["TempEnchant"..i.."Border"]:Hide()
	_G["TempEnchant"..i.."Icon"]:SetTexCoord(.08, .92, .08, .92)
	_G["TempEnchant"..i.."Icon"]:SetPoint("TOPLEFT", _G["TempEnchant"..i], 2, -2)
	_G["TempEnchant"..i.."Icon"]:SetPoint("BOTTOMRIGHT", _G["TempEnchant"..i], -2, 2)
	_G["TempEnchant"..i]:SetHeight(30)
	_G["TempEnchant"..i]:SetWidth(30)
	_G["TempEnchant"..i.."Duration"]:ClearAllPoints()
	_G["TempEnchant"..i.."Duration"]:SetPoint("BOTTOM", 0, -11)
	_G["TempEnchant"..i.."Duration"]:SetFont(C.media.pxfont, 12, "MONOCHROMEOUTLINE")
end

local function StyleBuffs(buttonName, index, debuff)
	local buff		= _G[buttonName..index]
	local icon		= _G[buttonName..index.."Icon"]
	local border	= _G[buttonName..index.."Border"]
	local duration	= _G[buttonName..index.."Duration"]
	local count 	= _G[buttonName..index.."Count"]
	if icon and not _G[buttonName..index.."Panel"] then
		icon:SetTexCoord(.08, .92, .08, .92)
		icon:SetPoint("TOPLEFT", buff, 2, -2)
		icon:SetPoint("BOTTOMRIGHT", buff, -2, 2)
		
		buff:SetHeight(30)
		buff:SetWidth(30)
				
		duration:ClearAllPoints()
		duration:SetPoint("BOTTOM", 0, -11)
		duration:SetFont(C.media.pxfont, 12, "OUTLINEMONOCHROME")
		
		count:ClearAllPoints()
		count:SetPoint("TOPLEFT", 1, -2)
		count:SetFont(C.media.pxfont, 12, "OUTLINEMONOCHROME")
		
		local panel = CreateFrame("Frame", buttonName..index.."Panel", buff)
		panel:CreatePanel("Default", 30, 30, "CENTER", buff, "CENTER", 0, 0)
		panel:SetFrameLevel(buff:GetFrameLevel() - 1)
		panel:SetFrameStrata(buff:GetFrameStrata())
	end
	if border then border:Hide() end
end

local function UpdateBuffAnchors()
	buttonName = "BuffButton"
	local buff, previousBuff, aboveBuff;
	local numBuffs = 0;
	for i=1, BUFF_ACTUAL_DISPLAY do
		local buff = _G[buttonName..i]
		StyleBuffs(buttonName, i, false)
		
		-- Leaving this here just in case someone want to use it
		-- This enable buff border coloring according to Type
		--[[
		local dtype = select(5, UnitBuff("player",index))		
		local color
		if (dtype ~= nil) then
			color = DebuffTypeColor[dtype]
		else
			color = DebuffTypeColor["none"]
		end
		_G[buttonName..i.."Panel"]:SetBackdropBorderColor(color.r * 0.6, color.g * 0.6, color.b * 0.6)
		--]]
		
		if ( buff.consolidated ) then
			if ( buff.parent == BuffFrame ) then
				buff:SetParent(ConsolidatedBuffsContainer)
				buff.parent = ConsolidatedBuffsContainer
			end
		else
			numBuffs = numBuffs + 1
			buff:ClearAllPoints()
			if ( (numBuffs > 1) and (mod(numBuffs, rowbuffs) == 1) ) then
				if ( numBuffs == rowbuffs+1 ) then
					buff:SetPoint("TOPRIGHT", ZuiPlayerBuffs, "TOPRIGHT", -8, -60)
				else
					buff:SetPoint("TOPRIGHT", ZuiPlayerBuffs, "TOPRIGHT", -8, 0)
				end
				aboveBuff = buff;
			elseif ( numBuffs == 1 ) then
				local mainhand, _, _, offhand, _, _, hand3 = GetWeaponEnchantInfo()
					if (mainhand and offhand and hand3) and not UnitHasVehicleUI("player") then
						buff:SetPoint("RIGHT", TempEnchant3, "LEFT", -4, 0)
					elseif ((mainhand and offhand) or (mainhand and hand3) or (offhand and hand3)) and not UnitHasVehicleUI("player") then
						buff:SetPoint("RIGHT", TempEnchant2, "LEFT", -4, 0)
					elseif ((mainhand and not offhand and not hand3) or (offhand and not mainhand and not hand3) or (hand3 and not mainhand and not offhand)) and not UnitHasVehicleUI("player") then
						buff:SetPoint("RIGHT", TempEnchant1, "LEFT", -4, 0)
					else
						buff:SetPoint("TOPRIGHT", ZuiPlayerBuffs, "TOPRIGHT", -8, 0)
					end
			else
				buff:SetPoint("RIGHT", previousBuff, "LEFT", -4, 0)
			end
			previousBuff = buff
		end		
	end
end

local function UpdateDebuffAnchors(buttonName, index)
	local debuff = _G[buttonName..index];
	StyleBuffs(buttonName, index, true)
	local dtype = select(5, UnitDebuff("player",index))      
	local color
	if (dtype ~= nil) then
		color = DebuffTypeColor[dtype]
	else
		color = DebuffTypeColor["none"]
	end
	_G[buttonName..index.."Panel"]:SetBackdropBorderColor(color.r * 0.6, color.g * 0.6, color.b * 0.6)
	debuff:ClearAllPoints()
	if index == 1 then
		debuff:SetPoint("TOPRIGHT", ZuiPlayerDebuffs, "TOPRIGHT", -8, 0)
	else
		debuff:SetPoint("RIGHT", _G[buttonName..(index-1)], "LEFT", -4, 0)
	end
end

local FormatTime = function(s)
	local day, hour, minute = 86400, 3600, 60
	if s >= day then
		return format("%d"..hexa.." d|r", ceil(s / day))
	elseif s >= hour then
		return format("%d"..hexa.." h|r", ceil(s / hour))
	elseif s >= minute then
		return format("%d"..hexa.." m|r", ceil(s / minute))
	elseif s >= minute / 12 then
		return floor(s)
	end
	return format("%.1f", s)
end

local function UpdateTime(button, timeLeft)
	local duration = _G[button:GetName().."Duration"]
	if SHOW_BUFF_DURATIONS == "1" and timeLeft then    
		if (timeLeft < 3600 and timeLeft >= 60) then
			local m = floor(timeLeft / 60 + 1)
			duration:SetFormattedText("|cffcccccc%d"..hexa.."m|r", m);
		elseif (timeLeft < 60 and timeLeft > 10 ) then
			duration:SetFormattedText("|cffE8D911%d"..hexa.."s|r", timeLeft);
    elseif timeLeft <= 10 then
      duration:SetFormattedText("|cffff0000%d"..hexa.."s|r", timeLeft)
		else
			local h = floor(timeLeft / 3600 + 1)
			duration:SetFormattedText("|cffcccccc%d"..hexa.."h|r", h);
		end
	end
end

local f = CreateFrame("Frame")
f:SetScript("OnEvent", function() mainhand, _, _, offhand = GetWeaponEnchantInfo() end)
f:RegisterEvent("UNIT_INVENTORY_CHANGED")
f:RegisterEvent("PLAYER_EVENTERING_WORLD")

hooksecurefunc("BuffFrame_UpdateAllBuffAnchors", UpdateBuffAnchors)
hooksecurefunc("DebuffButton_UpdateAnchors", UpdateDebuffAnchors)
hooksecurefunc("AuraButton_UpdateDuration", UpdateTime)