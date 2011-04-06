local Z, C, L = unpack(select(2, ...))

C["media"] = {
	-- fonts (ENGLISH, SPANISH)
	["font"] = [=[Interface\AddOns\zodui\resource\fonts\normal_font.ttf]=], -- general font of zui
	["uffont"] = [[Interface\AddOns\zodui\resource\fonts\uf_font.ttf]], -- general font of unitframes
	["dmgfont"] = [[Interface\AddOns\zodui\resource\fonts\combat_font.ttf]], -- general font of dmg / sct
	["numfont"] = [[Interface\AddOns\zodui\resource\fonts\num_font.ttf]], -- general font of numbers
  
	-- fonts (TAIWAN ONLY)
	["tw_font"] = STANDARD_TEXT_FONT, -- general font of zui
	["tw_uffont"] = STANDARD_TEXT_FONT, -- general font of unitframes
	["tw_dmgfont"] = [[Interface\AddOns\zodui\resource\fonts\sct_font.ttf]], -- general font of dmg / sct
  ["tw_numfont"] = [[Interface\AddOns\zodui\resource\fonts\num_font.ttf]], -- general font of numbers
	
  -- fonts (CHINA ONLY)
	["cn_font"] = STANDARD_TEXT_FONT, -- general font of zui
	["cn_uffont"] = STANDARD_TEXT_FONT, -- general font of unitframes
	["cn_dmgfont"] = [[Interface\AddOns\zodui\resource\fonts\sct_font.ttf]], -- general font of dmg / sct
  ["cn_numfont"] = [[Interface\AddOns\zodui\resource\fonts\num_font.ttf]], -- general font of numbers
  
	-- textures
  ["blank"] = [[Interface\BUTTONS\WHITE8X8]], -- the main texture for all borders/panels
  ["glossTex"] = [[Interface\AddOns\zodui\resource\textures\normTex]],
	["normTex"] = [[Interface\AddOns\zodui\resource\textures\normTex2]], -- texture used for zui healthbar/powerbar/etc
	["glowTex"] = [[Interface\AddOns\zodui\resource\textures\glowTex]], -- the glow text around some frame.
	["bubbleTex"] = [[Interface\AddOns\zodui\resource\textures\bubbleTex]], -- unitframes combo points
	["copyicon"] = [[Interface\AddOns\zodui\resource\textures\copy]], -- copy icon
	
	["bordercolor"] = { .23,.23, .23 }, -- border color of zui panels
	["altbordercolor"] = { .4,.4,.4 }, -- alternative border color, mainly for unitframes text panels.
  ["fadedbackdropcolor"] = { .07, .07, .07, .9 }, -- faded background color of tukui panels
	["backdropcolor"] = { .07,.07,.07, 1 }, -- background color of zui panels
  ["valuecolor"] = {23/255,132/255,209/255}, -- color for values of datatexts
	["buttonhover"] = [[Interface\AddOns\zodui\resource\textures\button_hover]],
	
	-- sound
	["whisper"] = [[Interface\AddOns\zodui\resource\sounds\whisper.mp3]],
	["warning"] = [[Interface\AddOns\zodui\resource\sounds\warning.mp3]],
}

C["general"] = {
	["autoscale"] = true,                               -- mainly enabled for users that don't want to mess with the config file
	["uiscale"] = 0.78,                                 -- set your value (between 0.64 and 1) of your uiscale if autoscale is off
	["overridelowtohigh"] = false,                      -- EXPERIMENTAL ONLY! override lower version to higher version on a lower reso.
	["multisampleprotect"] = true,                      -- i don't recommend this because of shitty border but, voila!
  ["layoutoverride"] = "NONE",			--ovverride layout (DPS, Healer)
}

C["actionbar"] = {
  ["buttonsize"] = 27,                                -- normal buttons size
	["petbuttonsize"] = 29,                             -- pet & stance buttons size
	["buttonspacing"] = 4,     
}

