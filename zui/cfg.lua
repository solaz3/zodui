local Z, C, L = unpack(select(2, ...))

C["general"] = {
  ["infowidth"] = 300,  -- width of the info bar at bottom left and right, 左右信息条宽度
  ["autoscale"] = true,  -- auto scale when addon loaded 载入插件时自动缩放
  ["uiscale"] = .71,  -- ui scale, 界面缩放比列
  ["multisampleprotect"] = true, -- i don't recommend this because of shitty border but, voila!  多重采样保护, 如果你在游戏中启用多重采样的话, 插件的边框会看起来很粗, 所以Tukz选择了在这里禁用多重采样
  ["layoutoverride"] = "NONE",			--ovverride layout (DPS, Healer),  oUF布局覆盖, 如果你不想使用zui_dps或者zui_heal的话, 在这里选择一个值
  ["classcolortheme"] = true,  --color themes according to your class, 根据职业着色样式
}

C["media"] = {
  -- fonts (ENGLISH, SPANISH)
	["font"] = [=[Interface\Addons\zui\res\font\normal_font.ttf]=], -- general font of tukui
	["uffont"] = [[Interface\AddOns\zui\res\font\uf_font.ttf]], -- general font of unitframes
	["dmgfont"] = [[Interface\AddOns\zui\res\font\combat_font.ttf]], -- general font of dmg / sct 
  ["pxfont"] = [[Interface\AddOns\zui\res\font\visitor.ttf]], -- pixelfont 数字字体
  -- fonts (TAIWAN ONLY)
	["tw_font"] = [=[Fonts\bHEI01B.ttf]=], -- general font of tukui
	["tw_uffont"] = [[Fonts\bLEI00D.ttf]], -- general font of unitframes
	["tw_dmgfont"] = [[Fonts\FRIZQT__.ttf]], -- general font of dmg / sct
	-- fonts (CHINA ONLY)
	["cn_font"] = [=[Fonts\ZYKai_T.TTF]=], -- general font of tukui 整个界面字体
	["cn_uffont"] = [[Fonts\ZYHei.TTF]], -- general font of unitframes 头像字体
	["cn_dmgfont"] = [[Fonts\ZYKai_C.TTF]], -- general font of dmg / sct 伤害字体
  -- textures
  ["blank"] = [[Interface\AddOns\zui\res\tex\blank]], -- the main texture for all borders/panels 边框材质
  ["norm"] = [[Interface\AddOns\zui\res\tex\normTex]], -- texture used for tukui healthbar/powerbar/etc  面板材质
  ["glow"] = [[Interface\AddOns\zui\res\tex\glowTex]], -- the glow text around some frame.
  -- texture colors  发光材质
  ["copyicon"] = [[Interface\AddOns\zui\res\tex\copy]], -- copy icon  聊天复制图标
  ["buttonhover"] = [[Interface\AddOns\zui\res\tex\button_hover]],  -- hover texture 悬停材质
  
  ["bordercolor"] = { .2,.2,.2,1 }, -- border color of tukui panels  边框颜色
  ["backdropcolor"] = { .075,.075,.075,1 }, -- background color of tukui panels 背景颜色
  
  -- sound
	["whisper"] = [[Interface\AddOns\zui\res\sound\whisper.mp3]],   -- 密语音效
	["warning"] = [[Interface\AddOns\zui\res\sound\warning.mp3]],   -- buff提醒音效
}

C["chat"] = {
  ["enable"] = true,
  ["height"] = 97,  -- 聊天框高度
  ["background"] = false,  -- 是否启用聊天背景
  ["tabcolor"] = {150/255, 150/255, 150/255},  -- color of chat tabs, disabled if classcolor is true  标签颜色
  ["classcolortab"] = false,   -- color chat tabs based on class  职业着色标签
  ["whispersound"] = true,    -- play a sound when receiving whisper  密语声音提醒
  ["hidebgoncombat"] = false, -- hide chat background on combat 隐藏聊天背景, warning! may decrese performce
  ["crazywxxsome"] = false,  -- wxxsome need this, he's totally crazy!
}

