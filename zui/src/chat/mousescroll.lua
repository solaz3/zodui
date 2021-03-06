local Z, C, L = unpack(select(2, ...)) -- Import: Z - functions, constants, variables; C - config; L - locales
if not C["chat"].enable then return end
------------------------------------------------------------------------
--	Enhance/rewrite a Blizzard feature, chatframe mousewheel.
------------------------------------------------------------------------
local numlines = 3
function FloatingChatFrame_OnMouseScroll(self, delta)
	if delta < 0 then
		if IsShiftKeyDown() then
			self:ScrollToBottom()
		else
			for i=1, numlines do
				self:ScrollDown()
			end
		end
	elseif delta > 0 then
		if IsShiftKeyDown() then
			self:ScrollToTop()
		else
			for i=1, numlines do
				self:ScrollUp()
			end
		end
	end
end