------------------------------------------------------------------------
--	Colors
------------------------------------------------------------------------
local Z, C, L = unpack(select(2, ...)) -- Import Functions/Constants, Config, Locales

local _, ns = ...
local oUF = zUF or ns.oUF or oUF
assert(oUF, "Zui was unable to locate oUF.")

table.remove(C["unitframes"].healthcolor,4) -- We don't need alpha from here on (hacky).
Z.oUF_colors = setmetatable({
	tapped = Z.colors.tapped,
	disconnected = Z.colors.disconnected,
	health = C["unitframes"].healthcolor,
	power = setmetatable({
		["MANA"] = Z.colors.power.MANA,
		["RAGE"] = Z.colors.power.RAGE,
		["FOCUS"] = Z.colors.power.FOCUS,
		["ENERGY"] = Z.colors.power.ENERGY,
		["RUNES"] = Z.colors.power.RUNES,
		["RUNIC_POWER"] = Z.colors.power.RUNIC_POWER,
		["AMMOSLOT"] = Z.colors.power.AMMOSLOT,
		["FUEL"] = Z.colors.power.FUEL,
		["POWER_TYPE_STEAM"] = Z.colors.power.POWER_TYPE_STEAM,
		["POWER_TYPE_PYRITE"] = Z.colors.power.POWER_TYPE_PYRITE,
	}, {__index = oUF.colors.power}),
	happiness = setmetatable({
		[1] = Z.colors.happiness[1],
		[2] = Z.colors.happiness[2],
		[3] = Z.colors.happiness[3],
	}, {__index = oUF.colors.happiness}),
	runes = setmetatable({
			[1] = Z.colors.runes[1],
			[2] = Z.colors.runes[2],
			[3] = Z.colors.runes[3],
			[4] = Z.colors.runes[4],
	}, {__index = oUF.colors.runes}),
	reaction = setmetatable({
		[1] = Z.colors.reaction[1], -- Hated
		[2] = Z.colors.reaction[2], -- Hostile
		[3] = Z.colors.reaction[3], -- Unfriendly
		[4] = Z.colors.reaction[4], -- Neutral
		[5] = Z.colors.reaction[5], -- Friendly
		[6] = Z.colors.reaction[6], -- Honored
		[7] = Z.colors.reaction[7], -- Revered
		[8] = Z.colors.reaction[8], -- Exalted	
	}, {__index = oUF.colors.reaction}),
	class = setmetatable({
		["DEATHKNIGHT"] = Z.colors.class.DEATHKNIGHT,
		["DRUID"]       = Z.colors.class.DRUID,
		["HUNTER"]      = Z.colors.class.HUNTER,
		["MAGE"]        = Z.colors.class.MAGE,
		["PALADIN"]     = Z.colors.class.PALADIN,
		["PRIEST"]      = Z.colors.class.PRIEST,
		["ROGUE"]       = Z.colors.class.ROGUE,
		["SHAMAN"]      = Z.colors.class.SHAMAN,
		["WARLOCK"]     = Z.colors.class.WARLOCK,
		["WARRIOR"]     = Z.colors.class.WARRIOR,
	}, {__index = oUF.colors.class}),
	smooth = setmetatable({
		1, 0, 0,
		1, 1, 0,
		 .23,.23, .23
	}, {__index = oUF.colors.smooth}),
	
}, {__index = oUF.colors})