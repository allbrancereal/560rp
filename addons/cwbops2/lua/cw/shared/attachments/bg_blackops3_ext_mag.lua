local att = {}
att.name = "bg_blackops3_ext_mag"
att.displayName = "Extended Mag"
att.displayNameShort = "EXT"
att.isBG = true

att.statModifiers = {}

if CLIENT then
	att.displayIcon = surface.GetTextureID("blackops3/icon_atts/t7_icon_attach_ar_accurate_extmag_01")
	att.description = {[1] = {t = "Increases mag size.", c = CustomizableWeaponry.textColors.POSITIVE}}
end

function att:attachFunc()
	if self.MagBGs and self.MagBGs.ext_mag then
		self:setBodygroup(self.MagBGs.main, self.MagBGs.ext_mag)
	end
	
	self:unloadWeapon()
	if self.Primary.ClipSize_Ext != nil then
		self.Primary.ClipSize = self.Primary.ClipSize_Ext
		self.Primary.ClipSize_Orig = self.Primary.ClipSize_Ext
	else
		self.Primary.ClipSize = self.Primary.ClipSize_ORIG_REAL * 1.4
		self.Primary.ClipSize_Orig = self.Primary.ClipSize_ORIG_REAL * 1.4
	end
end

function att:detachFunc()
	if self.MagBGs and self.MagBGs.ext_mag then
		self:setBodygroup(self.MagBGs.main, self.MagBGs.regular)
	end
	
	self:unloadWeapon()
	self.Primary.ClipSize = self.Primary.ClipSize_ORIG_REAL
	self.Primary.ClipSize_Orig = self.Primary.ClipSize_ORIG_REAL
end

CustomizableWeaponry:registerAttachment(att)