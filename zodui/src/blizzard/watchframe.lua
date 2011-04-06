local Z, C, L = unpack(select(2, ...)) -- Import: T - functions, constants, variables; C - config; L - locales

local ZuiWatchFrame = CreateFrame("Frame", "ZuiWatchFrame", UIParent)
ZuiWatchFrame:RegisterEvent("PLAYER_ENTERING_WORLD")

-- to be compatible with blizzard option
local wideFrame = GetCVar("watchFrameWidth")

-- create our moving area
local ZuiWatchFrameAnchor = CreateFrame("Button", "ZuiWatchFrameAnchor", UIParent)
ZuiWatchFrameAnchor:SetFrameStrata("HIGH")
ZuiWatchFrameAnchor:SetFrameLevel(20)
ZuiWatchFrameAnchor:SetHeight(20)
ZuiWatchFrameAnchor:SetClampedToScreen(true)
ZuiWatchFrameAnchor:SetMovable(true)
ZuiWatchFrameAnchor:EnableMouse(false)
--ZuiWatchFrameAnchor:SetTemplate("Default")
ZuiWatchFrameAnchor:SetBackdropBorderColor(0,0,0,0)
ZuiWatchFrameAnchor:SetBackdropColor(0,0,0,0)
ZuiWatchFrameAnchor.text = Z.SetFontString(ZuiWatchFrameAnchor, C.media.uffont, 12)
ZuiWatchFrameAnchor.text:SetPoint("CENTER")
ZuiWatchFrameAnchor.text:SetText(L.move_watchframe)
ZuiWatchFrameAnchor.text:Hide()

-- set default position according to how many right bars we have
  ZuiWatchFrameAnchor:Point("TOPRIGHT", Minimap, "BOTTOMLEFT", 40, -20)
  
-- width of the watchframe according to our Blizzard cVar.
if wideFrame == "1" then
	ZuiWatchFrame:SetWidth(350)
	ZuiWatchFrameAnchor:SetWidth(350)
else
	ZuiWatchFrame:SetWidth(250)
	ZuiWatchFrameAnchor:SetWidth(250)
end

local screenheight = Z.getscreenheight
ZuiWatchFrame:SetParent(ZuiWatchFrameAnchor)
ZuiWatchFrame:SetHeight(screenheight / 1.6)
ZuiWatchFrame:ClearAllPoints()
ZuiWatchFrame:SetPoint("TOP")

local function init()
	ZuiWatchFrame:UnregisterEvent("PLAYER_ENTERING_WORLD")
	ZuiWatchFrame:RegisterEvent("CVAR_UPDATE")
	ZuiWatchFrame:SetScript("OnEvent", function(_,_,cvar,value)
		if cvar == "WATCH_FRAME_WIDTH_TEXT" then
			if not WatchFrame.userCollapsed then
				if value == "1" then
					ZuiWatchFrame:SetWidth(350)
					ZuiWatchFrameAnchor:SetWidth(350)
				else
					ZuiWatchFrame:SetWidth(250)
					ZuiWatchFrameAnchor:SetWidth(250)
				end
			end
			wideFrame = value
		end
	end)
end

local function setup()	
	WatchFrame:SetParent(ZuiWatchFrame)
	WatchFrame:SetFrameStrata("MEDIUM")
	WatchFrame:SetFrameLevel(3)
	WatchFrame:SetClampedToScreen(false)
	WatchFrame:ClearAllPoints()
	WatchFrame.ClearAllPoints = function() end
	WatchFrame:SetPoint("TOPLEFT", 32,-2.5)
	WatchFrame:SetPoint("BOTTOMRIGHT", 4,0)
	WatchFrame.SetPoint = Z.dummy

	WatchFrameTitle:SetParent(ZuiWatchFrame)
	WatchFrameCollapseExpandButton:SetParent(ZuiWatchFrame)
	WatchFrameCollapseExpandButton:SetFrameStrata(WatchFrameHeader:GetFrameStrata())
	WatchFrameCollapseExpandButton:SetFrameLevel(WatchFrameHeader:GetFrameLevel() + 1)
	WatchFrameCollapseExpandButton:SetNormalTexture("")
	WatchFrameCollapseExpandButton:SetPushedTexture("")
	WatchFrameCollapseExpandButton:SetHighlightTexture("")
	WatchFrameCollapseExpandButton:SetTemplate("Default")
	WatchFrameCollapseExpandButton:FontString("text", C.media.font, 12)
	WatchFrameCollapseExpandButton.text:SetText("X")
	WatchFrameCollapseExpandButton.text:Point("CENTER", -1, 1)
	WatchFrameCollapseExpandButton:HookScript("OnClick", function(self) 
		if WatchFrame.collapsed then 
			self.text:SetText("V") 
		else 
			self.text:SetText("X")
		end 
	end)
	WatchFrameTitle:Kill()
end

------------------------------------------------------------------------
-- Execute setup after we enter world
------------------------------------------------------------------------

local f = CreateFrame("Frame")
f:Hide()
f.elapsed = 0
f:SetScript("OnUpdate", function(self, elapsed)
	f.elapsed = f.elapsed + elapsed
	if f.elapsed > .5 then
		setup()
		f:Hide()
	end
end)
ZuiWatchFrame:SetScript("OnEvent", function() if not IsAddOnLoaded("Who Framed Watcher Wabbit") or not IsAddOnLoaded("Fux") then init() f:Show() end end)