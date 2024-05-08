local att = {}
att.name = "bg_blackops3_fast_mag"
att.displayName = "Fast Mag"
att.displayNameShort = "Fast"
att.isBG = true

att.statModifiers = {}

if CLIENT then
	att.displayIcon = surface.GetTextureID("blackops3/icon_atts/t7_icon_attach_ar_fastburst_fastmag_01")
	att.description = {
	[1] = {t = "Reload faster.", c = CustomizableWeaponry.textColors.POSITIVE},
	[2] = {t = "Gives the second magazine to user.", c = CustomizableWeaponry.textColors.POSITIVE}
	}
end

function att:attachFunc()
	if self.MagBGs and self.MagBGs.fast_mag then
		self:setBodygroup(self.MagBGs.main, self.MagBGs.fast_mag)
	end
	
	self:unloadWeapon()
	self.isFirstMagUsed = true
end

function att:detachFunc()
	if self.MagBGs and self.MagBGs.fast_mag then
		self:setBodygroup(self.MagBGs.main, self.MagBGs.regular)
	end
	
	self:unloadWeapon()
	self.isFirstMagUsed = true
end

CustomizableWeaponry:registerAttachment(att)