local Z, C, L = unpack(select(2, ...)) -- Import: Z - functions, constants, variables; C - config; L - locales
if not C["actionbar"].enable then return end

---------------------------------------------------------------------------
-- setup MultiBarBottomRight as bar #5
---------------------------------------------------------------------------

local bar = ZuiBar5
MultiBarRight:SetParent(bar)

for i= 1, 12 do
	local b = _G["MultiBarRightButton"..i]
	local b2 = _G["MultiBarRightButton"..i-1]
	b:SetSize(Z.buttonsize, Z.buttonsize)
	b:ClearAllPoints()
	b:SetFrameStrata("BACKGROUND")
	b:SetFrameLevel(15)
	
	if i == 1 then
		b:SetPoint("TOPLEFT", bar, Z.buttonspacing, -Z.buttonspacing)
	else
		b:SetPoint("TOP", b2, "BOTTOM", 0, -Z.buttonspacing)
	end
end

bar = ZuiBar6
MultiBarBottomRight:SetParent(bar)

for i= 1, 12 do
	local b = _G["MultiBarBottomRightButton"..i]
	local b2 = _G["MultiBarBottomRightButton"..i-1]
	b:SetSize(Z.buttonsize, Z.buttonsize)
	b:ClearAllPoints()
	b:SetFrameStrata("BACKGROUND")
	b:SetFrameLevel(15)
	
	if i == 1 then
		b:SetPoint("TOPRIGHT", bar, -Z.buttonspacing, -Z.buttonspacing)
	else
		b:SetPoint("TOP", b2, "BOTTOM", 0, -Z.buttonspacing)
	end
end

for i=1, 12 do
  local b = _G["MultiBarBottomRightButton"..i]
	local b2 = _G["MultiBarRightButton1"]
	b:SetFrameLevel(b2:GetFrameLevel() - 2)
end