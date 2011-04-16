local Z, C, L = unpack(select(2, ...)) -- Import: Z - functions, constants, variables; C - config; L - locales
------------------------------------------------------------------------
--	GM ticket position
------------------------------------------------------------------------
-- create our moving area
local ZuiGMFrameAnchor = CreateFrame("Button", "ZuiGMFrameAnchor", UIParent)
ZuiGMFrameAnchor:SetFrameStrata("TOOLTIP")
ZuiGMFrameAnchor:SetFrameLevel(20)
ZuiGMFrameAnchor:SetHeight(40)
ZuiGMFrameAnchor:SetWidth(TicketStatusFrameButton:GetWidth())
ZuiGMFrameAnchor:SetClampedToScreen(true)
ZuiGMFrameAnchor:SetMovable(true)
ZuiGMFrameAnchor:SetTemplate("Default")
ZuiGMFrameAnchor:SetBackdropBorderColor(1,0,0,1)
ZuiGMFrameAnchor:SetBackdropColor(unpack(C.media.backdropcolor))
ZuiGMFrameAnchor:Point("TOPLEFT", 4, -4)
ZuiGMFrameAnchor.text = Z.SetFontString(ZuiGMFrameAnchor, C.media.font, 12, "THINOUTLINE")
ZuiGMFrameAnchor.text:SetPoint("CENTER")
ZuiGMFrameAnchor.text:SetText(L.move_gmframe)
ZuiGMFrameAnchor.text:SetParent(ZuiGMFrameAnchor)
ZuiGMFrameAnchor:Hide()

TicketStatusFrame:ClearAllPoints()
TicketStatusFrame:SetPoint("TOP", ZuiGMFrameAnchor, "TOP")

------------------------------------------------------------------------
--	GM toggle command
------------------------------------------------------------------------

SLASH_GM1 = "/gm"
SlashCmdList["GM"] = function() ToggleHelpFrame() end