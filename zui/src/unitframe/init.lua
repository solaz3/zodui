local Z, C, L = unpack(select(2, ...)) -- Import Functions/Constants, Config, Locales

function Z.LoadLayout(layout)
	for name, func in pairs(Z.layouts) do
		if name == layout then
			func() 
			Z.LoadLayout = nil --only load 1 layout
			wipe(Z.layouts) --only load 1 layout
			break
		end
	end
end
Z.LoadLayout(C["general"].layoutoverride)