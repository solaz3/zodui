local Z, C, L = unpack(Zodui) -- Import:Z - functions, constants, variables; C - config; L - locales

if Z.myclass ~= "DEATHKNIGHT" then return end

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

ns.Filger_Spells["DEATHKNIGHT"] = {
		{
			Name = "P_PROC_ICON",
			Direction = "LEFT",
			Interval = 4,
			Mode = "ICON",
			setPoint = { "CENTER", UIParent, "CENTER", 2, -120 },

			-- Blood Shield/Blutschild
			--{ spellID = 77513, size = 28, unitId = "player", caster = "player", filter = "BUFF" },
			-- Unholy Force/Unheilige Kraft
			{ spellID = 67383, size = 28, unitId = "player", caster = "player", filter = "BUFF" },
			-- Unholy Strength/Unheilige Stärke
			{ spellID = 53365, size = 28, unitId = "player", caster = "player", filter = "BUFF" },
			-- Unholy Might/Unheilige Macht
			{ spellID = 67117, size = 28, unitId = "player", caster = "player", filter = "BUFF" },
			-- Dancing Rune Weapon/Tanzende Runenwaffe
			{ spellID = 49028, size = 28, unitId = "player", caster = "player", filter = "BUFF" },
			-- Icebound Fortitude/Eisige Gegenwehr
			{ spellID = 48792, size = 28, unitId = "player", caster = "player", filter = "BUFF" },
			-- Anti-Magic Shell/Antimagische Hülle
			{ spellID = 48707, size = 28, unitId = "player", caster = "player", filter = "BUFF" },
			-- Killing machine
			{ spellID = 51124, size = 28, unitId = "player", caster = "player", filter = "BUFF" },
			-- Freezing fog
			{ spellID = 59052, size = 28, unitId = "player", caster = "player", filter = "BUFF" },
			-- Bone Shield/Knochenschild
			{ spellID = 49222, size = 28, unitId = "player", caster = "player", filter = "BUFF" },
		},
    
		{
			Name = "T_DEBUFF_ICON",
			Direction = "RIGHT",
			Interval = 4,
			Mode = "ICON",
			setPoint = { "LEFT", UIParent, "CENTER", 70, -40 },

			-- Strangulate/Strangulieren
			{ spellID = 47476, size = 26, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Blood Plague/Blutseuche
			{ spellID = 59879, size = 26, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Frost Fever/Frostfieber
			{ spellID = 59921, size = 26, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Unholy Blight/Unheilige Verseuchung
			{ spellID = 49194, size = 26, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Summon Gargoyle/Gargoyle beschwören
			{ spellID = 49206, size = 26, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Death and Decay/Tod und Verfall
			{ spellID = 43265, size = 26, unitId = "target", caster = "player", filter = "DEBUFF" },
		},
}