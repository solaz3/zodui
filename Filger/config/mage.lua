local Z, C, L = unpack(Zodui) -- Import:Z - functions, constants, variables; C - config; L - locales

if Z.myclass ~= "MAGE" then return end

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

ns.Filger_Spells["MAGE"] = {
		{
			Name = "P_PROC_ICON",
			Direction = "LEFT",
			Interval = 4,
			Mode = "ICON",
			setPoint = { "CENTER", UIParent, "CENTER", 2, -120 },

			-- Frostbite
			--{ spellID = 11071, size = 28, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Winter's Chill
			{ spellID = 28593, size = 28, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Fingers of Frost
			{ spellID = 44544, size = 28, unitId = "player", caster = "player", filter = "BUFF" },
			-- Fireball!
			{ spellID = 57761, size = 28, unitId = "player", caster = "player", filter = "BUFF" },
			-- Hot Streak
			{ spellID = 44445, size = 28, unitId = "player", caster = "player", filter = "BUFF" },
			-- Missile Barrage
			{ spellID = 54486, size = 28, unitId = "player", caster = "player", filter = "BUFF" },
			-- Clearcasting
			{ spellID = 12536, size = 28, unitId = "player", caster = "player", filter = "BUFF" },
			-- Impact
			{ spellID = 12358, size = 28, unitId = "player", caster = "player", filter = "BUFF" },
		},
    
		{
			Name = "T_DEBUFF_ICON",
			Direction = "RIGHT",
			Interval = 4,
			Mode = "ICON",
			setPoint = { "LEFT", UIParent, "CENTER", 70, -40 },

			-- Polymorph
			{ spellID = 118, size = 26, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Arcane Blast
			{ spellID = 36032, size = 26, unitId = "player", caster = "player", filter = "DEBUFF" },
			-- Improved Scorch
			{ spellID = 11367, size = 26, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Scorch
			{ spellID = 2948, size = 26, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Slow
			{ spellID = 31589, size = 26, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Ignite
			{ spellID = 11119, size = 26, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Living Bomb
			{ spellID = 44457, size = 26, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Pyroblast!
			--{ spellID = 92315, size = 26, unitId = "player", caster = "player", filter = "DEBUFF" },
		},
    
		{
			Name = "F_DEBUFF_BAR",
			Direction = "UP",
			IconSide = "LEFT",
			Interval = 4,
			Mode = "BAR",
			setPoint = { "CENTER", UIParent, "CENTER", 240, 60 },

			-- Polymorph
			{ spellID = 118, size = 20, barWidth = 150, unitId = "focus", caster = "all", filter = "DEBUFF" },
		},
}