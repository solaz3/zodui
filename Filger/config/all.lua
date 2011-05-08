local _, ns = ...

ns.Filger_Settings = {
	configmode = false,
}

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

ns.Filger_Spells = {  
  ["ALL"] = {
    {
      --玩家身上特殊buff, 饰品, 药水, 工程, 附魔等等
			Name = "SPECIAL_P_BUFF_ICON",
			Direction = "LEFT",
			Interval = 4,
			Mode = "ICON",
			setPoint = { "CENTER", UIParent, "CENTER", 2, -160 },
      
      -- 速度药水
			{ spellID = 53908, size = 28, unitId = "player", caster = "player", filter = "BUFF" },
			-- 狂野魔法药水
			{ spellID = 53909, size = 28, unitId = "player", caster = "player", filter = "BUFF" },
			-- 工程手套加速
			{ spellID = 54999, size = 28, unitId = "player", caster = "player", filter = "BUFF" },
			-- 霜铸先知
			{ spellID = 72416, size = 28, unitId = "player", caster = "player", filter = "BUFF" },
			-- Geisterstunde/Witching Hour
			--{ spellID = 90887, size = 28, unitId = "player", caster = "player", filter = "BUFF" },
			-- Erkenntnis des Herzens/Heart's Revelation
			--{ spellID = 91027, size = 28, unitId = "player", caster = "player", filter = "BUFF" },
			-- Richturteil des Herzens/Heart's Judgement
			--{ spellID = 91041, size = 28, unitId = "player", caster = "player", filter = "BUFF" },
			-- Hyperspeed Accelerators/Hypergeschwindigkeitsbeschleuniger
			{ spellID = 54758, size = 28, unitId = "player", caster = "player", filter = "BUFF" },
			-- Synapse Springs/Synapsenfedern
			--{ spellID = 82175, size = 28, unitId = "player", caster = "player", filter = "BUFF" },
			--Tricks of the Trade/Schurkenhandel
			{ spellID = 57934, size = 28, unitId = "player", caster = "all", filter = "BUFF" },
			--Power Infusion/Seele der Macht
			{ spellID = 10060, size = 28, unitId = "player", caster = "all", filter = "BUFF" },
			-- Bloodlust/Kampfrausch
			{ spellID = 2825, size = 28, unitId = "player", caster = "all", filter = "BUFF" },
			-- Heroism/Heldentum
			{ spellID = 32182, size = 28, unitId = "player", caster = "all", filter = "BUFF" },
		},
    
		{		
			--自己身上的控制类debuff
			Name = "P_DEBUFF_ICON",
			Direction = "LEFT",
			Interval = 4,
			Mode = "ICON",
			setPoint = { "RIGHT", UIParent, "CENTER", -70, 10 },		
      
			-- Death Knight
			-- Gnaw (Ghoul)
			{ spellID = 47481, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Strangulate
			{ spellID = 47476, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Chains of Ice
			{ spellID = 45524, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Desecration (no duration, lasts as long as you stand in it)
			{ spellID = 55741, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Glyph of Heart Strike
			{ spellID = 58617, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Icy Clutch (Chilblains)
			{ spellID = 50436, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Hungering Cold
			{ spellID = 51209, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },

			-- Druid
			-- Cyclone
			{ spellID = 33786, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Hibernate
			{ spellID = 2637, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Bash
			{ spellID = 5211, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Maim
			{ spellID = 22570, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Pounce
			{ spellID = 9005, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Entangling Roots
			{ spellID = 339, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Feral Charge Effect
			{ spellID = 45334, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Infected Wounds
			{ spellID = 58179, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },

			-- Hunter
			-- Freezing Trap Effect
			{ spellID = 3355, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Freezing Arrow Effect
			{ spellID = 60210, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Scatter Shot
			{ spellID = 19503, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Snatch (Bird of Prey)
			{ spellID = 50541, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Silencing Shot
			{ spellID = 34490, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Intimidation
			{ spellID = 24394, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Sonic Blast (Bat)
			{ spellID = 50519, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Ravage (Ravager)
			{ spellID = 50518, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Concussive Barrage
			{ spellID = 35101, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Concussive Shot
			{ spellID = 5116, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Frost Trap Aura
			{ spellID = 13810, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Glyph of Freezing Trap
			{ spellID = 61394, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Wing Clip
			{ spellID = 2974, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Counterattack
			{ spellID = 19306, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Entrapment
			{ spellID = 19185, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Pin (Crab)
			{ spellID = 50245, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Venom Web Spray (Silithid)
			{ spellID = 54706, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Web (Spider)
			{ spellID = 4167, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Froststorm Breath (Chimera)
			{ spellID = 51209, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Tendon Rip (Hyena)
			{ spellID = 51209, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },

			-- Mage
			-- Dragon's Breath
			{ spellID = 31661, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Polymorph
			{ spellID = 118, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Silenced - Improved Counterspell
			{ spellID = 18469, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Deep Freeze
			{ spellID = 44572, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Freeze (Water Elemental)
			{ spellID = 33395, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Frost Nova
			{ spellID = 122, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Shattered Barrier
			{ spellID = 55080, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Chilled
			{ spellID = 6136, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Cone of Cold
			{ spellID = 120, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Slow
			{ spellID = 31589, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },

			-- Paladin
			-- Repentance
			{ spellID = 20066, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Shield of the Templar
			{ spellID = 63529, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Hammer of Justice
			{ spellID = 853, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Stun (Seal of Justice proc)
			{ spellID = 20170, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Avenger's Shield
			{ spellID = 31935, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },

			-- Priest
			-- Psychic Horror
			{ spellID = 64058, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Mind Control
			{ spellID = 605, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Psychic Horror
			{ spellID = 64044, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Psychic Scream
			{ spellID = 8122, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Silence
			{ spellID = 15487, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Mind Flay
			{ spellID = 15407, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },

			-- Rogue
			-- Dismantle
			{ spellID = 51722, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Blind
			{ spellID = 2094, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Gouge
			{ spellID = 1776, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Sap
			{ spellID = 6770, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Garrote - Silence
			{ spellID = 1330, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Silenced - Improved Kick
			{ spellID = 18425, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Cheap Shot
			{ spellID = 1833, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Kidney Shot
			{ spellID = 408, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Blade Twisting
			{ spellID = 31125, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Crippling Poison
			{ spellID = 3409, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Deadly Throw
			{ spellID = 26679, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },

			-- Shaman
			-- Hex
			{ spellID = 51514, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Earthgrab
			{ spellID = 64695, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Freeze
			{ spellID = 63685, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Stoneclaw Stun
			{ spellID = 39796, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Earthbind
			{ spellID = 3600, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Frost Shock
			{ spellID = 8056, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },

			-- Warlock
			-- Banish
			{ spellID = 710, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Death Coil
			{ spellID = 6789, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Fear
			{ spellID = 5782, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Howl of Terror
			{ spellID = 5484, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Seduction (Succubus)
			{ spellID = 6358, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Spell Lock (Felhunter)
			{ spellID = 24259, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Shadowfury
			{ spellID = 30283, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Intercept (Felguard)
			{ spellID = 30153, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Aftermath
			{ spellID = 18118, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Curse of Exhaustion
			{ spellID = 18223, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },

			-- Warrior
			-- Intimidating Shout
			{ spellID = 20511, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Disarm
			--{ spellID = 676, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Silenced (Gag Order)
			{ spellID = 18498, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Charge Stun
			{ spellID = 7922, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Concussion Blow
			{ spellID = 12809, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Intercept
			{ spellID = 20253, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Revenge Stun
			{ spellID = 12798, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Shockwave
			{ spellID = 46968, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Glyph of Hamstring
			{ spellID = 58373, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Improved Hamstring
			{ spellID = 23694, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Hamstring
			{ spellID = 1715, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Piercing Howl
			{ spellID = 12323, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },
      
			-- Racials
			-- War Stomp
			{ spellID = 20549, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },
      -- Baradin Hold(PvP)
			-- Meteor Slash/Meteorschlag (Argaloth)
			--{ spellID = 88942, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },
      
      -- 玩家身上的PVE DEBUFF
      -- ICC
			-- 阵亡勇士的印记 (Deathbringer Saurfang)
			{ spellID = 72293, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- 播种疫苗 (Festergut)
			{ spellID = 72103, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- 畸变感染 (Rotface)
			{ spellID = 71224, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- 肆虐毒疫 (Professor Putricide)
			{ spellID = 72856, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },
			--天灾疾病 (Professor Putricide)
			{ spellID = 73117, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- 异变毒气 (Professor Putricide)
			{ spellID = 70353, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- 软泥特性 (Professor Putricide)
			{ spellID = 70352, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- 黑暗堕落者的契约 (Bloodqueen Lana'thel)
			{ spellID = 71340, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- 蜂拥之影 (Bloodqueen Lana'thel)
			{ spellID = 71861, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- 鲜血女王的精华 (Bloodqueen Lana'thel)
			{ spellID = 71473, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- 冰霜炸弹 (Sindragosa)
			{ spellID = 71053, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- 动荡 (Sindragosa)
			{ spellID = 69766, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- 狂咒 (Sindragosa)
			{ spellID = 69762, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- 秘法打击 (Sindragosa)
			{ spellID = 70128, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- 死疽 (Arthas - The Lich King)
			{ spellID = 73912, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },	
    
			--[[ Bastion of Twilight
			-- Blackout/Blackout (Valiona & Theralion)
			{ spellID = 92879, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Engulfing Magic/Einhüllende Magie (Valiona & Theralion)
			{ spellID = 86631, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Waterlogged/Wasserdurchtränkt (Twilight Ascendant Council)
			{ spellID = 82762, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Burning Blood/Brennendes Blut (Twilight Ascendant Council)
			{ spellID = 82662, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Heart of Ice/Herz aus Eis (Twilight Ascendant Council)
			{ spellID = 82667, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Frozen/Gefroren (Twilight Ascendant Council)
			{ spellID = 92503, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Swirling Winds/Wirbelnde Winde (Twilight Ascendant Council)
			{ spellID = 83500, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Magnetic Pull/Magnetische Anziehung (Twilight Ascendant Council)
			{ spellID = 83587, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Corruption: Accelerated/Verderbnis: Beschleunigung (Cho'gall)
			{ spellID = 81836, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Corruption: Malformation/Verderbnis: Missbildung (Cho'gall)
			{ spellID = 82125, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Corruption: Absolute/Verderbnis: Vollendet (Cho'gall)
			{ spellID = 82170, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Corruption: Sickness/Verderbnis: Krankheit (Cho'gall)
			{ spellID = 93200, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },

			-- Blackwing Descent
			-- Constricting Chains/Fesselnde Ketten (Magmaw)
			{ spellID = 91911, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Parasitic Infection/Parasitäre Infektion (Magmaw)
			{ spellID = 94679, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Infectious Vomit/Infektiöses Erbrochenes (Magmaw)
			{ spellID = 91923, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Lightning Conductor (Omnitron Defense System)
			{ spellID = 91433, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Flash Freeze/Blitzeis (Maloriak)
			{ spellID = 77699, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Consuming Flames/Verzehrende Flammen (Maloriak)
			{ spellID = 77786, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Finkle's Mixture/Finkels Mixtur (Chimaeron)
			{ spellID = 82705, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Shadow Conductor/Schattenleiter (Nefarian)
			{ spellID = 92053, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },

			-- Throne of Four Winds
			-- Wind Chill/Windkühle (Conclave of Wind)
			{ spellID = 93123, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Slicing Gale/Schneidender Orkan (Conclave of Wind)
			{ spellID = 93058, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Static Shock/Statischer Schock (Al'Akir)
			{ spellID = 87873, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },
			-- Acid Rain/Säureregen (Al'Akir)
			{ spellID = 93279, size = 36, unitId = "player", caster = "all", filter = "DEBUFF" },]]
		},
    
		{		
			--目标身上的重要buff
			Name = "T_BUFF_ICON",
			Direction = "RIGHT",
			Interval = 4,
			Mode = "ICON",
			setPoint = { "LEFT", UIParent, "CENTER", 70, 10 },
			
			-- 豹群
			{ spellID = 13159, size = 36, unitId = "target", caster = "all", filter = "BUFF" },
			-- 激活
			{ spellID = 29166, size = 36, unitId = "target", caster = "all", filter = "BUFF"},
			--消散
			{ spellID = 47585, size = 36, unitId = "target", caster = "all", filter = "BUFF"},
			--法术反射
			{ spellID = 23920, size = 36, unitId = "target", caster = "all", filter = "BUFF" },
			--光环掌握
			{ spellID = 31821, size = 36, unitId = "target", caster = "all", filter = "BUFF" },
			--冰箱
      { spellID = 45438, size = 36, unitId = "target", caster = "all", filter = "BUFF" },
			--暗影斗篷
      { spellID = 31224, size = 36, unitId = "target", caster = "all", filter = "BUFF" },
			--圣盾术
      { spellID = 642, size = 36, unitId = "target", caster = "all", filter = "BUFF" },
			--威慑
      { spellID = 19263, size = 36, unitId = "target", caster = "all", filter = "BUFF" },
			--反魔法护罩
      { spellID = 48707, size = 36, unitId = "target", caster = "all", filter = "BUFF" },
      --巫妖之躯
      { spellID = 49039, size = 36, unitId = "target", caster = "all", filter = "BUFF" },
			--自由之手
      { spellID = 1044, size = 36, unitId = "target", caster = "all", filter = "BUFF" },
			--牺牲之手
      { spellID = 6940, size = 36, unitId = "target", caster = "all", filter = "BUFF" },
			--根基图腾
      { spellID = 8178, size = 36, unitId = "target", caster = "all", filter = "BUFF" },
      --狂暴之怒			
      { spellID = 18499, size = 36, unitId = "target", caster = "all", filter = "BUFF" },
			--盾墙
      { spellID = 871, size = 36, unitId = "target", caster = "all", filter = "BUFF" },	
			--保护之手
      { spellID = 10278, size = 36, unitId = "target", caster = "all", filter = "BUFF" },	
			--痛苦压制
      { spellID = 33206, size = 36, unitId = "target", caster = "all", filter = "BUFF" },	
			--生存本能
      { spellID = 50322, size = 36, unitId = "target", caster = "all", filter = "BUFF" },			
      --防护恐惧结界
      { spellID = 6346, size = 36, unitId = "target", caster = "all", filter = "BUFF" },
			--野德狂暴
      { spellID = 50334, size = 36, unitId = "target", caster = "all", filter = "BUFF" }, 
			--虚空防护
      { spellID = 30302, size = 36, unitId = "target", caster = "all", filter = "BUFF" }, 
		},
  },
}