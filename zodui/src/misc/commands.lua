local Z, C, L = unpack(select(2, ...)) -- Import: Z - functions, constants, variables; C - config; L - locales

-- enable or disable an addon via command
SlashCmdList.DISABLE_ADDON = function(addon) local _, _, _, _, _, reason, _ = GetAddOnInfo(addon) if reason ~= "MISSING" then DisableAddOn(addon) ReloadUI() else print("|cffff0000Error, Addon not found.|r") end end
SLASH_DISABLE_ADDON1 = "/disable"
SlashCmdList.ENABLE_ADDON = function(addon) local _, _, _, _, _, reason, _ = GetAddOnInfo(addon) if reason ~= "MISSING" then EnableAddOn(addon) LoadAddOn(addon) ReloadUI() else print("|cffff0000Error, Addon not found.|r") end end
SLASH_ENABLE_ADDON1 = "/enable"

-- switch to heal layout via a command
SLASH_ZUIHEAL1 = "/heal"
SlashCmdList.ZUIHEAL = function()
	DisableAddOn("zodui_dps")
	EnableAddOn("zodui_heal")
	ReloadUI()
end

-- switch to dps layout via a command
SLASH_ZUIDPS1 = "/dps"
SlashCmdList.ZUIDPS = function()
	DisableAddOn("zodui_heal")
	EnableAddOn("zodui_dps")
	ReloadUI()
end

-- fix combatlog manually when it broke
SLASH_CLFIX1 = "/clfix"
SlashCmdList.CLFIX = CombatLogClearEntries

SLASH_RAIDDISBAND1 = "/rd"
SlashCmdList["RAIDDISBAND"] = function()
		SendChatMessage(L.disband, "RAID" or "PARTY")
		if UnitInRaid("player") then
			for i=1, GetNumRaidMembers() do
				local name, _, _, _, _, _, _, online = GetRaidRosterInfo(i)
				if online and name ~= T.myname then
					UninviteUnit(name)
				end
			end
		else
			for i=MAX_PARTY_MEMBERS, 1, -1 do
				if GetPartyMember(i) then
					UninviteUnit(UnitName("party"..i))
				end
			end
		end
		LeaveParty()
end
