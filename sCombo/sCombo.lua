-- sCombo
local Z, C, L = unpack(Zodui) -- Import: Z - functions, constants, variables; C - config; L - locales

if IsAddOnLoaded("zui_dps") then
  ftar = DPSTarget
elseif IsAddOnLoaded("zui_heal") then
  ftar = HealTarget
end

ftar:DisableElement('CPoints')
for i = 1, 5 do ftar.CPoints[i]:Hide() end
local Options = {
    x = Z.Scale(3),
    comboWidth = Z.Scale(55),
    comboHeight = Z.Scale(10),
    anchor = {"CENTER", UIParent, "CENTER", -120, -200},
    colors = {
        [1] = {0.69, 0.31, 0.31, 1},
        [2] = {0.65, 0.42, 0.31, 1},
        [3] = {0.65, 0.63, 0.35, 1},
        [4] = {0.46, 0.63, 0.35, 1},
        [5] = {0.33, 0.63, 0.33, 1},
    },
}
local sCombo = CreateFrame("Frame", "sCombo", UIParent)
for i = 1, 5 do
    sCombo[i] = CreateFrame("Frame", "sCombo"..i, UIParent)
    sCombo[i]:CreatePanel("Default", Options.comboWidth, Options.comboHeight, "CENTER", UIParent, "CENTER", 0, 0)
    sCombo[i]:CreateShadow("Default")
    if i == 1 then
        sCombo[i]:Point(unpack(Options.anchor))
    else
        sCombo[i]:Point("LEFT", sCombo[i-1], "RIGHT", Options.x, 0)
    end
    sCombo[i]:SetBackdropBorderColor(unpack(Options.colors[i]))
    sCombo[i]:RegisterEvent("PLAYER_ENTERING_WORLD")
    sCombo[i]:RegisterEvent("UNIT_COMBO_POINTS")
    sCombo[i]:RegisterEvent("PLAYER_TARGET_CHANGED")
    sCombo[i]:SetScript("OnEvent", function(self, event)
    local points, pt = 0, GetComboPoints("player", "target")
        if pt == points then
            sCombo[i]:Hide()
        elseif pt > points then
            for i = points + 1, pt do
                sCombo[i]:Show()
            end
        else
            for i = pt + 1, points do
                sCombo[i]:Hide()
            end
        end
        points = pt
    end)
end

local sPowerBG = CreateFrame("Frame", "sPowerBG", UIParent)
sPowerBG:CreatePanel("Default", (Options.comboWidth * 5) + (Options.x * 5) - Options.x, Options.comboHeight, "TOPLEFT", sCombo[1], "BOTTOMLEFT", 0, -Options.x)
sPowerBG:CreateShadow("Default")
local sPowerStatus = CreateFrame("StatusBar", "sPowerStatus", UIParent)
sPowerStatus:SetStatusBarTexture(C["media"].norm)
sPowerStatus:SetFrameLevel(6)
sPowerStatus:Point("TOPLEFT", sPowerBG, "TOPLEFT", 2, -2)
sPowerStatus:Point("BOTTOMRIGHT", sPowerBG, "BOTTOMRIGHT", -2, 2)
local color = RAID_CLASS_COLORS[Z.myclass]
sPowerStatus:SetStatusBarColor(color.r, color.g, color.b)
local t = 0
sPowerStatus:SetScript("OnUpdate", function(self, elapsed)
    t = t + elapsed;
    if (t > 0.07) then
        sPowerStatus:SetMinMaxValues(0, UnitPowerMax("player"))
        local power = UnitPower("player")
        sPowerStatus:SetValue(power)
    end
end)
sPowerBG:RegisterEvent("PLAYER_ENTERING_WORLD")
sPowerBG:RegisterEvent("UNIT_DISPLAYPOWER")
sPowerBG:SetScript("OnEvent", function(self, event)
  local p, _ = UnitPowerType("player")
  if p == SPELL_POWER_ENERGY then
    sPowerBG:Show()
    sPowerStatus:Show()
  else
    sPowerBG:Hide()
    sPowerStatus:Hide()
  end
end)