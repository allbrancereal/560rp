local att = {}
att.name = "md_blackops3_sil_ar"
att.displayName = "Assault Rifle Silencer"
att.displayNameShort = "AR.S"
att.isSuppressor = true

att.statModifiers = {OverallMouseSensMult = -0.1,
RecoilMult = -0.15,
AimSpreadMult = -0.2,
HipSpreadMult = 0.2,
MaxSpreadIncMult = -0.05,
DamageMult = -0.1}

if CLIENT then
	att.displayIcon = surface.GetTextureID("blackops3/icon_atts/t7_icon_attach_ar_fastburst_suppressor_01")
	att.description = {[1] = {t = "Decreases firing noise.", c = CustomizableWeaponry.textColors.POSITIVE}}
end

function att:attachFunc()
	self.dt.Suppressed = true
	if self.BarrelBGs and self.BarrelBGs.none then
		self:setBodygroup(self.BarrelBGs.main, self.BarrelBGs.none)
	end
	
	if self.WMEnt and self.WMBarrelBGs and self.WMBarrelBGs.none then
		self.WMEnt:SetBodygroup(self.WMBarrelBGs.main, self.WMBarrelBGs.none)
	end
end

function att:detachFunc()
	self.dt.Suppressed = false
	if self.BarrelBGs and self.BarrelBGs.none then
		self:setBodygroup(self.BarrelBGs.main, self.BarrelBGs.regular)
	end
	
	if self.WMEnt and self.WMBarrelBGs and self.WMBarrelBGs.none then
		self.WMEnt:SetBodygroup(self.WMBarrelBGs.main, self.WMBarrelBGs.regular)
	end
end

CustomizableWeaponry:registerAttachment(att)