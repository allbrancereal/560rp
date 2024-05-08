local att = {}
att.name = "md_blackops3_grip_ar"
att.displayName = "Assault Rifle Grip"
att.displayNameShort = "AR.G"
att.isGrip = true

att.statModifiers = {
	VelocitySensitivityMult = -0.15,
	OverallMouseSensMult = -0.15,
	AimSpreadMult = -0.25,
	HipSpreadMult = 0.25,
	RecoilMult = -0.2,
}

if CLIENT then
	att.displayIcon = surface.GetTextureID("blackops3/icon_atts/t7_icon_attach_ar_fastburst_grip_01")
end

function att:attachFunc()
	if self.Animations.grip_idle != nil then
		self:sendWeaponAnim("grip_idle")
	end
	self.isGripAttached = true
end

function att:detachFunc()
	if self.Animations.base_idle != nil then
		self:sendWeaponAnim("base_idle")
	end
	self.isGripAttached = false
end

CustomizableWeaponry:registerAttachment(att)