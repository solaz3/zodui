local Z, C, L = unpack(select(2, ...)) -- Import: T - functions, constants, variables; C - config; L - locales

--------------------------------------------------------------------
-- player power (attackpower or power depending on what you have more of)
--------------------------------------------------------------------

if C["datatext"].power and C["datatext"].power > 0 then
	local Stat = CreateFrame("Frame")
	Stat:SetFrameStrata("BACKGROUND")
	Stat:SetFrameLevel(3)

	local Text  = ZuiInfoLeft:CreateFontString(nil, "OVERLAY")
	Text:SetFont(C.media.pxfont, C["datatext"].fontsize,C["datatext"].fontflag)
	Z.SetDataText(C["datatext"].power, Text)

	local int = 1

	local function Update(self, t)
		int = int - t
		local base, posBuff, negBuff = UnitAttackPower("player")
		local effective = base + posBuff + negBuff
		local Rbase, RposBuff, RnegBuff = UnitRangedAttackPower("player")
		local Reffective = Rbase + RposBuff + RnegBuff


		healpwr = GetSpellBonusHealing()

		Rattackpwr = Reffective
		spellpwr2 = GetSpellBonusDamage(7)
		attackpwr = effective

		if healpwr > spellpwr2 then
			spellpwr = healpwr
		else
			spellpwr = spellpwr2
		end

		if attackpwr > spellpwr and Z.myclass ~= "HUNTER" then
			pwr = attackpwr
			tp_pwr = "AP"
		elseif Z.myclass == "HUNTER" then
			pwr = Reffective
			tp_pwr = "AP"
		else
			pwr = spellpwr
			tp_pwr = "SP"
		end
		if int < 0 then
			Text:SetText(pwr..hexa..tp_pwr..hexb)      
			int = 1
		end
	end

	Stat:SetScript("OnUpdate", Update)
	Update(Stat, 10)
end