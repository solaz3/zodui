local Z, C, L = unpack(select(2, ...)) -- Import: Z - functions, constants, variables; C - config; L - locales

if not IsAddOnLoaded("Recount") or C["addonskins"].recount == false then return end

local Recount = _G.Recount

local function SkinFrame(frame)
	frame.bgMain = CreateFrame("Frame", nil, frame)
	frame.bgMain:SetTemplate("Transparent")
	frame.bgMain:CreateShadow("Default")
	frame.bgMain:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT")
	frame.bgMain:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT")
	frame.bgMain:SetPoint("TOP", frame, "TOP", 0, -7)
	frame.bgMain:SetFrameLevel(frame:GetFrameLevel())
	frame.CloseButton:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -1, -9)
	frame:SetBackdrop(nil)
end

-- Override bar textures
Recount.UpdateBarTextures = function(self)
	for k, v in pairs(Recount.MainWindow.Rows) do
		v.StatusBar:SetStatusBarTexture(C["media"].normTex)
		v.StatusBar:GetStatusBarTexture():SetHorizTile(false)
		v.StatusBar:GetStatusBarTexture():SetVertTile(false)
	end
	Recount:SetFont(C["media"].font)
end
Recount.SetBarTextures = Recount.UpdateBarTextures

-- Fix bar textures as they're created
Recount.SetupBar_ = Recount.SetupBar
Recount.SetupBar = function(self, bar)
	self:SetupBar_(bar)
	bar.StatusBar:SetStatusBarTexture(C["media"].normTex)
end

-- Skin frames when they're created
Recount.CreateFrame_ = Recount.CreateFrame
Recount.CreateFrame = function(self, Name, Title, Height, Width, ShowFunc, HideFunc)
	local frame = self:CreateFrame_(Name, Title, Height, Width, ShowFunc, HideFunc)
	SkinFrame(frame)
	return frame
end

-- Skin existing frames
if Recount.MainWindow then SkinFrame(Recount.MainWindow) end
if Recount.ConfigWindow then SkinFrame(Recount.ConfigWindow) end
if Recount.GraphWindow then SkinFrame(Recount.GraphWindow) end
if Recount.DetailWindow then SkinFrame(Recount.DetailWindow) end
if Recount.ResetFrame then SkinFrame(Recount.ResetFrame) end
if _G["Recount_Realtime_!RAID_DAMAGE"] then SkinFrame(_G["Recount_Realtime_!RAID_DAMAGE"].Window) end
if _G["Recount_Realtime_!RAID_HEALING"] then SkinFrame(_G["Recount_Realtime_!RAID_HEALING"].Window) end
if _G["Recount_Realtime_!RAID_HEALINGTAKEN"] then SkinFrame(_G["Recount_Realtime_!RAID_HEALINGTAKEN"].Window) end
if _G["Recount_Realtime_!RAID_DAMAGETAKEN"] then SkinFrame(_G["Recount_Realtime_!RAID_DAMAGETAKEN"].Window) end
if _G["Recount_Realtime_Bandwidth Available_AVAILABLE_BANDWIDTH"] then SkinFrame(_G["Recount_Realtime_Bandwidth Available_AVAILABLE_BANDWIDTH"].Window) end
if _G["Recount_Realtime_FPS_FPS"] then SkinFrame(_G["Recount_Realtime_FPS_FPS"].Window) end
if _G["Recount_Realtime_Latency_LAG"] then SkinFrame(_G["Recount_Realtime_Latency_LAG"].Window) end
if _G["Recount_Realtime_Downstream Traffic_DOWN_TRAFFIC"] then SkinFrame(_G["Recount_Realtime_Downstream Traffic_DOWN_TRAFFIC"].Window) end
if _G["Recount_Realtime_Upstream Traffic_UP_TRAFFIC"] then SkinFrame(_G["Recount_Realtime_Upstream Traffic_UP_TRAFFIC"].Window) end

--Update Textures
Recount:UpdateBarTextures()