C["unitframes"] = {
  ["enable"] = true,     
  ["unitcastbar"] = true,  -- 施法条
  ["healthbackdrop"] = false,  -- 生命条背景
  ["fontsize"] = 13,  -- 字体大小
  ["classcolor"] = false,   -- 按职业着色
  ["healthcolorbyvalue"] = true,		 -- 按生命值着色
  ["cblatency"] = false,  -- 施法延迟
  ["cbicons"] = true,   -- 施法图标
  ["playerdebuffsonly"] = false,  -- 仅显示玩家的debuffs
  ["arenadebuffs"] = true, 			-- 显示竞技场buff
  ["showtotalhpmp"] = false, -- 显示HP和MP总量
  ["targetpowerplayeronly"] = true,  --只显示目标为玩家的魔法条
  ["auratimer"] = true,  -- buff/debuff计时
  ["auratextscale"] = 11,  -- 计时数字缩放
  ["castplayerwidth"] = 200,  -- 玩家施法条长度
	["casttargetwidth"] = 200,  -- 目标施法条长度
	["castfocuswidth"] = 200,  -- 焦点施法条长度
  ["castbarcolor"] = C["media"].bordercolor, -- Color of player castbar 施法条颜色
	["nointerruptcolor"] = { r = 0.78, g = 0.25, b = 0.25, a = 0.5 }, -- Color of target castbar 目标施法条颜色
	["healthcolor"] = C["media"].bordercolor,   -- 生命条颜色
  ["mini_powerbar"] = true,  -- 迷你魔法条
  ["charportrait"] = true,   -- 头像
  ["charportraithealth"] = true,  -- 在生命条显示头像
  ["swing"] = true,  -- 武器平砍计时
  ["displayaggro"] = true,  -- 显示OT
  ["combat"] = false,	 -- 非战斗自动隐藏头像
  ["showfocustarget"] = true,    -- 显示焦点目标
  ["classbar"] = true,  -- 职业条(DK的符文 等等)
  --frame sizes
	["playtarwidth"] = 200,					--width of player/target frame  玩家与目标框体长度
	["playtarheight"] = 44,					--height of player/target frame  高度
	["smallwidth"] = 104,					--Width of TargetTarget, Focus, FocusTarget, Player's Pet frames  TOT, 焦点, 焦点目标, 宠物框体宽度
	["smallheight"] = 27,					--Height of TargetTarget, Focus, FocusTarget, Player's Pet frames 高度
	["arenabosswidth"] = 170,				--Width of Arena/Boss Frames  竞技场/首领框体宽度
	["arenabossheight"] = 35,				--Height of Arena/Boss Frames 高度
	["assisttankwidth"] = 96,				--Width of MainTank/MainAssist frames  主坦克, 主协助框体长度
	["assisttankheight"] = 22,				--Height of MainTank/MainAssist frames 高度
	["playtarbuffperrow"] = 8,				-- buffs/debuffs per row on player/target frames buff/debuff每行的个数
	["smallbuffperrow"] = 5,				-- debuffs per row on targettarget/focus frames	 TOT上每行buff个数
  ["buffrows"] = 3,   -- rows of debuffs for the target to display
  ["lowThreshold"] = 30,    -- 魔法过低提醒阀值 %
  ["showselfname"] = false, -- show own name on player frame
  
}

C["raidframes"] = {
  ["enable"] = true,						-- enable raid frames
	["fontsize"] = 12,						-- default font height for raidframes  raid字体大小
	["scale"] = 1,							-- for smaller use a number less than one (0.73), for higher use a number larger than one  缩放
	["showrange"] = true,                  -- show range opacity on raidframes 显示距离
	["healcomm"] = false,                  -- enable healcomm4 support on healer layout. 启用HealComm4
	["raidalphaoor"] = 0.3,                -- alpha of raidframes when unit is out of range  raid框超出范围的透明度
	["gridhealthvertical"] = true,         -- enable vertical grow on health bar for healer layout 治疗垂直血量
	["showplayerinparty"] = false,          -- show my player frame in party  在parity中显示玩家
	["maintank"] = true,                  -- enable maintank  启用主坦克
	["mainassist"] = true,                -- enable mainassist  启用主协助
	["partypets"] = true,					-- enable party pets for the healer layout  队友宠物
	["disableblizz"] = true,				-- fuck fuck fuckin fuck  禁用BLZ的某些框体(CTM有用)
	["healthdeficit"] = true,			-- show the health deficit on the raidframes  在raid框体显示掉血量
	["griddps"] = false,					-- show dps layout in grid style  Grid方式显示DPS布局
	["role"] = false,					--display role on raidframe  raid中显示角色
	["partytarget"]	= false,				--display party members targets (DPS ONLY)  队友目标(dps)
	["mouseglow"] = true,					--glow the class/reaction color of the unit that you mouseover  鼠标悬停框体时发光
	["raidunitbuffwatch"] = true,       -- track important spell to watch in pve for grid mode.  追踪raid debuff
	["buffindicatorsize"] = 6,				-- size of the buff indicator on raid/party frames	 buff指示器大小
	["displayaggro"] = true,  -- 显示OT
}

