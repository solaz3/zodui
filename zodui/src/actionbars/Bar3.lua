local Z, C, L = unpack(select(2, ...)) -- Import: Z - functions, constants, variables; C - config; L - locales
---------------------------------------------------------------------------
-- setup MultiBarLeft as bar #3 
---------------------------------------------------------------------------

local bar = TukuiBar2
MultiBarBottomRight:SetParent(bar)

for i= 1, 12 do
	local b = _G["MultiBarBottomRightButton"..i]
	local b2 = _G["MultiBarBottomRightButton"..i-1]
	b:SetSize(Z.buttonsize, Z.buttonsize)
	b:ClearAllPoints()
	b:SetFrameStrata("BACKGROUND")
	b:SetFrameLevel(15)
  if i < 7 then
    if i == 1 then
      b:SetPoint("TOPLEFT",  TukuiBar2, "TOPLEFT", Z.buttonspacing, -Z.buttonspacing)
    elseif i == 4 then
      b:SetPoint("BOTTOMLEFT",  TukuiBar2, "BOTTOMLEFT", Z.buttonspacing, Z.buttonspacing)
    else
      b:SetPoint("LEFT", b2, "RIGHT", Z.buttonspacing, 0)
    end
  else
    if i == 7 then
      b:SetPoint("TOPRIGHT",  TukuiBar3, "TOPRIGHT", -Z.buttonspacing, -Z.buttonspacing)
    elseif i == 10 then
      b:SetPoint("BOTTOMRIGHT",  TukuiBar3, "BOTTOMRIGHT", -Z.buttonspacing, Z.buttonspacing)
    else
      b:SetPoint("RIGHT", b2, "LEFT", -Z.buttonspacing, 0)
    end
  end   
end
