local Z, C, L = unpack(select(2, ...))

C["general"] = {
  ["infowidth"] = 300,  -- width of the info bar at bottom left and right
  ["autoscale"] = true,
  ["uiscale"] = .71,
  ["multisampleprotect"] = true, -- i don't recommend this because of shitty border but, voila!
  ["layoutoverride"] = "NONE",			--ovverride layout (DPS, Healer)
  ["classcolortheme"] = true,
}

C["media"] = {
  -- fonts (ENGLISH, SPANISH)
	["font"] = [=[Interface\Addons\zui\res\font\normal_font.ttf]=], -- general font of tukui
	["uffont"] = [[Interface\AddOns\zui\res\font\uf_font.ttf]], -- general font of unitframes
	["dmgfont"] = [[Interface\AddOns\zui\res\font\combat_font.ttf]], -- general font of dmg / sct 
  ["pxfont"] = [[Interface\AddOns\zui\res\font\visitor.ttf]], -- pixelfont
  -- fonts (TAIWAN ONLY)
	["tw_font"] = [=[Fonts\bHEI01B.ttf]=], -- general font of tukui
	["tw_uffont"] = [[Fonts\bLEI00D.ttf]], -- general font of unitframes
	["tw_dmgfont"] = [[Fonts\FRIZQT__.ttf]], -- general font of dmg / sct
	-- fonts (CHINA ONLY)
	["cn_font"] = [=[Fonts\ZYKai_T.TTF]=], -- general font of tukui
	["cn_uffont"] = [[Fonts\ZYHei.TTF]], -- general font of unitframes
	["cn_dmgfont"] = [[Fonts\ZYKai_C.TTF]], -- general font of dmg / sct
  -- textures
  ["blank"] = [[Interface\AddOns\zui\res\tex\blank]], -- the main texture for all borders/panels
  ["norm"] = [[Interface\AddOns\zui\res\tex\normTex]], -- texture used for tukui healthbar/powerbar/etc
  ["glow"] = [[Interface\AddOns\zui\res\tex\glowTex]], -- the glow text around some frame.
  -- texture colors
  ["copyicon"] = [[Interface\AddOns\zui\res\tex\copy]], -- copy icon
  ["buttonhover"] = [[Interface\AddOns\zui\res\tex\button_hover]],
  
  ["bordercolor"] = { .2,.2,.2,1 }, -- border color of tukui panels
  ["backdropcolor"] = { .075,.075,.075,1 }, -- background color of tukui panels
  
  -- sound
	["whisper"] = [[Interface\AddOns\zui\res\sound\whisper.mp3]],
	["warning"] = [[Interface\AddOns\zui\res\sound\warning.mp3]],
}

C["chat"] = {
  ["enable"] = true,
  ["height"] = 97,
  ["background"] = true,
  ["tabcolor"] = {150/255, 150/255, 150/255},  -- color of chat tabs, disabled if classcolor is true
  ["classcolortab"] = false,   -- color chat tabs based on class
  ["whispersound"] = true,    -- play a sound when receiving whisper
}

C["unitframes"] = {
  ["enable"] = true,     
  ["unitcastbar"] = true,
  ["healthbackdrop"] = false,
  ["fontsize"] = 13,
  ["classcolor"] = false,  
  ["healthcolorbyvalue"] = true,		
  ["cblatency"] = false,
  ["cbicons"] = true, 
  ["playerdebuffsonly"] = false,
  ["arenadebuffs"] = true, 			
  ["showtotalhpmp"] = false, 
  ["targetpowerplayeronly"] = true,
  ["auratimer"] = true,  
  ["auratextscale"] = 11, 
  ["castplayerwidth"] = 200,
	["casttargetwidth"] = 200,
	["castfocuswidth"] = 200,
  ["castbarcolor"] = C["media"].bordercolor, -- Color of player castbar
	["nointerruptcolor"] = { r = 0.78, g = 0.25, g = 0.25, a = 0.5 }, -- Color of target castbar
	["healthcolor"] = C["media"].bordercolor, 
  ["mini_powerbar"] = true,
  ["charportrait"] = true, 
  ["charportraithealth"] = true,
  ["swing"] = true,
  ["displayaggro"] = true,
  ["combat"] = true,	
  ["showfocustarget"] = true,   
  ["classbar"] = true,
  --frame sizes
	["playtarwidth"] = 200,					--width of player/target frame
	["playtarheight"] = 44,					--height of player/target frame
	["smallwidth"] = 104,					--Width of TargetTarget, Focus, FocusTarget, Player's Pet frames
	["smallheight"] = 27,					--Height of TargetTarget, Focus, FocusTarget, Player's Pet frames
	["arenabosswidth"] = 170,				--Width of Arena/Boss Frames
	["arenabossheight"] = 35,				--Height of Arena/Boss Frames
	["assisttankwidth"] = 96,				--Width of MainTank/MainAssist frames
	["assisttankheight"] = 22,				--Height of MainTank/MainAssist frames
	["playtarbuffperrow"] = 8,				-- buffs/debuffs per row on player/target frames
	["smallbuffperrow"] = 5,				-- debuffs per row on targettarget/focus frames	
  ["lowThreshold"] = 30,
  
}

