local Z, C, L = unpack(Zodui) -- Import:Z - functions, constants, variables; C - config; L - locales

if Z.myclass ~= "WARLOCK" then return end

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

ns.Filger_Spells["WARLOCK"] = {  
		{
			--自己获得/触发的重要buff
			Name = "P_PROC_ICON",
			Direction = "LEFT",
			Interval = 4,
			Mode = "ICON",
			setPoint = { "CENTER", UIParent, "CENTER", 2, -120 },

			--熔火之心
			{ spellID = 47383, size = 28, unitId = "player", caster = "player", filter = "BUFF" },
			--灭杀
			{ spellID = 63158, size = 28, unitId = "player", caster = "player", filter = "BUFF" },
			--爆燃
			{ spellID = 54277, size = 28, unitId = "player", caster = "player", filter = "BUFF" },
			--嗜血
			--{ spellID = 2825, size = 28, unitId = "player", caster = "all", filter = "BUFF" },
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
      { spellID = 47240, size = 28, unitId = "player", caster = "player", filter = "BUFF" },
      --小鬼增效
      { spellID = 47223, size = 28, unitId = "player", caster = "player", filter = "BUFF" },
      --反冲
      { spellID = 34939, size = 28, unitId = "player", caster = "player", filter = "BUFF" },
			--能量灌注
			--{ spellID = 10060, size = 28, unitId = "player", caster = "all", filter = "BUFF" },
			--嫁祸
			--{ spellID = 57934, size = 28, unitId = "player", caster = "all", filter = "BUFF" },			
		},
    
		{
      --目标PVP DEBUFF监视
			Name = "PVP_T_DEBUFF_ICON",
			Direction = "LEFT",
			Interval = 4,
			Mode = "ICON",
			setPoint = { "CENTER", UIParent, "CENTER", 0, 160 },
                       
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
			Name = "T_DEBUFF_ICON",
			Direction = "RIGHT",
			Interval = 4,
			Mode = "ICON",
			setPoint = { "LEFT", UIParent, "CENTER", 70, -40 },
            
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
			Name = "F_DEBUFF_BAR",
			Direction = "UP",
			Interval = 4,
			Mode = "BAR",
			setPoint = { "CENTER", UIParent, "CENTER", 240, 60 },
			
			--恐惧
			{ spellID = 5782, size = 20, barWidth = 150, unitId = "focus", caster = "player", filter = "DEBUFF" },
			--放逐
			{ spellID = 710, size = 20, barWidth = 150, unitId = "focus", caster = "player", filter = "DEBUFF" },
			--魅惑
			{ spellID = 6358, size = 20, barWidth = 150, unitId = "focus", caster = "player", filter = "DEBUFF" },
		},
}