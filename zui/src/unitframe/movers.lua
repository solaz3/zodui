local Z, C, L = unpack(select(2, ...)) -- Import: Z - functions, constants, variables; C - config; L - locales

-- all the frame we want to move
-- all our frames that we want being movable.
Z.MoverFrames = {
	ZuiMinimap,
	ZuiTooltipAnchor,
	ZuiPlayerBuffs,
	ZuiPlayerDebuffs,
	ZuiShiftBar,
	ZuiRollAnchor,
	ZuiAchievementHolder,
	ZuiWatchFrameAnchor,
	ZuiGMFrameAnchor,
	ZuiVehicleAnchor,
}

-- used to exec various code if we enable or disable moving
local function exec(self, enable)

	if self == ZuiGMFrameAnchor then
		if enable then
			self:Show()
		else
			self:Hide()
		end
	end
	
	if self == ZuiMinimap then
		if enable then 
			Minimap:Hide()
			self:SetBackdropBorderColor(1,0,0,1)
		else 
			Minimap:Show()
			self:SetBackdropBorderColor(unpack(C.media.bordercolor))
		end
	end
	
	if Z.isctm and (self == ZuiPlayerBuffs or self == ZuiPlayerDebuffs) then
		if enable then
			self:SetBackdropColor(unpack(C.media.backdropcolor))
			self:SetBackdropBorderColor(1,0,0,1)	
		else
			local position = self:GetPoint()			
			if position:match("TOPLEFT") or position:match("BOTTOMLEFT") or position:match("BOTTOMRIGHT") or position:match("TOPRIGHT") then
				self:SetAttribute("point", position)
			end
			if position:match("LEFT") then
				self:SetAttribute("xOffset", 36)
			else
				self:SetAttribute("xOffset", -36)
			end
			if position:match("BOTTOM") then
				self:SetAttribute("wrapYOffset", 68)
			else
				self:SetAttribute("wrapYOffset", -68)
			end
			self:SetBackdropColor(0,0,0,0)
			self:SetBackdropBorderColor(0,0,0,0)
		end
	end
	
	if self == ZuiTooltipAnchor or self == ZuiRollAnchor or self == ZuiAchievementHolder or self == ZuiVehicleAnchor then
		if enable then
			self:SetAlpha(1)
		else
			self:SetAlpha(0)
			if self == ZuiTooltipAnchor then 
				local position = ZuiTooltipAnchor:GetPoint()
				local healthBar = GameTooltipStatusBar
				if position:match("TOP") then
					healthBar:ClearAllPoints()
					healthBar:Point("TOPLEFT", healthBar:GetParent(), "BOTTOMLEFT", 2, -5)
					healthBar:Point("TOPRIGHT", healthBar:GetParent(), "BOTTOMRIGHT", -2, -5)
					if healthBar.text then healthBar.text:Point("CENTER", healthBar, 0, -6) end
				else
					healthBar:ClearAllPoints()
					healthBar:Point("BOTTOMLEFT", healthBar:GetParent(), "TOPLEFT", 2, 5)
					healthBar:Point("BOTTOMRIGHT", healthBar:GetParent(), "TOPRIGHT", -2, 5)
					if healthBar.text then healthBar.text:Point("CENTER", healthBar, 0, 6) end			
				end
			end
		end		
	end
	
	if self == ZuiWatchFrameAnchor then
		if enable then
			ZuiWatchFrameAnchor:SetBackdropBorderColor(1,0,0,1)
			ZuiWatchFrameAnchor:SetBackdropColor(unpack(C.media.backdropcolor))		
		else
			ZuiWatchFrameAnchor:SetBackdropBorderColor(0,0,0,0)
			ZuiWatchFrameAnchor:SetBackdropColor(0,0,0,0)		
		end
	end
	
	if self == ZuiShiftBar then
		if enable then
			ZuiShapeShiftHolder:SetAlpha(1)
		else
			ZuiShapeShiftHolder:SetAlpha(0)
			-- used for shaman totembar update
			if Z.myclass == "SHAMAN" and self.moving == false and HasMultiCastActionBar() then
				Z.totemdown = Z.TotemBarOrientation()
			end
		end
	end
end

local enable = true
local origa1, origf, origa2, origx, origy

local function moving()
	-- don't allow moving while in combat
	if InCombatLockdown() then print(ERR_NOT_IN_COMBAT) return end
	
	for i = 1, getn(Z.MoverFrames) do
		if Z.MoverFrames[i] then		
			if enable then			
				Z.MoverFrames[i]:EnableMouse(true)
				Z.MoverFrames[i]:RegisterForDrag("LeftButton", "RightButton")
				Z.MoverFrames[i]:SetScript("OnDragStart", function(self) 
					origa1, origf, origa2, origx, origy = Z.MoverFrames[i]:GetPoint() 
					self.moving = true 
					self:SetUserPlaced(true) 
					self:StartMoving() 
				end)			
				Z.MoverFrames[i]:SetScript("OnDragStop", function(self) 
					self.moving = false 
					self:StopMovingOrSizing() 
				end)			
				exec(Z.MoverFrames[i], enable)			
				if Z.MoverFrames[i].text then 
					Z.MoverFrames[i].text:Show() 
				end
			else			
				Z.MoverFrames[i]:EnableMouse(false)
				if Z.MoverFrames[i].moving == true then
					Z.MoverFrames[i]:StopMovingOrSizing()
					Z.MoverFrames[i]:ClearAllPoints()
					Z.MoverFrames[i]:SetPoint(origa1, origf, origa2, origx, origy)
				end
				exec(Z.MoverFrames[i], enable)
				if Z.MoverFrames[i].text then Z.MoverFrames[i].text:Hide() end
				Z.MoverFrames[i].moving = false
			end
		end
	end
	
	if Z.MoveUnitFrames then Z.MoveUnitFrames() end
	
	if enable then enable = false else enable = true end
end
SLASH_MOVING1 = "/mzui"
SLASH_MOVING2 = "/moveui"
SlashCmdList["MOVING"] = moving

local protection = CreateFrame("Frame")
protection:RegisterEvent("PLAYER_REGEN_DISABLED")
protection:SetScript("OnEvent", function(self, event)
	if enable then return end
	print(ERR_NOT_IN_COMBAT)
	enable = false
	moving()
end)