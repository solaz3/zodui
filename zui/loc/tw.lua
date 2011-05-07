local Z, C, L = unpack(select(2, ...))

if Z.client == "zhTW" then
  Z.notenglish = true
  
  L.chat_BATTLEGROUND_GET = "[B]"
	L.chat_BATTLEGROUND_LEADER_GET = "[B]"
	L.chat_BN_WHISPER_GET = "<"
	L.chat_GUILD_GET = "[G]"
	L.chat_OFFICER_GET = "[O]"
	L.chat_PARTY_GET = "[P]"
	L.chat_PARTY_GUIDE_GET = "[P]"
	L.chat_PARTY_LEADER_GET = "[P]"
	L.chat_RAID_GET = "[R]"
	L.chat_RAID_LEADER_GET = "[R]"
	L.chat_RAID_WARNING_GET = "[W]"
	L.chat_WHISPER_GET = "<"
	L.chat_FLAG_AFK = "[AFK]"
	L.chat_FLAG_DND = "[DND]"
	L.chat_FLAG_GM = "[GM]"
	L.chat_ERR_FRIEND_ONLINE_SS = "|cff298F00上線|r了"
	L.chat_ERR_FRIEND_OFFLINE_S = "|cffff0000下線|r了"
  
  L.chat_general = "綜合"
	L.chat_trade = "交易"
	L.chat_defense = "本地防務"
	L.chat_recrutment = "公會招募"
	L.chat_lfg = "尋求組隊"
  
  L.popup_disableui = "Zui並不支援此解析度, 你想要停用Zui嗎? (若果您想要嘗試其他解析度, 請按取消)"
  L.popup_install = "這個角色首次使用 Zui v" .. Z.version .. ",  您必需先重載介面以完成設定"
  L.popup_reset = "警告! 此動作會重置任何設定至Zui預設值. 您是否依然決定這樣做?"
  L.popup_2raidactive = "2個團隊框架正在運行, 請選擇以下其中一個."
  L.popup_install_yes = "當然是! (建議!)"
	L.popup_install_no = "不用了, 救命這UI真差"
	L.popup_reset_yes = "當然啦, 預設就是美!"
	L.popup_reset_no = "不囉, 我會不爬文發貼問!"
  
  L.core_welcome1 = "歡迎使用 |cffC495DDZui|r "
	L.core_welcome2 = "輸入 |cff00FFFF/uihelp|r 以獲得更多資訊"
  
  L.core_uihelp1 = "|cff00ff00通用指令|r"
	L.core_uihelp2 = "|cffFF0000/moveui|r - 解鎖並移動任何您看得見的框架及UI元素."
	L.core_uihelp3 = "|cffFF0000/rl|r - 重新載入UI."
	L.core_uihelp4 = "|cffFF0000/gm|r - 傳送回報單給GM或開啟幫助介面."
	L.core_uihelp5 = "|cffFF0000/frame|r - 偵測滑鼠位置下的框架名稱. (對lua編輯者非常有幫助!)"
	L.core_uihelp6 = "|cffFF0000/heal|r - 啟用Heal介面."
	L.core_uihelp7 = "|cffFF0000/dps|r - 啟用Dps/Tank介面."
	L.core_uihelp8 = "|cffFF0000/bags|r - 排序背包, 購買銀行背包位置或堆疊物品."
	L.core_uihelp9 = "|cffFF0000/resetui|r - 重置Zui到預設設置."
	L.core_uihelp10 = "|cffFF0000/rd|r - 解散團隊."
	L.core_uihelp11 = "|cffFF0000/ainv|r - 啟用密語自動邀請, 您可以設定輸入`/ainv myword`以設置您的密語關鍵字."
	L.core_uihelp100 = "(想看更多? 向上拉吧! ...)"
  
  L.symbol_CLEAR = "清除"
	L.symbol_SKULL = "頭顱"
	L.symbol_CROSS = "十字"
	L.symbol_SQUARE = "方形"
	L.symbol_MOON = "月亮"
	L.symbol_TRIANGLE = "三角"
	L.symbol_DIAMOND = "鑽石"
	L.symbol_CIRCLE = "圈圈"
	L.symbol_STAR = "星星"
  
  L.error_noerror = "沒有錯誤"
  
  L.tooltip_count = "數量"
  
  L.bags_noslots = "不能再購買更多的背包欄位!"
	L.bags_costs = "花費: %.2f 金"
	L.bags_buyslots = "輸入 /bags purchase yes 以購買銀行背包欄位"
	L.bags_openbank = "您需要先造訪您的銀行"
	L.bags_sort = "將背包或銀行內的物品分類及排序"
	L.bags_stack = "將背包或銀行內的不完整的物品堆疊重新堆疊"
	L.bags_buybankslot = "購買銀行背包欄位. (需要造訪銀行)"
	L.bags_search = "搜尋"
	L.bags_sortmenu = "分類及排序"
	L.bags_sortspecial = "分類及排序特殊物品"
	L.bags_stackmenu = "堆疊"
	L.bags_stackspecial = "堆疊特殊物品"
	L.bags_showbags = "顯示背包"
	L.bags_sortingbags = "分類及排序完成"
	L.bags_nothingsort= "不需要分類"
	L.bags_bids = "使用背包: "
	L.bags_stackend = "重新堆疊完成"
	L.bags_rightclick_search = "點擊右鍵以搜尋物品."
  
  L.merchant_repairnomoney = "您沒有足夠的金錢來修理!"
	L.merchant_repaircost = "您的裝備已修理, 花費了"
	L.merchant_trashsell = "您背包內的粗糙物品已被自動賣出, 您賺取了"
 
	L.goldabbrev = "|cffffd700g|r"
	L.silverabbrev = "|cffc7c7cfs|r"
	L.copperabbrev = "|cffeda55fc|r"
  
  L.chat_invalidtarget = "無效的目標"
  L.chat_bind_header = "|cffaad372ZodUI|cfffff468聊天|cffffffff按鍵設定"
  L.chat_bind_say = "說"
  L.chat_bind_yell = "大喊"
  L.chat_bind_party = "小隊"
  L.chat_bind_guild = "公會"
  L.chat_bind_raid = "團隊"
  L.chat_bind_bg = "戰場"
  
  L.move_watchframe = "移動任務追蹤框架"
  L.move_vehicle = "移動載具坐位介面"
  L.move_gmframe = "移動GM回報單及幫助介面"
  L.move_achievements = "移動成就介面"
  L.move_roll = "移動Roll戰利品的介面"
  L.move_tooltip = "移動指示資訊"
  L.move_minimap = "移動小地圖"
  L.move_shapeshift = "移動變形或圖騰列"
  L.move_buffs = "移動玩家Buff介面"
	L.move_debuffs = "移動玩家Debuff介面"
  
  L.disband = "正在解散隊伍."
  
  L.core_autoinv_enable = "啟用自動邀請: invite"
	L.core_autoinv_enable_c = "自動邀請功能已啟用: "
	L.core_autoinv_disable = "自動邀請功能已關閉"
  
  L.loot_slot_fish = "魚"
  L.loot_slot_empty = "空"
  
  L.hunter_unhappy = "你的寵物感到不高興!"
	L.hunter_content = "你的寵物感到滿足!"
	L.hunter_happy = "你的寵物感到高興!"
  
  L.datatext_ttstatsfor = "狀態 "
	L.datatext_ttkillingblows = "擊殺:"
	L.datatext_tthonorkills = "榮譽擊殺:"
	L.datatext_ttdeaths = "死亡:"
	L.datatext_tthonorgain = "獲得榮譽:"
	L.datatext_ttdmgdone = "傷害輸出:"
	L.datatext_tthealdone = "治療輸出:"
  L.datatext_flagscaptured = "佔領旗幟:"
	L.datatext_flagsreturned = "交還旗幟:"
  L.datatext_graveyardsassaulted = "墓地突襲:"
	L.datatext_graveyardsdefended = "墓地防守:"
  L.datatext_towersassaulted = "哨塔突襲:"
	L.datatext_towersdefended = "哨塔防禦:"
  L.datatext_demolishersdestroyed = "石毀車摧毀:"
	L.datatext_gatesdestroyed = "大門摧毀:"
  L.datatext_fps = "fps "
	L.datatext_ms = "ms"
  L.datatext_friendlist = "好友名單:"
  L.datatext_earned = "賺取:"
	L.datatext_spent = "花費:"
	L.datatext_deficit = "赤字:"
	L.datatext_profit = "利潤:"
  L.datatext_server = "伺服器: "
	L.datatext_totalgold = "總額: "
  L.datatext_noguild = "沒有公會"
  L.datatext_download = "下載: "
	L.datatext_bandwidth = "寬頻: "
  L.datatext_totalmemusage = "總共記憶體使用:"
  L.datatext_servertime = "伺服器時間: "
	L.datatext_localtime = "本地時間: "
  L.datatext_savedraid = "已有進度的團隊副本"
  
  L.Slots = {
		[1] = {1, "頭部", 1000},
		[2] = {3, "肩部", 1000},
		[3] = {5, "胸部", 1000},
		[4] = {6, "腰部", 1000},
		[5] = {9, "手腕", 1000},
		[6] = {10, "手", 1000},
		[7] = {7, "腿部", 1000},
		[8] = {8, "腳", 1000},
		[9] = {16, "主手", 1000},
		[10] = {17, "副手", 1000},
		[11] = {18, "遠程", 1000}
	}
  
  L.bind_combat = "您不能在戰鬥中設定快捷鍵"
	L.bind_saved = "所有快捷鍵修改已儲存"
	L.bind_discard = "這次的快捷鍵修改已重設為上一次修改"
	L.bind_instruct = "將滑鼠指向動作列上以綁定快捷鍵, 您可以按ESC或以右鍵點擊快捷列上任何一格以清除該位置的設定"
	L.bind_save = "儲存"
	L.bind_discardbind = "放棄"
  
  L.hotkey_mouse = "滑鼠按鍵"
  L.hotkey_middle = KEY_BUTTON3
  L.hotkey_scrollup = KEY_MOUSEWHEELUP
  L.hotkey_scrolldown = KEY_MOUSEWHEELDOWN
  L.hotkey_numpad = "數字鍵盤"
  L.hotkey_pageup = KEY_PAGEUP
  L.hotkey_pagedown = KEY_PAGEDOWN
  L.hotkey_space =  KEY_SPACE
  L.hotkey_insert = KEY_INSERT
  L.hotkey_home = KEY_HOME
  L.hotkey_delete = KEY_DELETE
  
  L.unitframes_ouf_lowmana = "法力過低"
end