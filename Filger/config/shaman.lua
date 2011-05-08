local Z, C, L = unpack(Zodui) -- Import:Z - functions, constants, variables; C - config; L - locales

if Z.myclass ~= "SHAMAN" then return end

local _, ns = ...

--[[ CD-Example
		{
			Name = "COOLDOWN",
			Direction = "RIGHT",
			Interval = 4,
			Mode = "ICON",
			setPoint = { "CENTER", UIParent, "CENTER", 0, -100 },

			-- Wild Growth/Wildwuchs
			{ spellID = 48438, size = 32, filter = "CD" },
		},
]]

ns.Filger_Spells["SHAMAN"] = {
		{
			Name = "P_BUFF_ICON",
			Direction = "LEFT",
			Interval = 4,
			Mode = "ICON",
			setPoint = { "RIGHT", UIParent, "CENTER", -70, -80 },

			-- Earth Shield/Erdschild
			{ spellID = 974, size = 28, unitId = "player", caster = "player", filter = "BUFF" },
			-- Riptide/Springflut
			{ spellID = 61295, size = 28, unitId = "player", caster = "player", filter = "BUFF" },
			-- Lightning Shield/Blitzschlagschild
			{ spellID = 324, size = 28, unitId = "player", caster = "player", filter = "BUFF" },
			-- Water Shield/Wasserschild
			{ spellID = 52127, size = 28, unitId = "player", caster = "player", filter = "BUFF" },
		},
    
		{
			Name = "T_BUFF_ICON",
			Direction = "RIGHT",
			Interval = 4,
			Mode = "ICON",
			setPoint = { "LEFT", UIParent, "CENTER", 70, 20 },

			-- Earth Shield/Erdschild
			{ spellID = 974, size = 26, unitId = "target", caster = "player", filter = "BUFF" },
			-- Riptide/Springflut
			{ spellID = 61295, size = 26, unitId = "target", caster = "player", filter = "BUFF" },
		},
    
		{
			Name = "P_PROC_ICON",
			Direction = "LEFT",
			Interval = 4,
			Mode = "ICON",
			setPoint = { "CENTER", UIParent, "CENTER", 2, -120 },

			-- Maelstorm Weapon
			{ spellID = 53817, size = 28, unitId = "player", caster = "player", filter = "BUFF" },
			-- Shamanistic Rage
			{ spellID = 30823, size = 28, unitId = "player", caster = "player", filter = "BUFF" },
			-- Clearcasting
			{ spellID = 16246, size = 28, unitId = "player", caster = "player", filter = "BUFF" },
			-- Tidal Waves
			{ spellID = 51562, size = 28, unitId = "player", caster = "player", filter = "BUFF" },
			-- Ancestral Fortitude
			{ spellID = 16236, size = 28, barWidth = 187, unitId = "target", caster = "player", filter = "BUFF" },
		},
    
		{
			Name = "T_DEBUFF_ICON",
			Direction = "RIGHT",
			Interval = 4,
			Mode = "ICON",
			setPoint = { "LEFT", UIParent, "CENTER", 70, -40 },

			-- Hex
			{ spellID = 51514, size = 26, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Storm Strike
			{ spellID = 17364, size = 26, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Earth Shock
			{ spellID = 8042, size = 26, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Frost Shock
			{ spellID = 8056, size = 26, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Flame Shock
			{ spellID = 8050, size = 26, unitId = "target", caster = "player", filter = "DEBUFF" },
		},
    
		{
			Name = "F_DEBUFF_BAR",
			Direction = "UP",
			IconSide = "LEFT",
			Interval = 4,
			Mode = "BAR",
			setPoint = { "CENTER", UIParent, "CENTER", 240, 60 },

			-- Hex
			{ spellID = 51514, size = 20, barWidth = 150, unitId = "focus", caster = "all", filter = "DEBUFF" },
		},
}