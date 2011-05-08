local Z, C, L = unpack(Zodui) -- Import:Z - functions, constants, variables; C - config; L - locales

if Z.myclass ~= "DRUID" then return end

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

ns.Filger_Spells["DRUID"] = {
		{
			Name = "P_BUFF_ICON",
			Direction = "LEFT",
			Interval = 4,
			Opacity = 1,
			Mode = "ICON",
			setPoint = { "RIGHT", UIParent, "CENTER", -70, -80 },

			-- Lifebloom/Blühendes Leben
			{ spellID = 33763, size = 28, unitId = "player", caster = "player", filter = "BUFF" },
			-- Rejuvenation/Verjüngung
			{ spellID = 774, size = 28, unitId = "player", caster = "player", filter = "BUFF" },
			-- Regrowth/Nachwachsen
			{ spellID = 8936, size = 28, unitId = "player", caster = "player", filter = "BUFF" },
			-- Wild Growth/Wildwuchs
			{ spellID = 48438, size = 28, unitId = "player", caster = "player", filter = "BUFF" },
		},
    
		{
      --玩家施放给目标的BUFF
			Name = "T_BUFF_ICON",
			Direction = "RIGHT",
			Interval = 4,
			Opacity = 1,
			Mode = "ICON",
			setPoint = { "LEFT", UIParent, "CENTER", 70, 20 },

			-- Lifebloom/Blühendes Leben
			{ spellID = 33763, size = 26, unitId = "target", caster = "player", filter = "BUFF" },
			-- Rejuvenation/Verjüngung
			{ spellID = 774, size = 26, unitId = "target", caster = "player", filter = "BUFF" },
			-- Regrowth/Nachwachsen
			{ spellID = 8936, size = 26, unitId = "target", caster = "player", filter = "BUFF" },
			-- Wild Growth/Wildwuchs
			{ spellID = 48438, size = 26, unitId = "target", caster = "player", filter = "BUFF" },
		},
    
		{
      --玩家触发的BUFF
			Name = "P_PROC_ICON",
			Direction = "LEFT",
			Interval = 4,
			Mode = "ICON",
			setPoint = { "CENTER", UIParent, "CENTER", 2, -120 },

			-- Eclipse (Lunar)/Mondfinsternis
			{ spellID = 48518, size = 28, unitId = "player", caster = "player", filter = "BUFF" },
			-- Eclipse (Solar)/Sonnenfinsternis
			{ spellID = 48517, size = 28, unitId = "player", caster = "player", filter = "BUFF" },
			-- Shooting Stars/Sternschnuppen
			--{ spellID = 93400, size = 28, unitId = "player", caster = "player", filter = "BUFF" },
			-- Savage Roar/Wildes Brüllen
			{ spellID = 52610, size = 28, unitId = "player", caster = "player", filter = "BUFF" },
			-- Survival Instincts/Überlebensinstinkte
			{ spellID = 61336, size = 28, unitId = "player", caster = "player", filter = "BUFF" },
			-- Tree of Life/Baum des Lebens
			{ spellID = 33891, size = 28, unitId = "player", caster = "player", filter = "BUFF" },
			-- Clearcasting/Freizaubern
			{ spellID = 16870, size = 28, unitId = "player", caster = "player", filter = "BUFF" },
			-- Innervate/Anregen
			{ spellID = 29166, size = 28, unitId = "player", caster = "all", filter = "BUFF" },
			-- Barkskin/Baumrinde
			{ spellID = 22812, size = 28, unitId = "player", caster = "player", filter = "BUFF" },
		},
    
		{
      --目标的DEBUFF
			Name = "T_DEBUFF_ICON",
			Direction = "RIGHT",
			Interval = 4,
			Mode = "ICON",
			setPoint = { "LEFT", UIParent, "CENTER", 70, -40 },

			-- Hibernate/Winterschlaf
			{ spellID = 2637, size = 26, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Entangling Roots/Wucherwurzeln
			{ spellID = 339, size = 26, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Cyclone/Wirbelsturm
			{ spellID = 33786, size = 26, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Moonfire/Mondfeuer
			{ spellID = 8921, size = 26, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Sunfire/Sonnenfeuer
			--{ spellID = 93402, size = 26, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Insect Swarm/Insektenschwarm
			{ spellID = 5570, size = 26, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Rake/Krallenhieb
			{ spellID = 1822, size = 26, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Rip/Zerfetzen
			{ spellID = 1079, size = 26, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Lacerate/Aufschlitzen
			{ spellID = 33745, size = 26, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Pounce Bleed/Anspringblutung
			{ spellID = 9007, size = 26, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Mangle/Zerfleischen
			{ spellID = 33876, size = 26, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Earth and Moon/Erde und Mond
			{ spellID = 48506, size = 26, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Faerie Fire/Feenfeuer
			{ spellID = 770, size = 26, unitId = "target", caster = "all", filter = "DEBUFF" },
		},
    
		{
			Name = "F_DEBUFF_BAR",
			Direction = "UP",
			IconSide = "LEFT",
			Interval = 4,
			Mode = "BAR",
			setPoint = { "CENTER", UIParent, "CENTER", 240, 60 },

			-- Hibernate/Winterschlaf
			{ spellID = 2637, size = 20, barWidth = 150, unitId = "focus", caster = "all", filter = "DEBUFF" },
			-- Entangling Roots/Wucherwurzeln
			{ spellID = 339, size = 20, barWidth = 150, unitId = "focus", caster = "all", filter = "DEBUFF" },
			-- Cyclone/Wirbelsturm
			{ spellID = 33786, size = 20, barWidth = 150, unitId = "focus", caster = "all", filter = "DEBUFF" },
		},

		{
			Name = "CD/HEAL",
			Direction = "UP",
			IconSide = "RIGHT",
			Interval = 4,
			Mode = "BAR",
			setPoint = { "RIGHT", UIParent, "CENTER", -198, 60 },

			-- Swiftmend/Rasche Heilung
			{ spellID = 18562, size = 20, barWidth = 150, filter = "CD" },
			-- Wild Growth/Wildwuchs
			{ spellID = 48438, size = 20, barWidth = 150, filter = "CD" },
		},
}