C["nameplate"] = {
  ["enable"] = true,
  ["showhealth"] = false,  -- 显示生命值
  ["overlap"] = true,  --  姓名板叠加
  ["enhancethreat"] = true,  -- 仇恨增强
  ["combat"] = false,					                -- only show enemy nameplates in-combat.  战斗是打开姓名板, 非战斗关闭
	["goodcolor"] = {75/255,  175/255, 76/255},	        -- good threat color (tank shows this with threat, everyone else without)  低仇恨颜色
	["badcolor"] = {0.78, 0.25, 0.25},			        -- bad threat color (opposite of above) 高仇恨时颜色
	["transitioncolor"] = {218/255, 197/255, 92/255},	-- threat color when gaining threat  过渡颜色
}

C["actionbar"] = {
  ["enable"] = true,
  ["showgrid"] = true,  -- 显示格子
  ["buttonsize"] = 27,                                -- normal buttons size  按钮大小
	["petbuttonsize"] = 29,                             -- pet & stance buttons size  宠物 姿态大小
	["buttonspacing"] = 4,                              -- buttons spacing  间隔
  ["hideshapeshift"] = false,  -- 隐藏姿态条
  ["hotkey"] = true,  -- 热键
}

C["map"] = {
  ["enable"] = true,
}

C["tooltip"] = {
  ["enable"] = true,
  ["cursor"] = false,  -- 跟随鼠标
  ["hidecombat"] = false,  -- 战斗时隐藏
  ["hideuf"] = false,  -- 头像时隐藏
  ["hidebuttons"] = false,  -- 技能时隐藏
}

C["arena"] = {
  ["unitframes"] = true,
}

C["error"] = {
  ["enable"] = true,
}

C["buff"] = {
  ["enable"] = true,
}

C["datatext"] = {
	["fps_ms"] = 4,     -- show fps and ms on panels  FPS 延迟
	["system"] = 9,     -- show total memory and others systems infos on panels  内存使用
  ["gold"] = 6,          -- show your current gold on panels  金币
	["wowtime"] = 5,    -- show time on panels  时间
	["guild"] = 3,          -- show number on guildmate connected on panels  工会
	["dur"] = 2,            -- show your equipment durability on panels.  耐久
	["friends"] = 1,    -- 好友
  ["power"] = 8,       -- show your attackpower/spellpower/healpower/rangedattackpower whatever stat is higher gets displayed  攻强 法强
  ["crit"] = 7,          -- show your crit rating on panels. 致命
  ["battleground"] = true,   -- 战场统计
  -- Color Datatext
	["classcolor"] = false,                -- classcolored datatexts  职业着色
	["color"] = "|cff808080",              -- datatext color if classcolor = false  不按职业着色时的颜色
	["fontsize"] = 12,                     -- font size for panels.  字体大小
	["fontflag"] = "OUTLINEMONOCHROME",             -- font ouline   字体标记  
  ["time24"] = true,                                  -- set time to 24h format.  24时间戳
	["localtime"] = false,                              -- set time to local time instead of server time. 本地时间
}

C["invite"] = { 
	["autoaccept"] = true,  -- auto-accept invite from guildmate and friends. 自动接受好友或工会的组队请求
}

C["loot"] = {
  ["autogreed"] = true,  -- 自动贪婪绿装(满级时)
  ["lootframe"] = true,  -- 启用拾取框
  ["rolllootframe"] = true,  -- 启用roll框
}

C["merchant"] = {
  ["sellgrays"] = true,  -- 自动卖灰色
  ["sellmisc"] = true,  -- 自动卖杂物
  ["autorepair"] = true,  -- 自动修装备
}

C["bags"] = {
  ["enable"] = true,
}

C["buffreminder"] = {
  ["enable"] = true,  -- 启用buff提醒
  ["sound"] = true,
}

C["cooldown"] = {
  ["enable"] = true,
  ["treshold"] = 8,  -- 冷去阀值
}

C["addonskins"] = {
  ["tinydps"] = true,  -- 启用tinydps皮肤
  ["dbm"] = true,  -- 启用dbm皮肤
  ["kle"] = false,  -- 启用kle皮肤
  ["omen"] = false,  -- 启用omen皮肤
  ["recount"] = false,  -- 启用recount皮肤
}

C["others"] = {
	["pvpautorelease"] = true,            -- enable auto-release in bg or wintergrasp.  pvp自动释放灵魂
	["announceinterrupt"] = true,			-- announce in party/raid when you interrupt  打断施法时告知队友
}

--profile
--add you own charactor config here
-- 个人配置
if Z.myname == "Yourname" then
end

if Z.myclass == "YourClass" then
end