C["raidframes"] = {
  ["enable"] = true,						-- enable raid frames
	["fontsize"] = 12,						-- default font height for raidframes
	["scale"] = 1,							-- for smaller use a number less than one (0.73), for higher use a number larger than one
	["showrange"] = true,                  -- show range opacity on raidframes
	["healcomm"] = false,                  -- enable healcomm4 support on healer layout.
	["raidalphaoor"] = 0.3,                -- alpha of raidframes when unit is out of range
	["gridhealthvertical"] = true,         -- enable vertical grow on health bar for healer layout
	["showplayerinparty"] = false,          -- show my player frame in party
	["maintank"] = true,                  -- enable maintank
	["mainassist"] = true,                -- enable mainassist
	["partypets"] = true,					-- enable party pets for the healer layout
	["disableblizz"] = true,				-- fuck fuck fuckin fuck
	["healthdeficit"] = true,			-- show the health deficit on the raidframes
	["griddps"] = true,					-- show dps layout in grid style
	["role"] = false,					--display role on raidframe
	["partytarget"]	= false,				--display party members targets (DPS ONLY)
	["mouseglow"] = true,					--glow the class/reaction color of the unit that you mouseover
	["raidunitbuffwatch"] = true,       -- track important spell to watch in pve for grid mode.
	["buffindicatorsize"] = 6,				-- size of the buff indicator on raid/party frames	
	["displayaggro"] = true,
}

C["nameplate"] = {
  ["enable"] = true,
  ["showhealth"] = false,
  ["overlap"] = true,
  ["enhancethreat"] = true,
  ["combat"] = false,					                -- only show enemy nameplates in-combat.
	["goodcolor"] = {75/255,  175/255, 76/255},	        -- good threat color (tank shows this with threat, everyone else without)
	["badcolor"] = {0.78, 0.25, 0.25},			        -- bad threat color (opposite of above)
	["transitioncolor"] = {218/255, 197/255, 92/255},	-- threat color when gaining threat
}

C["actionbar"] = {
  ["enable"] = true,
  ["showgrid"] = true,
  ["buttonsize"] = 27,                                -- normal buttons size
	["petbuttonsize"] = 29,                             -- pet & stance buttons size
	["buttonspacing"] = 4,                              -- buttons spacing
  ["hideshapeshift"] = false,
  ["hotkey"] = true,
}

C["map"] = {
  ["enable"] = true,
}

C["tooltip"] = {
  ["enable"] = true,
  ["cursor"] = false,
  ["hidecombat"] = false,
  ["hideuf"] = false,
  ["hidebuttons"] = false,
}

C["arena"] = {
  ["unitframes"] = true,
}

C["error"] = {
  ["enable"] = true,
}

C["datatext"] = {
	["fps_ms"] = 4,     -- show fps and ms on panels
	["system"] = 9,     -- show total memory and others systems infos on panels
  ["gold"] = 6,          -- show your current gold on panels
	["wowtime"] = 5,    -- show time on panels
	["guild"] = 3,          -- show number on guildmate connected on panels
	["dur"] = 2,            -- show your equipment durability on panels.
	["friends"] = 1,  
  ["power"] = 8,       -- show your attackpower/spellpower/healpower/rangedattackpower whatever stat is higher gets displayed
  ["crit"] = 7,          -- show your crit rating on panels.
  ["battleground"] = true,
  -- Color Datatext
	["classcolor"] = false,                -- classcolored datatexts 
	["color"] = "|cff808080",              -- datatext color if classcolor = false
	["fontsize"] = 12,                     -- font size for panels.
	["fontflag"] = "OUTLINEMONOCHROME",             -- font ouline   
  ["time24"] = true,                                  -- set time to 24h format.
	["localtime"] = false,                              -- set time to local time instead of server time.
}

C["invite"] = { 
	["autoaccept"] = true,  -- auto-accept invite from guildmate and friends.
}

C["loot"] = {
  ["autogreed"] = true,
  ["lootframe"] = true,
  ["rolllootframe"] = true,
}

C["merchant"] = {
  ["sellgrays"] = true,
  ["sellmisc"] = true,
  ["autorepair"] = true,
}

C["bags"] = {
  ["enable"] = true,
}

C["buffreminder"] = {
  ["enable"] = true,
  ["sound"] = true,
}

C["cooldown"] = {
  ["enable"] = true,
  ["treshold"] = 8,
}

C["addonskins"] = {
  ["tinydps"] = true,
  ["dbm"] = true,
  ["kle"] = false,
  ["omen"] = false,
  ["recount"] = false,
}

C["others"] = {
	["pvpautorelease"] = true,            -- enable auto-release in bg or wintergrasp.
	["announceinterrupt"] = true,			-- announce in party/raid when you interrupt
}

--profile
--add you own charactor config here
if Z.myname == "Yourname" then
end

if Z.myclass == "YourClass" then
end
