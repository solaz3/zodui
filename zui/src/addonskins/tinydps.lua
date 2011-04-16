local Z, C, L = unpack(select(2, ...)) -- Import: Z - functions, constants, variables; C - config; L - locales

if not IsAddOnLoaded("TinyDPS") or C["addonskins"].tinydps == false then return end

-- TinyDPS editless skin, by Dajova
local TinyDPS = CreateFrame("Frame")
TinyDPS:RegisterEvent("ADDON_LOADED")
TinyDPS:RegisterEvent("PLAYER_ENTERING_WORLD")
TinyDPS:SetScript("OnEvent", function(self, event, addon)
	if not addon == "TinyDPS" then return end
	
	if event == "ADDON_LOADED" then
		tdps.width = ZuiMinimap:GetWidth()
		tdps.barHeight = 16
		tdpsFont.name = C["media"].font
		tdpsFont.size = 10

		tdpsPosition = {x = 0, y = -6}

		tdpsFrame:SetHeight(tdps.barHeight + 4)
		tdpsFrame:SetTemplate("Default")
		tdpsFrame:CreateShadow("Default")

		if tdpsStatusBar then
			tdpsStatusBar:SetBackdrop({bgFile = C["media"].norm, edgeFile = C["media"].blank, tile = false, tileSize = 1, edgeSize = 1, insets = { left = 0, right = 0, top = 0, bottom = 0}})
			tdpsStatusBar:SetStatusBarTexture(C["media"].norm)
		end

		self:UnregisterEvent("ADDON_LOADED")
	end
	
	if event == "PLAYER_ENTERING_WORLD" then
		if tdpsStatusBar then
			tdpsStatusBar:SetWidth(ZuiMinimap:GetWidth()-2)
		end
		
		tdpsFrame:SetWidth(ZuiMinimap:GetWidth())
		tdpsAnchor:SetPoint('TOPLEFT', UIParent, 'TOPLEFT', 5, -5)
		
		self:UnregisterEvent("PLAYER_ENTERING_WORLD")
	end
	
end)
