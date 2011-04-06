----------------------------------------------------------------
-- initiation of zui
----------------------------------------------------------------

-- including system
local addon, engine = ...
engine[1] = {} -- Z, functions, constants, variables
engine[2] = {} -- C, config
engine[3] = {} -- L, localization

Zui = engine -- Allow other addons to use Engine

---------------------------------------------------------------------------------
--	This should be at the top of every file inside of the Zui AddOn:	
--	local Z, C, L = unpack(select(2, ...))

--	This is how another addon imports the Zui engine:	
--	local Z, C, L = unpack(Zui)
---------------------------------------------------------------------------------

local Z, C, L = unpack(select(2, ...)) -- Import: Z - functions, constants, variables; C - config; L - locales
Z.dummy = function() return end
Z.myname = select(1, UnitName("player"))
Z.myclass = select(2, UnitClass("player"))
Z.client = GetLocale() 
Z.resolution = GetCurrentResolution()
Z.getscreenresolution = select(Z.resolution, GetScreenResolutions())
Z.getscreenheight = tonumber(string.match(({GetScreenResolutions()})[GetCurrentResolution()], "%d+x(%d+)"))
Z.getscreenwidth = tonumber(string.match(({GetScreenResolutions()})[GetCurrentResolution()], "(%d+)x+%d"))
Z.version = GetAddOnMetadata("zodui", "Version")
Z.versionnumber = tonumber(Z.version)
Z.incombat = UnitAffectingCombat("player")
Z.patch = GetBuildInfo()
Z.level = UnitLevel("player")
Z.myrealm = GetRealmName()
Z.InfoLeftRightWidth = 320
Z.Layouts = {} --Unitframe Layouts


------------------------------------------------------------------------
--	ReloadUI command
------------------------------------------------------------------------
SLASH_RELOADUI1 = "/rl"
SlashCmdList.RELOADUI = ReloadUI

-----------------------------------------------------------------------
-- a command to show frame you currently have mouseovered
-----------------------------------------------------------------------
SLASH_FRAME1 = "/frame"
SlashCmdList["FRAME"] = function(arg)
	if arg ~= "" then
		arg = _G[arg]
	else
		arg = GetMouseFocus()
	end
	if arg ~= nil and arg:GetName() ~= nil then
		local point, relativeTo, relativePoint, xOfs, yOfs = arg:GetPoint()
		ChatFrame1:AddMessage("|cffCC0000~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
		ChatFrame1:AddMessage("Name: |cffFFD100"..arg:GetName())
		if arg:GetParent() then
			ChatFrame1:AddMessage("Parent: |cffFFD100"..arg:GetParent():GetName())
		end
 
		ChatFrame1:AddMessage("Width: |cffFFD100"..format("%.2f",arg:GetWidth()))
		ChatFrame1:AddMessage("Height: |cffFFD100"..format("%.2f",arg:GetHeight()))
		ChatFrame1:AddMessage("Strata: |cffFFD100"..arg:GetFrameStrata())
		ChatFrame1:AddMessage("Level: |cffFFD100"..arg:GetFrameLevel())
 
		if xOfs then
			ChatFrame1:AddMessage("X: |cffFFD100"..format("%.2f",xOfs))
		end
		if yOfs then
			ChatFrame1:AddMessage("Y: |cffFFD100"..format("%.2f",yOfs))
		end
		if relativeTo then
			ChatFrame1:AddMessage("Point: |cffFFD100"..point.."|r anchored to "..relativeTo:GetName().."'s |cffFFD100"..relativePoint)
		end
		ChatFrame1:AddMessage("|cffCC0000~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
	elseif arg == nil then
		ChatFrame1:AddMessage("Invalid frame name")
	else
		ChatFrame1:AddMessage("Could not find frame info")
	end
end

--------------------------------------------------
-- enable lua error by command
--------------------------------------------------
function SlashCmdList.LUAERROR(msg, editbox)
	if (msg == 'on') then
		SetCVar("scriptErrors", 1)
		-- because sometime we need to /rl to show an error on login.
		ReloadUI()
	elseif (msg == 'off') then
		SetCVar("scriptErrors", 0)
	else
		print("/luaerror on - /luaerror off")
	end
end
SLASH_LUAERROR1 = '/luaerror'





