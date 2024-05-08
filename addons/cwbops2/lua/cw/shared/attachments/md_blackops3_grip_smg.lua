local att = {}
att.name = "md_blackops3_grip_smg"
att.displayName = "Submachine Gun Grip"
att.displayNameShort = "SMG.G"
att.isGrip = true

att.statModifiers = {
	VelocitySensitivityMult = -0.1,
	OverallMouseSensMult = 0.3,
	AimSpreadMult = 0.3,
	HipSpreadMult = -0.3,
	MaxSpreadIncMult = 0.15,
	RecoilMult = -0.1,
}

if CLIENT then
	att.displayIcon = surface.GetTextureID("blackops3/icon_atts/cac_mods_foregrip")
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