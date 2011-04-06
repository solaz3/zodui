local Z, C, L = unpack(select(2, ...)) -- Import Functions/Constants, Config, Locales

function Z.LoadLayout(layout)
	for name, func in pairs(Z.Layouts) do
		if name == layout then
			func() 
			Z.LoadLayout = nil --only load 1 layout
			wipe(Z.Layouts) --only load 1 layout
			break
		end
	end
end
Z.LoadLayout(C["general"].layoutoverride)