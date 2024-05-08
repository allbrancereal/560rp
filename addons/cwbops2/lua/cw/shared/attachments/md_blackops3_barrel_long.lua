local att = {}
att.name = "md_blackops3_barrel_long"
att.displayName = "Long Barrel"
att.displayNameShort = "Long"
att.isBG = true

att.statModifiers = {
	OverallMouseSensMult = -0.1,
	VelocitySensitivityMult = -0.1,
	RecoilMult = -0.2,
}

if CLIENT then
	att.displayIcon = surface.GetTextureID("blackops3/icon_atts/t7_icon_attach_ar_standard_extbarrel_01")
end

function att:attachFunc()
	if self.BarrelBGs and self.BarrelBGs.long then
		self:setBodygroup(self.BarrelBGs.main, self.BarrelBGs.long)
	end
	
	if self.WMEnt and self.WMBarrelBGs and self.WMBarrelBGs.long then
		self.WMEnt:SetBodygroup(self.WMBarrelBGs.main, self.WMBarrelBGs.long)
	end
end

function att:detachFunc()
	if self.BarrelBGs and self.BarrelBGs.long then
		self:setBodygroup(self.BarrelBGs.main, self.BarrelBGs.regular)
	end
	
	if self.WMEnt and self.WMBarrelBGs and self.WMBarrelBGs.long then
		self.WMEnt:SetBodygroup(self.WMBarrelBGs.main, self.WMBarrelBGs.regular)
	end
end

CustomizableWeaponry:registerAttachment(att)