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
			--自己身上的控制类debuff
			Name = "PVP_P_DEBUFF_ICON",
			Direction = "LEFT",
			Interval = 4,
			Mode = "ICON",
			setPoint = { "center", nil, "center", -20, 40 },		
			
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

		
			
		},
		
		
		{		
			--目标身上的重要buff
			Name = "PVP_T_BUFF_ICON",
			Direction = "RIGHT",
			Interval = 4,
			Mode = "ICON",
			setPoint = { "center", nil, "center", 0, 140 },
			
			-- 豹群
			{ spellID = 13159, size = 40, unitId = "target", caster = "all", filter = "BUFF" },
			-- 激活
			{ spellID = 29166, size = 40, unitId = "target", caster = "all", filter = "BUFF"},
			--消散
			{ spellID = 47585, size = 40, unitId = "target", caster = "all", filter = "BUFF"},
			--法术反射
			{ spellID = 23920, size = 40, unitId = "target", caster = "all", filter = "BUFF" },
			--光环掌握
			{ spellID = 31821, size = 40, unitId = "target", caster = "all", filter = "BUFF" },
			--冰箱
            { spellID = 45438, size = 40, unitId = "target", caster = "all", filter = "BUFF" },
			--暗影斗篷
            { spellID = 31224, size = 40, unitId = "target", caster = "all", filter = "BUFF" },
			--圣盾术
            { spellID = 642, size = 40, unitId = "target", caster = "all", filter = "BUFF" },
			--威慑
            { spellID = 19263, size = 40, unitId = "target", caster = "all", filter = "BUFF" },
			--反魔法护罩
            { spellID = 48707, size = 40, unitId = "target", caster = "all", filter = "BUFF" },
            --巫妖之躯
            { spellID = 49039, size = 40, unitId = "target", caster = "all", filter = "BUFF" },
			--自由之手
            { spellID = 1044, size = 40, unitId = "target", caster = "all", filter = "BUFF" },
			--牺牲之手
            { spellID = 6940, size = 40, unitId = "target", caster = "all", filter = "BUFF" },
			--根基图腾
            { spellID = 8178, size = 40, unitId = "target", caster = "all", filter = "BUFF" },
            --狂暴之怒			
            { spellID = 18499, size = 40, unitId = "target", caster = "all", filter = "BUFF" },
			--盾墙
            { spellID = 871, size = 40, unitId = "target", caster = "all", filter = "BUFF" },	
			--保护之手
            { spellID = 10278, size = 40, unitId = "target", caster = "all", filter = "BUFF" },	
			--痛苦压制
            { spellID = 33206, size = 40, unitId = "target", caster = "all", filter = "BUFF" },	
			--生存本能
            { spellID = 50322, size = 40, unitId = "target", caster = "all", filter = "BUFF" },			
            --防护恐惧结界
            { spellID = 6346, size = 40, unitId = "target", caster = "all", filter = "BUFF" },
			--野德狂暴
            { spellID = 50334, size = 40, unitId = "target", caster = "all", filter = "BUFF" }, 
			--虚空防护
            { spellID = 30302, size = 40, unitId = "target", caster = "all", filter = "BUFF" }, 
		
		},
		
		
		
		
		{
			Name = "PVE_P_DEBUFF",
			Direction = "LEFT",
			Interval = 4,
			Mode = "ICON",
			setPoint = { "center", nil, "center", -80, -30 },

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
			
		},
		
},

	
	["WARLOCK"] = {
		{
			--自己获得/触发的重要buff
			Name = "P_PROC_ICON",
			Direction = "LEFT",
			Interval = 4,
			Mode = "ICON",
			setPoint = { "center", nil, "center", 2, -120 },

			--熔火之心
			{ spellID = 47383, size = 28, unitId = "player", caster = "player", filter = "BUFF" },
			--灭杀
			{ spellID = 63158, size = 28, unitId = "player", caster = "player", filter = "BUFF" },
			--爆燃
			{ spellID = 54277, size = 28, unitId = "player", caster = "player", filter = "BUFF" },
			--嗜血
			{ spellID = 2825, size = 28, unitId = "player", caster = "all", filter = "BUFF" },
			--生命分流
			{ spellID = 57946, size = 28, unitId = "player", caster = "player", filter = "BUFF" },
			--暗影冥思		
			{ spellID = 17941, size = 28, unitId = "player", caster = "player", filter = "BUFF" },
		    --根除
			{ spellID = 47197, size = 28, unitId = "player", caster = "player", filter = "BUFF" },
			--Devious Minds 邪念 4t10特效
			{ spellID = 70840, size = 28, unitId = "player", caster = "player", filter = "BUFF" },
            --火焰冲撞
            { spellID = 18073, size = 28, unitId = "player", caster = "player", filter = "BUFF" },
            --虚空防护
            { spellID = 30302, size = 28, unitId = "player", caster = "player", filter = "BUFF" },
            --恶魔契约
            --{ spellID = 47240, size = 43, unitId = "player", caster = "player", filter = "BUFF" },
            --小鬼增效
            --{ spellID = 47223, size = 43, unitId = "player", caster = "player", filter = "BUFF" },
            --反冲
            { spellID = 34939, size = 28, unitId = "player", caster = "player", filter = "BUFF" },
			--能量灌注
			{ spellID = 10060, size = 28, unitId = "player", caster = "all", filter = "BUFF" },
			--嫁祸
			{ spellID = 57934, size = 28, unitId = "player", caster = "all", filter = "BUFF" },
			
			-- 速度药水
			{ spellID = 53908, size = 28, unitId = "player", caster = "player", filter = "BUFF" },
			-- 狂野魔法药水
			{ spellID = 53909, size = 28, unitId = "player", caster = "player", filter = "BUFF" },
			-- 工程手套加速
			{ spellID = 54999, size = 28, unitId = "player", caster = "player", filter = "BUFF" },
			-- 霜铸先知
			{ spellID = 72416, size = 28, unitId = "player", caster = "player", filter = "BUFF" },
		},
		{
			Name = "PVP_T_DEBUFF_ICON",
			Direction = "LEFT",
			Interval = 4,
			Mode = "ICON",
			setPoint = { "center", nil, "center", 0, 200 },
                       
            --恐惧嚎叫
            { spellID = 5484, size = 40, unitId = "target", caster = "all", filter = "DEBUFF"},
			--恐惧
            { spellID = 6215, size = 40, unitId = "target", caster = "all", filter = "DEBUFF"},
			--暗影烈焰雕文
            { spellID = 63938, size = 40, unitId = "target", caster = "all", filter = "DEBUFF" },
			--清算
            { spellID = 18120, size = 40, unitId = "target", caster = "all", filter = "DEBUFF" },
			--法术封锁
            { spellID = 24259, size = 40, unitId = "target", caster = "all", filter = "DEBUFF"},
			--暗影之怒
            { spellID = 47847, size = 40, unitId = "target", caster = "all", filter = "DEBUFF"},
			--死亡缠绕
            { spellID = 47860, size = 40, unitId = "target", caster = "all", filter = "DEBUFF"},
			--放逐术
            { spellID = 18647, size = 40, unitId = "target", caster = "all", filter = "DEBUFF"},
        },
        {
			--我施放给目标的debuff
			Name = "P_CD_ICON",
			Direction = "RIGHT",
			Interval = 4,
			Mode = "ICON",
			setPoint = { "center", nil, "center", 70, -20 },
            
			--元素诅咒
            { spellID = 47865, size = 26, unitId = "target", caster = "all", filter = "DEBUFF" },
			--厄运诅咒
            { spellID = 47867, size = 26, unitId = "target", caster = "player", filter = "DEBUFF" },
            --痛苦诅咒
            { spellID = 47864, size = 26, unitId = "target", caster = "player", filter = "DEBUFF" },
			--疲劳诅咒
            { spellID = 18223, size = 26, unitId = "target", caster = "player", filter = "DEBUFF" },
			--语言诅咒
            { spellID = 11719, size = 26, unitId = "target", caster = "all", filter = "DEBUFF" },
            --献祭
            { spellID = 11668, size = 26, unitId = "target", caster = "player", filter = "DEBUFF" },
            --腐蚀术
            { spellID = 47813, size = 26, unitId = "target", caster = "player", filter = "DEBUFF" },
			--强化暗影箭
            --{ spellID = 17794, size = 26, unitId = "target", caster = "all", filter = "DEBUFF" },
            --痛苦无常
            { spellID = 47843, size = 26, unitId = "target", caster = "player", filter = "DEBUFF" },
            --鬼影缠身
            { spellID = 59164, size = 26, unitId = "target", caster = "player", filter = "DEBUFF" },
            --暗影之拥
            { spellID = 32394, size = 26, unitId = "target", caster = "player", filter = "DEBUFF" },
        },
		
		
		
		{
			--我施放给焦点的debuff
			Name = "F/DEBUFF_BAR",
			Direction = "UP",
			Interval = 4,
			Mode = "BAR",
			setPoint = { "center", nil, "center", 320, 60 },
			
			--恐惧
			{ spellID = 5782, size = 16, barWidth = 120, unitId = "focus", caster = "player", filter = "DEBUFF" },
			--放逐
			{ spellID = 710, size = 16, barWidth = 120, unitId = "focus", caster = "player", filter = "DEBUFF" },
			--魅惑
			{ spellID = 6358, size = 16, barWidth = 120, unitId = "focus", caster = "player", filter = "DEBUFF" },
		},
		

		
		

	},
	
	["HUNTER"] = {
		{
			Name = "P_PROC_ICON",
			Direction = "LEFT",
			Interval = 4,
			Mode = "ICON",
			setPoint = { "BOTTOMRIGHT", oUF_Tukz_player, "TOPRIGHT", 0, 98 },

			-- Lock and Load
			{ spellID = 56342, size = 28, unitId = "player", caster = "player", filter = "BUFF" },
			-- Fury of the Five Flights
			{ spellID = 60314, size = 28, unitId = "player", caster = "player", filter = "BUFF" },
			-- Quick Shots
			--{ spellID = 6150, size = 28, unitId = "player", caster = "player", filter = "BUFF" },
			-- Master Tactician
			{ spellID = 34837, size = 28, unitId = "player", caster = "player", filter = "BUFF" },
			-- Improved Steady Shot/Verbesserter zuverl盲ssiger Schuss
			{ spellID = 53224, size = 28, unitId = "player", caster = "player", filter = "BUFF" },
			-- Expose Weakness
			--{ spellID = 34503, size = 39, unitId = "player", caster = "player", filter = "BUFF" },
			-- Rapid Fire
			{ spellID = 3045, size = 28, unitId = "player", caster = "player", filter = "BUFF" },
			-- Call of the Wild
			{ spellID = 53434, size = 28, unitId = "player", caster = "player", filter = "BUFF" },
			-- Mend Pet/Tier heilen
			{ spellID = 136, size = 28, unitId = "pet", caster = "player", filter = "BUFF" },
			-- Feed Pet/Tier f眉ttern
			{ spellID = 6991, size = 28, unitId = "pet", caster = "player", filter = "BUFF" },
		},
		{
			Name = "TARGET_DEBUFF",
			Direction = "LEFT",
			Interval = 4,
			Mode = "ICON",
			setPoint = { "center", nil, "center", 70, -20 },

			-- Wyvern Sting
			{ spellID = 19386, size = 28, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Silencing Shot
			{ spellID = 34490, size = 28, unitId = "target", caster = "all", filter = "DEBUFF" },
			-- Serpent Sting
			{ spellID = 1978, size = 28, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Scorpid Sting
			--{ spellID = 3043, size = 28, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Black Arrow
			{ spellID = 3674, size = 28, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Explosive Shot
			{ spellID = 53301, size = 28, unitId = "target", caster = "player", filter = "DEBUFF" },
			-- Hunter's Mark
			{ spellID = 1130, size = 28, unitId = "target", caster = "all", filter = "DEBUFF" },
			
		},
	},
}