local att = {}
att.name = "md_blackops3_dw"
att.displayName = "Dual Wield"
att.displayNameShort = "Dual"

att.statModifiers = {
HipSpreadMult = 0.25,
FireDelayMult = -0.25,
}

if CLIENT then
	att.displayIcon = surface.GetTextureID("blackops3/icon_atts/cac_mods_dual_wield")
	att.description = {
	[1] = {t = "Disables the quick melee attack.", c = CustomizableWeaponry.textColors.NEGATIVE},
	[2] = {t = "Disables the iron sight.", c = CustomizableWeaponry.textColors.NEGATIVE},
	}
end

function att:attachFunc()
	if self.DWBGs then
		self:setBodygroup(self.DWBGs.main, self.DWBGs.dw)
	end
	self.DualWieldLogic = true
	self:sendWeaponAnim("dw_idle")
	self:unloadWeapon()
	self.Primary.ClipSize = self.Primary.ClipSize_ORIG_REAL * 2
	self.Primary.ClipSize_Orig = self.Primary.ClipSize_ORIG_REAL * 2
end

function att:detachFunc()
	if self.DWBGs then
		self:setBodygroup(self.DWBGs.main, self.DWBGs.regular)
	end
	self.DualWieldLogic = false
	self:sendWeaponAnim("base_idle")
	self:unloadWeapon()
	self.Primary.ClipSize = self.Primary.ClipSize_ORIG_REAL
	self.Primary.ClipSize_Orig = self.Primary.ClipSize_ORIG_REAL
end

CustomizableWeaponry:registerAttachment(att)