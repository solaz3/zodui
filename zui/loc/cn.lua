﻿local Z, C, L = unpack(select(2, ...))

if Z.client == "zhCN" then
  Z.notenglish = true
  
  L.chat_BATTLEGROUND_GET = "[B]"
	L.chat_BATTLEGROUND_LEADER_GET = "[B]"
	L.chat_BN_WHISPER_GET = "From"
	L.chat_GUILD_GET = "[G]"
	L.chat_OFFICER_GET = "[O]"
	L.chat_PARTY_GET = "[P]"
	L.chat_PARTY_GUIDE_GET = "[P]"
	L.chat_PARTY_LEADER_GET = "[P]"
	L.chat_RAID_GET = "[R]"
	L.chat_RAID_LEADER_GET = "[R]"
	L.chat_RAID_WARNING_GET = "[W]"
	L.chat_WHISPER_GET = "From"
	L.chat_FLAG_AFK = "[AFK]"
	L.chat_FLAG_DND = "[DND]"
	L.chat_FLAG_GM = "[GM]"
	L.chat_ERR_FRIEND_ONLINE_SS = "|cff298F00上线|r了"
	L.chat_ERR_FRIEND_OFFLINE_S = "|cffff0000下线|r了"
  
  L.chat_general = "综合"
	L.chat_trade = TRADE
	L.chat_defense = "本地防务"
	L.chat_recrutment = "公会招募"
	L.chat_lfg = "寻求组队"
  
  L.popup_disableui = "Zui并不支持此分辨率, 你想要停用Zui吗? (若果您想要尝试其它分辨率, 请按取消)"
	L.popup_install = "这个角色首次使用Zui v"..Z.version..", 您必需先重载接口以完成设定"
  L.popup_reset = "警告! 此动作会重置任何保存到Zui的设定值. 您是否依然決定这样做?"
	L.popup_2raidactive = "2個团队框架正在运行, 请选择以下其中一个."
	L.popup_install_yes = "当然是! (建议!)"
	L.popup_install_no = "不用了, 救命这UI真差"
	L.popup_reset_yes = "当然, 重置我吧!"
	L.popup_reset_no = "不咯, 我去网上发帖问!"
  
  L.core_welcome1 = "欢迎使用 |cffC495DDZui|r "
	L.core_welcome2 = "输入 |cff00FFFF/uihelp|r 获得帮助"
  
  L.core_uihelp1 = "|cff00ff00通用指令|r"
	L.core_uihelp2 = "|cffFF0000|r."
	L.core_uihelp3 = "|cffFF0000/rl|r - 重新载入UI."
	L.core_uihelp4 = "|cffFF0000/gm|r - 开启帮助界面."
	L.core_uihelp5 = "|cffFF0000/frame|r - 检测鼠标位置下的框架名称. (对lua编辑者非常有帮助!)"
	L.core_uihelp6 = "|cffFF0000/heal|r - 启用Heal界面."
	L.core_uihelp7 = "|cffFF0000/dps|r - 启用Dps/Tank界面."
	L.core_uihelp8 = "|cffFF0000/bags|r - 排序背包, 购买银行背包位置或堆叠物品."
	L.core_uihelp9 = "|cffFF0000/resetui|r - 重置Zui并不支持此分辨率到预定配置."
	L.core_uihelp10 = "|cffFF0000/rd|r - 解散队伍."
	L.core_uihelp11 = "|cffFF0000/ainv|r - 启用密语自动邀请, 您可以使用`/ainv myword`来设置您的密语关键字."
	L.core_uihelp100 = "(想看更多? 向上拉吧! ...)"
  
  L.symbol_CLEAR = "清除"
	L.symbol_SKULL = "骷髅"
	L.symbol_CROSS = "十字"
	L.symbol_SQUARE = "方形"
	L.symbol_MOON = "月亮"
	L.symbol_TRIANGLE = "三角"
	L.symbol_DIAMOND = "钻石"
	L.symbol_CIRCLE = "圈圈"
	L.symbol_STAR = "星星"
  
  L.error_noerror = "没有错误"
  
  L.tooltip_count = "数量"
 
	L.bags_noslots = "不能再购买更多的背包栏位!"
	L.bags_costs = "花费: %.2f 金"
	L.bags_buyslots = "输入 /bags purchase yes 以购买银行背包栏位"
	L.bags_openbank = "您需要先访问您的银行"
	L.bags_sort = "将背包或银行内的物品分类并排序"
	L.bags_stack = "将背包或银行内的不完整的物品堆重新堆叠"
	L.bags_buybankslot = "购买银行背包栏位. (需要访问银行)"
	L.bags_search = "搜索"
	L.bags_sortmenu = "分类及排序"
	L.bags_sortspecial = "分类及排序特殊物品"
	L.bags_stackmenu = "堆叠"
	L.bags_stackspecial = "堆叠特殊物品"
	L.bags_showbags = "显示背包"
	L.bags_sortingbags = "分类及排序完成"
	L.bags_nothingsort= "不需要分类"
	L.bags_bids = "使用背包: "
	L.bags_stackend = "重新堆叠完成"
	L.bags_rightclick_search = "点击右键来搜索物品."
  
  L.merchant_repairnomoney = "你没有足够的金钱来修理装备!"
	L.merchant_repaircost = "你的装备已经修理, 花费了"
	L.merchant_trashsell = "您背包内的粗糙物品已被自动卖出, 您获得了"
 
	L.goldabbrev = "|cffffd700g|r"
	L.silverabbrev = "|cffc7c7cfs|r"
	L.copperabbrev = "|cffeda55fc|r"
  
  L.chat_invalidtarget = "无效的目标"
  L.chat_bind_header = "|cffaad372ZodUI|cfffff468聊天|cffffffff快捷键设定"
  L.chat_bind_say = "说"
  L.chat_bind_yell = "大喊"
  L.chat_bind_party = "小队"
  L.chat_bind_guild = "公会"
  L.chat_bind_raid = "团队"
  L.chat_bind_bg = "战场"
  
  L.move_tooltip = "移动指示资讯"
	L.move_minimap = "移动小地图"
	L.move_watchframe = "移动任务追踪框架"
	L.move_gmframe = "移动帮助界面"
	L.move_buffs = "移动玩家Buff界面"
	L.move_debuffs = "移动玩家Debuff界面"
	L.move_shapeshift = "移动姿态条或图腾条"
	L.move_achievements = "移动成就界面"
	L.move_roll = "移动Roll界面"
	L.move_vehicle = "移动栽具座位界面"
  L.move_buffs = "移动玩家Buff界面"
	L.move_debuffs = "移动玩家Debuff界面"
  
  L.disband = "正在解散队伍."
 
  L.core_autoinv_enable = "启用自动邀请: invite"
	L.core_autoinv_enable_c = "自动邀请功能已启用: "
	L.core_autoinv_disable = "自动邀请功能已关闭"
  
  L.loot_slot_fish = "魚"
  L.loot_slot_empty = "空"
  
  L.hunter_unhappy = "你的宠物感到不高兴!"
	L.hunter_content = "你的宠物感到满足!"
	L.hunter_happy = "你的宠物感到高兴!"
  
  L.datatext_download = "下载: "
	L.datatext_bandwidth = "带宽: "
	L.datatext_guild = "公会"
	L.datatext_noguild = "沒有公会"
	L.datatext_bags = "背包: "
	L.datatext_friends = "好友"
	L.datatext_online = "在线: "
	L.datatext_armor = "耐久度"
	L.datatext_earned = "赚取:"
	L.datatext_spent = "花费:"
	L.datatext_deficit = "赤字:"
	L.datatext_profit = "利润:"
	L.datatext_timeto = "时间到"
	L.datatext_friendlist = "好友名單:"
	L.datatext_playersp = "法伤"
	L.datatext_playerap = "强度"
	L.datatext_playerhaste = "加速"
	L.datatext_dps = "dps"
	L.datatext_hps = "hps"
	L.datatext_playerarp = "护甲穿透"
	L.datatext_session = "本次概況: "
	L.datatext_character = "角色: "
	L.datatext_server = "服务器: "
	L.datatext_totalgold = "总额: "
	L.datatext_savedraid = "已有进度的团队副本"
	L.datatext_currency = "兑换数:"
	L.datatext_fps = " fps & "
	L.datatext_ms = " ms"
	L.datatext_playercrit = "% 致命"
	L.datatext_playerheal = " 治疗"
	L.datatext_avoidancebreakdown = "免伤分析"
	L.datatext_lvl = "等级"
	L.datatext_boss = "首领"
	L.datatext_miss = "未击中"
	L.datatext_dodge = "闪躲"
	L.datatext_block = "格挡"
	L.datatext_parry = "招架"
	L.datatext_playeravd = "免伤: "
	L.datatext_servertime = "服务器时间: "
	L.datatext_localtime = "本地时间: "
	L.datatext_mitigation = "等级缓和: "
	L.datatext_healing = "治疗: "
	L.datatext_damage = "伤害: "
	L.datatext_honor = "荣誉: "
	L.datatext_killingblows = "击杀 : "
	L.datatext_ttstatsfor = "状态 "
	L.datatext_ttkillingblows = "击杀:"
	L.datatext_tthonorkills = "荣誉击杀:"
	L.datatext_ttdeaths = "死亡:"
	L.datatext_tthonorgain = "获得荣誉:"
	L.datatext_ttdmgdone = "伤害输出:"
	L.datatext_tthealdone = "治疗输出:"
	L.datatext_basesassaulted = "基地突袭:"
	L.datatext_basesdefended = "基地防御:"
	L.datatext_towersassaulted = "哨塔突袭:"
	L.datatext_towersdefended = "哨塔防御:"
	L.datatext_flagscaptured = "占领旗帜:"
	L.datatext_flagsreturned = "交还旗帜:"
	L.datatext_graveyardsassaulted = "墓地突袭:"
	L.datatext_graveyardsdefended = "墓地防守:"
	L.datatext_demolishersdestroyed = "石毁车摧毁:"
	L.datatext_gatesdestroyed = "大门摧毁:"
	L.datatext_totalmemusage = "内存使用:"
	L.datatext_control = "控制方:"
 
	L.Slots = {
		[1] = {1, "头部", 1000},
		[2] = {3, "肩部", 1000},
		[3] = {5, "胸部", 1000},
		[4] = {6, "腰部", 1000},
		[5] = {9, "手腕", 1000},
		[6] = {10, "手", 1000},
		[7] = {7, "腿部", 1000},
		[8] = {8, "脚", 1000},
		[9] = {16, "主手", 1000},
		[10] = {17, "副手", 1000},
		[11] = {18, "远程", 1000}
	}
  
  L.bind_combat = "您不能在战斗中设定快捷键"
	L.bind_saved = "所有快捷键修改已保存"
	L.bind_discard = "这次的快捷键修改已重设为上一次修改"
	L.bind_instruct = "将鼠标指向动作条上来绑定快捷键, 您可以按ESC或以右键点击快捷列上任何一格以清除该位置的设定"
	L.bind_save = "保存"
	L.bind_discardbind = "放弃"
	
  L.hotkey_mouse = "鼠标按键"
  L.hotkey_middle = KEY_BUTTON3
  L.hotkey_scrollup = KEY_MOUSEWHEELUP
  L.hotkey_scrolldown = KEY_MOUSEWHEELDOWN
  L.hotkey_numpad = "数字键盘"
  L.hotkey_pageup = KEY_PAGEUP
  L.hotkey_pagedown = KEY_PAGEDOWN
  L.hotkey_space =  KEY_SPACE
  L.hotkey_insert = KEY_INSERT
  L.hotkey_home = KEY_HOME
  L.hotkey_delete = KEY_DELETE
  
  L.unitframes_ouf_lowmana = "法力过低"
end