local att = {}
att.name = "md_blackops3_cover"
att.displayName = "Rail Cover"
att.displayNameShort = "Cover"

att.statModifiers = {OverallMouseSensMult = -0.05,
RecoilMult = -0.1}

if CLIENT then
	att.displayIcon = surface.GetTextureID("blackops3/icon_atts/t7_icon_attach_sniper_chargeshot_fmj_01")
end

function att:attachFunc()
	if self.RailBGs then
		self:setBodygroup(self.RailBGs.main, self.RailBGs.cover)
	end
	
	if self.WMEnt and self.WMRailBGs then
		self.WMEnt:setBodygroup(self.WMRailBGs.main, self.WMRailBGs.cover)
	end
end

function att:detachFunc()
	if self.RailBGs then
		self:setBodygroup(self.RailBGs.main, self.RailBGs.regular)
	end
	
	if self.WMEnt and self.WMRailBGs then
		self.WMEnt:setBodygroup(self.WMRailBGs.main, self.WMRailBGs.regular)
	end
end

CustomizableWeaponry:registerAttachment(att)