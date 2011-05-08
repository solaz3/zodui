local Z, C, L = unpack(Zodui) -- Import:Z - functions, constants, variables; C - config; L - locales

if Z.myclass ~= "PRIEST" then return end

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

ns.Filger_Spells["PRIEST"] = {
		{
			Name = "P_BUFF_ICON",
			Direction = "LEFT",
			Interval = 4,
			Mode = "ICON",
			setPoint = { "RIGHT", UIParent, "CENTER", -70, -80 },

			-- Prayer of Mending/Gebet der Besserung
			{ spellID = 41637, size = 28, unitId = "player", caster = "player", filter = "BUFF" },
			-- Guardian Spirit/Schutzgeist
			{ spellID = 47788, size = 28, unitId = "player", caster = "player", filter = "BUFF" },
			-- Pain Suppression/Schmerzunterdrückung
			{ spellID = 33206, size = 28, unitId = "player", caster = "player", filter = "BUFF" },
			-- Power Word: Shield/Machtwort: Schild
			{ spellID = 17, size = 28, unitId = "player", caster = "player", filter = "BUFF" },
			-- Renew/Erneuerung
			{ spellID = 139, size = 28, unitId = "player", caster = "player", filter = "BUFF" },
			-- Fade/Verblassen
			{ spellID = 586, size = 28, unitId = "player", caster = "player", filter = "BUFF" },
			-- Fear Ward/Furchtzauberschutz
			{ spellID = 6346, size = 28, unitId = "player", caster = "player", filter = "BUFF" },
			-- Inner Fire/Inneres Feuer
			{ spellID = 588, size = 28, unitId = "player", caster = "player", filter = "BUFF" },
		},
    
		{
			Name = "T_BUFF_ICON",
			Direction = "RIGHT",
			Interval = 4,
			Mode = "ICON",
			setPoint = { "LEFT", UIParent, "CENTER", 70, 20 },

			-- Prayer of Mending/Gebet der Besserung
			{ spellID = 41637, size = 26, unitId = "target", caster = "player", filter = "BUFF" },
			-- Guardian Spirit/Schutzgeist
			{ spellID = 47788, size = 26, unitId = "target", caster = "player", filter = "BUFF" },
			-- Pain Suppression/Schmerzunterdrückung
			{ spellID = 33206, size = 26, unitId = "target", caster = "player", filter = "BUFF" },
			-- Power Word: Shield/Machtwort: Schild
			{ spellID = 17, size = 26, unitId = "target", caster = "player", filter = "BUFF" },
			-- Renew/Erneuerung
			{ spellID = 139, size = 26, unitId = "target", caster = "player", filter = "BUFF" },
			-- Fear Ward/Furchtzauberschutz
			{ spellID = 6346, size = 26, unitId = "target", caster = "player", filter = "BUFF" },
		},
    
		{
			Name = "P_PROC_ICON",
			Direction = "LEFT",
			Interval = 4,
			Mode = "ICON",
			setPoint = { "CENTER", UIParent, "CENTER", 2, -120 },

			-- Surge of Light
			{ spellID = 33151, size = 28, unitId = "player", caster = "all", filter = "BUFF" },
			-- Serendipity
			{ spellID = 63730, size = 28, unitId = "player", caster = "player", filter = "BUFF" },
			-- Shadow Weaving
			--{ spellID = 15258, size = 28, unitId = "player", caster = "player", filter = "BUFF" },
			-- Improved Spirit Tap
			-- { spellID = 59000, size = 28, unitId = "player", caster = "all", filter = "BUFF" },
			-- Shadow Orb
			--{ spellID = 77487, size = 28, unitId = "player", caster = "player", filter = "BUFF" },
			-- Archangel
			--{ spellID = 81700, size = 28, unitId = "player", caster = "player", filter = "BUFF" },
			-- Evangelism
			--{ spellID = 81661, size = 28, unitId = "player", caster = "player", filter = "BUFF" },
			-- Dispersion
			{ spellID = 47585, size = 28, unitId = "player", caster = "player", filter = "BUFF" },
		},
    
		{
			Name = "T_DEBUFF_ICON",
			Direction = "RIGHT",
			Interval = 4,
			Mode = "ICON",
			setPoint = { "LEFT", UIParent, "CENTER", 70, -40 },

			-- Shackle undead
			{ spellID = 9484, size = 26, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Psychic Scream
			{ spellID = 8122, size = 26, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Shadow Word: Pain
			{ spellID = 589, size = 26, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Devouring Plague
			{ spellID = 2944, size = 26, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Vampiric Touch
			{ spellID = 34914, size = 26, unitId = "target", caster = "player", filter = "DEBUFF" },
		},
    
		{
			Name = "F_DEBUFF_BAR",
			Direction = "UP",
			IconSide = "LEFT",
			Interval = 4,
			Mode = "BAR",
			setPoint = { "CENTER", UIParent, "CENTER", 240, 60 },

			-- Shackle undead
			{ spellID = 9484, size = 20, barWidth = 150, unitId = "focus", caster = "all", filter = "DEBUFF" },
			-- Psychic Scream
			{ spellID = 8122, size = 20, barWidth = 150, unitId = "focus", caster = "all", filter = "DEBUFF" },
		},
}