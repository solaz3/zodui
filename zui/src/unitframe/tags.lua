local Z, C, L = unpack(select(2, ...)) -- Import Functions/Constants, Config, Locales
local oUF = zUF or ns.oUF or oUF
assert(oUF, "Zui was unable to locate oUF.")

------------------------------------------------------------------------
--	Tags
------------------------------------------------------------------------
oUF.TagEvents['Zui:threat'] = 'UNIT_THREAT_LIST_UPDATE'
oUF.Tags['Zui:threat'] = function(unit)
	local tanking, status, percent = UnitDetailedThreatSituation('player', 'target')
	if(percent and percent > 0) then
		return ('%s%d%%|r'):format(Hex(GetThreatStatusColor(status)), percent)
	end
end

oUF.Tags['Zui:health'] = function(unit)
	if not unit then return end
	local min, max = UnitHealth(unit), UnitHealthMax(unit)
	local status = not UnitIsConnected(unit) and 'Offline' or UnitIsGhost(unit) and 'Ghost' or UnitIsDead(unit) and 'Dead'

	if(status) then
		return status
	elseif(unit == 'target' and UnitCanAttack('player', unit)) then
		return ('%s (%d|cff0090ff%%|r)'):format(Z.ShortValue(min), min / max * 100)
	elseif(unit == 'player' and min ~= max) then
		return ('|cffff8080%d|r %d|cff0090ff%%|r'):format(min - max, min / max * 100)
	elseif(min ~= max) then
		return ('%s |cff0090ff/|r %s'):format(Z.ShortValue(min), Z.ShortValue(max))
	else
		return max
	end
end

oUF.Tags['Zui:power'] = function(unit)
	if not unit then return end
	local power = UnitPower(unit)
	if(power > 0 and not UnitIsDeadOrGhost(unit)) then
		local _, type = UnitPowerType(unit)
		local colors = _COLORS.power
		return ('%s%d|r'):format(Hex(colors[type] or colors['RUNES']), power)
	end
end

oUF.Tags['Zui:druid'] = function(unit)
	if not unit then return end
	local min, max = UnitPower(unit, 0), UnitPowerMax(unit, 0)
	if(UnitPowerType(unit) ~= 0 and min ~= max) then
		return ('|cff0090ff%d%%|r'):format(min / max * 100)
	end
end

oUF.TagEvents['Zui:diffcolor'] = 'UNIT_LEVEL'
oUF.Tags['Zui:diffcolor'] = function(unit)
	if not unit then return end
	local r, g, b
	local level = UnitLevel(unit)
	if (level < 1) then
		r, g, b = 0.69, 0.31, 0.31
	else
		local DiffColor = UnitLevel('target') - UnitLevel('player')
		if (DiffColor >= 5) then
			r, g, b = 0.69, 0.31, 0.31
		elseif (DiffColor >= 3) then
			r, g, b = 0.71, 0.43, 0.27
		elseif (DiffColor >= -2) then
			r, g, b = 0.84, 0.75, 0.65
		elseif (-DiffColor <= GetQuestGreenRange()) then
			r, g, b = 0.33, 0.59, 0.33
		else
			r, g, b = 0.55, 0.57, 0.61
		end
	end
	return string.format('|cff%02x%02x%02x', r * 255, g * 255, b * 255)
end

local utf8sub = function(string, i, dots)
	if not string then return end
	local bytes = string:len()
	if (bytes <= i) then
		return string
	else
		local len, pos = 0, 1
		while(pos <= bytes) do
			len = len + 1
			local c = string:byte(pos)
			if (c > 0 and c <= 127) then
				pos = pos + 1
			elseif (c >= 192 and c <= 223) then
				pos = pos + 2
			elseif (c >= 224 and c <= 239) then
				pos = pos + 3
			elseif (c >= 240 and c <= 247) then
				pos = pos + 4
			end
			if (len == i) then break end
		end

		if (len == i and pos <= bytes) then
			return string:sub(1, pos - 1)..(dots and '...' or '')
		else
			return string
		end
	end
end


oUF.TagEvents['Zui:getnamecolor'] = 'UNIT_POWER'
oUF.Tags['Zui:getnamecolor'] = function(unit)
	if not unit then return end
	local reaction = UnitReaction(unit, 'player')
	if (unit == 'pet' and GetPetHappiness()) then
		local c = Z.oUF_colors.happiness[GetPetHappiness()]
		return string.format('|cff%02x%02x%02x', c[1] * 255, c[2] * 255, c[3] * 255)
	elseif (UnitIsPlayer(unit)) then
		return _TAGS['raidcolor'](unit)
	elseif (reaction) then
		local c = Z.oUF_colors.reaction[reaction]
		return string.format('|cff%02x%02x%02x', c[1] * 255, c[2] * 255, c[3] * 255)
	else
		r, g, b = .84,.75,.65
		return string.format('|cff%02x%02x%02x', r * 255, g * 255, b * 255)
	end
end

oUF.TagEvents['Zui:nameshort'] = 'UNIT_NAME_UPDATE'
oUF.Tags['Zui:nameshort'] = function(unit)
	if not unit then return end
	local name = UnitName(unit)
	local colorblind = GetCVarBool("colorblindMode")
	if colorblind ~= 1 then
		return utf8sub(name, 4, false)
	else
		if (UnitIsPlayer(unit)) then
			local class = select(2, UnitClass(unit))
			local texcoord = CLASS_BUTTONS[class]
			return (utf8sub((name), 4, false)).." |TInterface\\WorldStateFrame\\Icons-Classes:25:25:0:0:256:256:"..tostring(texcoord[1]*256)..":"..tostring(texcoord[2]*256)..":"..tostring(texcoord[3]*256)..":"..tostring(texcoord[4]*256).."|t"
		else
			return utf8sub(name, 4, false)
		end
	end
end

oUF.TagEvents['Zui:namemedium'] = 'UNIT_NAME_UPDATE'
oUF.Tags['Zui:namemedium'] = function(unit)
	if not unit then return end
	local name = UnitName(unit)
	local colorblind = GetCVarBool("colorblindMode")
	if colorblind ~= 1 then
		return utf8sub(name, 6, false)
	else
		if (UnitIsPlayer(unit)) then
			local class = select(2, UnitClass(unit))
			local texcoord = CLASS_BUTTONS[class]
			return (utf8sub((name), 6, false)).." |TInterface\\WorldStateFrame\\Icons-Classes:25:25:0:0:256:256:"..tostring(texcoord[1]*256)..":"..tostring(texcoord[2]*256)..":"..tostring(texcoord[3]*256)..":"..tostring(texcoord[4]*256).."|t"
		else
			return utf8sub(name, 6, false)
		end
	end
end

oUF.TagEvents['Zui:namelong'] = 'UNIT_NAME_UPDATE'
oUF.Tags['Zui:namelong'] = function(unit)
	if not unit then return end
	local name = UnitName(unit)
	local colorblind = GetCVarBool("colorblindMode")
	if colorblind ~= 1 then
		return utf8sub(name, 20, false)
	else
		if (UnitIsPlayer(unit)) then
			local class = select(2, UnitClass(unit))
			local texcoord = CLASS_BUTTONS[class]
			return (utf8sub((name), 20, false)).." |TInterface\\WorldStateFrame\\Icons-Classes:25:25:0:0:256:256:"..tostring(texcoord[1]*256)..":"..tostring(texcoord[2]*256)..":"..tostring(texcoord[3]*256)..":"..tostring(texcoord[4]*256).."|t"
		else
			return utf8sub(name, 20, false)
		end
	end
end