C["unitframes"] = {
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
  ["castplayerwidth"] = 250,
	["casttargetwidth"] = 250,
	["castfocuswidth"] = 250,
  ["castbarcolor"] = C["media"].bordercolor, -- Color of player castbar
	["nointerruptcolor"] = { r = 0.78, g = 0.25, g = 0.25, a = 0.5 }, -- Color of target castbar
	["healthcolor"] = C["media"].bordercolor, 
  ["mini_powerbar"] = true,
  ["charportrait"] = true, 
  ["swing"] = true,
  ["displayaggro"] = true,
  ["combat"] = false,	
  ["showfocustarget"] = false,   
  ["classbar"] = true,
  --frame sizes
	["playtarwidth"] = 250,					--width of player/target frame
	["playtarheight"] = 55,					--height of player/target frame
	["smallwidth"] = 130,					--Width of TargetTarget, Focus, FocusTarget, Player's Pet frames
	["smallheight"] = 35,					--Height of TargetTarget, Focus, FocusTarget, Player's Pet frames
	["arenabosswidth"] = 212,				--Width of Arena/Boss Frames
	["arenabossheight"] = 43,				--Height of Arena/Boss Frames
	["assisttankwidth"] = 120,				--Width of MainTank/MainAssist frames
	["assisttankheight"] = 27,				--Height of MainTank/MainAssist frames
	["playtarbuffperrow"] = 8,				-- buffs/debuffs per row on player/target frames
	["smallbuffperrow"] = 5,				-- debuffs per row on targettarget/focus frames	
}

