local Z, C, L = unpack(select(2, ...)) 

if not C.actionbar.enable then return end
---------------------------------------------------------------------------
-- setup MultiBarLeft as bar #3 
---------------------------------------------------------------------------
local bar = ZuiBar3

for i= 4, 12 do
  if  i ~= 7 and i ~= 8 and i ~= 9 then
    local b = _G["MultiBarBottomLeftButton"..i]
    local b2 = _G["MultiBarBottomLeftButton"..i-1]
    b:SetSize(Z.buttonsize, Z.buttonsize)
    b:ClearAllPoints()
    b:SetFrameStrata("BACKGROUND")
    b:SetFrameLevel(15)
    
    if i == 4 then
      b:SetPoint("BOTTOMLEFT", bar, Z.buttonspacing, Z.buttonspacing)
    elseif i == 10 then
      b:SetPoint("TOPLEFT", bar, Z.buttonspacing, -Z.buttonspacing)
    else
      b:SetPoint("LEFT", b2, "RIGHT", Z.buttonspacing, 0)
    end
  end
end

for i=10, 12 do
	local b = _G["MultiBarBottomLeftButton"..i]
	local b2 = _G["MultiBarBottomLeftButton1"]
	b:SetFrameLevel(b2:GetFrameLevel() - 2)
end