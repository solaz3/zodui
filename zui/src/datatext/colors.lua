-- Color system for Hydra datatexts
local Z, C, L = unpack(select(2, ...))
local ccolor = RAID_CLASS_COLORS[Z.myclass]
hexa, hexb = C["datatext"].color, "|r"

if C["datatext"].classcolor then
	hexa = string.format("|c%02x%02x%02x%02x", 255, ccolor.r * 255, ccolor.g * 255, ccolor.b * 255)
end