C["raidframes"] = {
	["enable"] = true,						-- enable raid frames
	["fontsize"] = 12,						-- default font height for raidframes
	["scale"] = 1,							-- for smaller use a number less than one (0.73), for higher use a number larger than one
	["showrange"] = true,                  -- show range opacity on raidframes
	["healcomm"] = true,                  -- enable healcomm4 support on healer layout.
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

C["tooltip"] = {                                
	["hidecombat"] = false,                             -- hide bottom-right tooltip when in combat
	["hidebuttons"] = false,                            -- always hide action bar buttons tooltip.
	["hideuf"] = false,                                 -- hide tooltip on unitframes
	["cursor"] = false,                                 -- tooltip via cursor only
	["id"] = true,										-- enables spellid's on abilities and spells
}

C["nameplate"] = {
	["showhealth"] = false,				                -- show health text on nameplate
	["enhancethreat"] = false,			                -- threat features based on if your a tank or not
	["overlap"] = false,				                -- allow nameplates to overlap
	["combat"] = false,					                -- only show enemy nameplates in-combat.
	["goodcolor"] = {75/255,  175/255, 76/255},	        -- good threat color (tank shows this with threat, everyone else without)
	["badcolor"] = {0.78, 0.25, 0.25},			        -- bad threat color (opposite of above)
	["transitioncolor"] = {218/255, 197/255, 92/255},	-- threat color when gaining threat
  ["trackauras"] = false,
  ["trackccauras"] = true
}

C["cooldown"] = {
	["treshold"] = 8,                                   -- show decimal under X seconds and text turn red
}

C["datatext"] = {
  ["fontsize"] = 12,
  ["guild"] = 1,
  ["dur"] = 2,
  ["friends"] = 3,
  ["power"] = 4,
  ["gold"] = 5,
  ["bags"] = 6,
  ["wowtime"] = 7,
  ["system"] = 9,
  ["fps_ms"] = 8,
  ["battleground"] = false,
  ["localtime"] = false,
  ["time24"] = true
}

C["focuskey"] = {
  ["enable"] = true,
  ["modifier"] = "shift", -- shift, ctrl, alt
  ["mouse"] = "1",  -- 1=左鍵, 2=右鍵, 3=中鍵, (如果存在, 4=鼠標4鍵, 5=鼠標5鍵)
}

C["others"] = {
	["pvpautorelease"] = true,            -- enable auto-release in bg or wintergrasp.
	["raidbuffreminder"] = true,			-- buffbar below the minimap, important missing buffs	
	["announceinterrupt"] = true,			-- announce in party/raid when you interrupt
}

C["error"] = {
	["enable"] = true,                                  -- true to enable this mod, false to disable
}

C["xct"] = {
---------------------------------------------------------------------------------
-- use ["option"] = true/false, to set options.
-- options
-- blizz damage options.
  ["enable"] = true,
	["blizzheadnumbers"] = true,	-- use blizzard damage/healing output (above mob/player head)
	["damagestyle"] = false,		-- change default damage/healing font above mobs/player heads. you need to restart WoW to see changes! has no effect if blizzheadnumbers = false
-- xCT outgoing damage/healing options
	["damage"] = false ,		-- show outgoing damage in it's own frame
	["healing"] = true,		-- show outgoing healing in it's own frame
	["showhots"] = true,		-- show periodic healing effects in xCT healing frame.
	["damagecolor"] = true,		-- display damage numbers depending on school of magic, see http://www.wowwiki.com/API_COMBAT_LOG_EVENT
	["critprefix"] = "|cffFF0000*|r",	-- symbol that will be added before amount, if you deal critical strike/heal. leave "" for empty. default is red *
	["critpostfix"] = "|cffFF0000*|r",	-- postfix symbol, "" for empty.
	["icons"] = false,		-- show outgoing damage icons
	["iconsize"] = 27,		-- icon size of spells in outgoing damage frame, also has effect on dmg font size if it's set to "auto"
	["petdamage"] = true,		-- show your pet damage.
	["dotdamage"] = true,		-- show damage from your dots. someone asked an option to disable lol.
	["treshold"] = 1,		-- minimum damage to show in outgoing damage frame
	["healtreshold"] = 1,		-- minimum healing to show in incoming/outgoing healing messages.

-- appearence
	["font"] = C["media"].dmgfont,	-- "Fonts\\ARIALN.ttf" is default WoW font.
	["fontsize"] = 18,
	["fontstyle"] = "OUTLINE",	-- valid options are "OUTLINE", "MONOCHROME", "THICKOUTLINE", "OUTLINE,MONOCHROME", "THICKOUTLINE,MONOCHROME"
	["damagefont"] = C["media"].numfont,	 -- "Fonts\\FRIZQT__.ttf" is default WoW damage font
	["damagefontsize"] = "auto",	-- size of xCT damage font. use "auto" to set it automatically depending on icon size, or use own value, 16 for example. if it's set to number value icons will change size.
	["timevisible"] = 3, 		-- time (seconds) a single message will be visible. 3 is a good value.
	["scrollable"] = false,		-- allows you to scroll frame lines with mousewheel.
	["maxlines"] = 64,		-- max lines to keep in scrollable mode. more lines=more memory. nom nom nom.

-- justify messages in frames, valid values are "RIGHT" "LEFT" "CENTER"
	["justify_1"] = "LEFT",		-- incoming damage justify
	["justify_2"] = "RIGHT",	-- incoming healing justify
	["justify_3"] = "CENTER",	-- various messages justify (mana, rage, auras, etc)
	["justify_4"] = "RIGHT",	-- outgoing damage/healing justify

-- class modules and goodies
	["stopvespam"] = false,		-- automaticly turns off healing spam for priests in shadowform. HIDE THOSE GREEN NUMBERS PLX!
	["dkrunes"] = true,		-- show deatchknight rune recharge
	["mergeaoespam"] = true,	-- merges multiple aoe spam into single message, can be useful for dots too.
	["mergeaoespamtime"] = 3,	-- time in seconds aoe spell will be merged into single message. minimum is 1.
	["killingblow"] = true,		-- tells you about your killingblows
}

C["addonskins"] = {
  ["tinydps"] = true,
}

C["classtimer"] = {
  ["enable"] = false,
  ["bar_height"] = 17,
	["bar_spacing"] = 1,
	["icon_position"] = 2, -- 0 = left, 1 = right, 2 = Outside left, 3 = Outside Right
	["layout"] = 4, --1 - both player and target auras in one frame right above player frame, 2 - player and target auras separated into two frames above player frame, 3 - player, target and trinket auras separated into three frames above player frame, 4 - player and trinket auras are shown above player frame and target auras are shown above target frame, 5 - Everything above player frame, no target debuffs.
	["showspark"] = true,
	["cast_suparator"] = true,
	["classcolor"] = false,
	["buffcolor"] = C["media"].bordercolor, -- if classcolor isnt true
	["debuffcolor"] = {r = 0.78, g = 0.25, b = 0.25},
	["proccolor"] = {r = 0.84, g = 0.75, b = 0.65},
}

C["filger"] = {
  ["enable"] = true,
}

if Z.myclass == "PRIEST" then
	-- do some config!
end

----------------------------------------------------------------------------
-- Per Character Name Config (overwrite general and class)
-- Name need to be case sensitive
----------------------------------------------------------------------------

if Z.myname == "Yourname" then
	-- yeah my default config is not really like default tukui.
	C.actionbar.hotkey = false
	C.actionbar.hideshapeshift = true
	C.unitframes.enemyhcolor = true
end
