local Z, C, L = unpack(select(2, ...)) 

if not C.actionbar.enable then return end

---------------------------------------------------------------------------
-- setup MultiBarBottomLeft as bar #2
---------------------------------------------------------------------------

local bar = ZuiBar2
MultiBarBottomLeft:SetParent(bar)

-- setup the bar
for i=1, 9 do
	if i ~= 4 and i ~= 5 and i ~= 6 then
    local b = _G["MultiBarBottomLeftButton"..i]
    local b2 = _G["MultiBarBottomLeftButton"..i-1]
    b:SetSize(Z.buttonsize, Z.buttonsize)
    b:ClearAllPoints()
    b:SetFrameStrata("BACKGROUND")
    b:SetFrameLevel(15)
    if i == 1 then
      b:SetPoint("BOTTOMLEFT", bar, Z.buttonspacing, Z.buttonspacing)
    elseif i == 7 then
      b:SetPoint("TOPLEFT", bar, Z.buttonspacing, -Z.buttonspacing)
    else
      b:SetPoint("LEFT", b2, "RIGHT", Z.buttonspacing, 0)
    end
  end
end

for i=7, 9 do
	local b = _G["MultiBarBottomLeftButton"..i]
	local b2 = _G["MultiBarBottomLeftButton1"]
	b:SetFrameLevel(b2:GetFrameLevel() - 2)
end
