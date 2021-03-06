local Z, C, L = unpack(select(2, ...)) -- Import: Z - functions, constants, variables; C - config; L - locales

Z.UIScale = function()
	if Z.getscreenwidth < 1600 then
    Z.lowversion = true
	elseif (Z.getscreenwidth >= 3840) or (UIParent:GetWidth() + 1 > Z.getscreenwidth) then
		local width = Z.getscreenwidth
		local height = Z.getscreenheight
		
		-- because some user enable bezel compensation, we need to find the real width of a single monitor.
		-- I don't know how it really work, but i'm assuming they add pixel to width to compensate the bezel. :P
		
		-- HQ resolution
		if width >= 9840 then width = 3280 end                   	                -- WQSXGA
		if width >= 7680 and width < 9840 then width = 2560 end                     -- WQXGA
		if width >= 5760 and width < 7680 then width = 1920 end 	                -- WUXGA & HDTV
		if width >= 5040 and width < 5760 then width = 1680 end 	                -- WSXGA+
		
		-- adding height condition here to be sure it work with bezel compensation because WSXGA+ and UXGA/HD+ got approx same width
		if width >= 4800 and width < 5760 and height == 900 then width = 1600 end   -- UXGA & HD+
		
		-- low resolution screen
		if width >= 4320 and width < 4800 then width = 1440 end 	                -- WSXGA
		if width >= 4080 and width < 4320 then width = 1360 end 	                -- WXGA
		if width >= 3840 and width < 4080 then width = 1224 end 	                -- SXGA & SXGA (UVGA) & WXGA & HDTV
		
		-- yep, now set zui to lower reso if screen #1 width < 1600
		if width < 1600  then
			Z.lowversion = true
    else
      Z.lowversion = false
		end
		
		-- register a constant, we will need it later for launch.lua
		Z.eyefinity = width
	end
	
	if C["general"].autoscale == true then
		C["general"].uiscale = min(2, max(.64, 768/string.match(({GetScreenResolutions()})[GetCurrentResolution()], "%d+x(%d+)")))
	end

	if Z.lowversion then
		Z.raidscale = 0.8
	else
		Z.raidscale = 1
	end
  Z.raidscale = 1
end

Z.UIScale()