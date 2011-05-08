local Z, C, L = unpack(Zodui) -- Import:Z - functions, constants, variables; C - config; L - locales

if Z.myclass ~= "WARRIOR" then return end

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

ns.Filger_Spells["WARRIOR"] = {
		{
			Name = "P_PROC_ICON",
			Direction = "LEFT",
			Interval = 4,
			Mode = "ICON",
			setPoint = { "CENTER", UIParent, "CENTER", 2, -120 },

			-- Sudden Death
			{ spellID = 52437, size = 28, unitId = "player", caster = "player", filter = "BUFF" },
			-- Slam!
			{ spellID = 46916, size = 28, unitId = "player", caster = "all", filter = "BUFF" },
			-- Sword and Board
			{ spellID = 50227, size = 28, unitId = "player", caster = "player", filter = "BUFF" },
			-- Blood Reserve
			{ spellID = 64568, size = 28, unitId = "player", caster = "player", filter = "BUFF" },
			-- Spell Reflection/Zauberreflexion
			{ spellID = 23920, size = 28, unitId = "player", caster = "player", filter = "BUFF" },
			-- Victory Rush/Siegesrausch
			{ spellID = 34428, size = 28, unitId = "player", caster = "player", filter = "BUFF" },
			-- Shield Block/Schildblock
			{ spellID = 2565, size = 28, unitId = "player", caster = "player", filter = "BUFF" },
			-- Last Stand
			{ spellID = 12975, size = 28, unitId = "player", caster = "player", filter = "BUFF" },
			-- Shield Wall
			{ spellID = 871, size = 28, unitId = "player", caster = "player", filter = "BUFF" },
		},
    
		{
			Name = "T_DEBUFF_ICON",
			Direction = "RIGHT",
			Interval = 4,
			Mode = "ICON",
			setPoint = { "LEFT", UIParent, "CENTER", 70, -40 },

			-- Charge Stun/Sturmangriffsbetäubung
			{ spellID = 7922, size = 26, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Shockwave
			{ spellID = 46968, size = 26, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Hamstring
			{ spellID = 1715, size = 26, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Rend
			--{ spellID = 94009, size = 26, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Sunder Armor
			{ spellID = 7386, size = 26, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Expose Armor
			--{ spellID = 48669, size = 26, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Thunder Clap
			{ spellID = 6343, size = 26, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Infected Wounds
			{ spellID = 48484, size = 26, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Frost Fever
			{ spellID = 55095, size = 26, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Demoralizing Shout
			{ spellID = 1160, size = 26, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Demoralizing Roar
			{ spellID = 99, size = 26, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Curse of Weakness
			{ spellID = 702, size = 26, unitId = "target", caster = "all", filter = "DEBUFF" },
		},
}