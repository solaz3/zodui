-- Standalone Castbar for Tukui by Krevlorne @ EU-Ulduar
-- Credits to Tukz, Syne, Elv22, Sweeper and all other great people of the Tukui community.

local Z, C, L = unpack(Zodui) -- Import: Z - functions, constants, variables; C - config; L - locales

if ( C == nil or C["unitframes"] == nil or not C["unitframes"]["enable"] ) then return end

if (C["unitframes"].unitcastbar ~= true) then return; end

if IsAddOnLoaded("zui_dps") then
  fply = DPSPlayer
  ftar = DPSTarget
  ffcs = DPSFocus
  fft = DPSFocustarget
elseif IsAddOnLoaded("zui_heal") then
  fply = HealPlayer
  ftar = HealTarget
  ffcs = HealFocus
  fft = HealFocustarget
end

local addon, ns=...
config = ns.config

local function placeCastbar(unit)
    local font1 = C["media"].uffont
    local font2 = C["media"].pxfont
    local castbar = nil
    local castbarpanel = nil
    
    if (unit == "player") then
        castbar = fply.Castbar
        castbarname = "PlayerCastBar"
    elseif (unit == "target") then
        castbar = ftar.Castbar
        castbarname = "TargetCastBar"
    elseif (unit == "focus") then
        castbar = ffcs.Castbar
        castbarname = "FocusCastBar"
    elseif (unit == "focustarget") then
        castbar = fft.Castbar
        castbarname = "FocusTargetCastBar"
    else
        print("zui_castbar: Cannot place castbar for unit: "..unit)
        return
    end

    local castbarpanel = CreateFrame("Frame", castbarname.."_Panel", castbar)
    castbarpanel:CreateShadow("Default")
    local anchor = CreateFrame("Button", castbarname.."_PanelAnchor", UIParent)
    anchor:SetTemplate("Default")
    anchor:SetBackdropBorderColor(1, 0, 0, 1)
    anchor:SetMovable(true)
    anchor.text = Z.SetFontString(anchor, font1, 12, "THINOUTLINE")
    anchor.text:SetPoint("CENTER")
    anchor.text:SetText(castbarname)
    anchor.text.Show = function() anchor:Show() end
    anchor.text.Hide = function() anchor:Hide() end
    anchor:Hide()
    
    if unit == "player" then
        anchor:SetSize(config["player"]["width"], config["player"]["height"])
        anchor:SetPoint("CENTER", UIParent, "CENTER", 0, -200)
        castbarpanel:CreatePanel("Default", config["player"]["width"], config["player"]["height"], "CENTER", anchor, "CENTER", 0, 0)
    elseif (unit == "target") then
        anchor:SetSize(config["target"]["width"], config["target"]["height"])
        anchor:SetPoint("CENTER", UIParent, "CENTER", 0, -150)
        castbarpanel:CreatePanel("Default", config["target"]["width"], config["target"]["height"], "CENTER", anchor, "CENTER", 0, 0)
    elseif (unit == "focus") then
        anchor:SetSize(config["focus"]["width"], config["focus"]["height"])
        anchor:SetPoint("CENTER", UIParent, "CENTER", 0, 250)
        castbarpanel:CreatePanel("Default", config["focus"]["width"], config["focus"]["height"], "CENTER", anchor, "CENTER", 0, 0)
    elseif (unit == "focustarget") then
        anchor:SetSize(config["focustarget"]["width"], config["focustarget"]["height"])
        anchor:SetPoint("CENTER", UIParent, "CENTER", 0, 210)
        castbarpanel:CreatePanel("Default", config["focustarget"]["width"], config["focustarget"]["height"], "CENTER", anchor, "CENTER", 0, 0)
    end
    
    castbar:ClearAllPoints()        
    castbar:Point("TOPLEFT", castbarpanel, 2, -2)
    castbar:Point("BOTTOMRIGHT", castbarpanel, -2, 2)

    castbar.time = Z.SetFontString(castbar, font2, 12, "OUTLINEMONOCHROME")
    castbar.time:Point("RIGHT", castbarpanel, "RIGHT", -4, 0)
    castbar.time:SetTextColor(0.84, 0.75, 0.65)
    castbar.time:SetJustifyH("RIGHT")

    castbar.Text = Z.SetFontString(castbar, font1, 12)
    castbar.Text:Point("LEFT", castbarpanel, "LEFT", 4, 0)
    castbar.Text:SetTextColor(0.84, 0.75, 0.65)

    if C["unitframes"].cbicons == true then
        if unit == "player" then
            castbar.Button:ClearAllPoints()
            castbar.Button:Point("RIGHT", castbar, "LEFT", -10, 0)
        elseif unit == "target" then
            castbar.Button:ClearAllPoints()
            castbar.Button:Point("LEFT", castbar, "RIGHT", 10, 0)
        elseif unit == "focus" then
            castbar.Button:ClearAllPoints()
            castbar.Button:Point("BOTTOM", castbar, "TOP", 0, 10)
            castbar.Button:Size(50)
            castbar.Button:CreateShadow("Default")
            
            castbar.Icon:Point("TOPLEFT", castbar.Button, 2, -2)
            castbar.Icon:Point("BOTTOMRIGHT", castbar.Button, -2, 2)
            castbar.Icon:SetTexCoord(0.08, 0.92, 0.08, .92)
        elseif unit == "focustarget" then
            castbar.Button:Size(26)
            castbar.Button:CreateShadow("Default")
            castbar.Button:Point("LEFT", castbar, "RIGHT", 10, 0)
        end
    end
    
    -- cast bar latency
    local normTex = C["media"].norm;
    if C["unitframes"].cblatency == true and (unit == "player" or unit == "target") then
        castbar.safezone = castbar:CreateTexture(nil, "ARTWORK")
        castbar.safezone:SetTexture(normTex)
        castbar.safezone:SetVertexColor(0.69, 0.31, 0.31, 0.75)
        castbar.SafeZone = castbar.safezone
    end
    
    castbar.Castbar = castbar    
    castbar.Castbar.Time = castbar.time
    castbar.Castbar.Icon = castbar.Icon
end


if (config.separateplayer) then
    placeCastbar("player")
    table.insert(Z.MoverFrames, PlayerCastBar_PanelAnchor)
end

if (config.separatetarget) then
    placeCastbar("target")
    table.insert(Z.MoverFrames, TargetCastBar_PanelAnchor)
end

if (config.separatefocus) then
    placeCastbar("focus")
    table.insert(Z.MoverFrames, FocusCastBar_PanelAnchor)
end

if (config.separatefocustarget and C["unitframes"].showfocustarget) then
    placeCastbar("focustarget")
    table.insert(Z.MoverFrames, FocusTargetCastBar_PanelAnchor)
end
