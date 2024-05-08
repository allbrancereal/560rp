local att = {}
att.name = "md_blackops3_bipod"
att.displayName = "Bipod"
att.displayNameShort = "Bipod"

att.statModifiers = {
	VelocitySensitivityMult = -0.1,	
	OverallMouseSensMult = -0.1,
	DrawSpeedMult = -0.1
}

if CLIENT then
	att.displayIcon = surface.GetTextureID("blackops3/icon_atts/cac_mods_bipod")
	att.description = {
		[1] = {t = "When deployed:", c = CustomizableWeaponry.textColors.REGULAR},
		[2] = {t = "Decreases recoil by 70%", c = CustomizableWeaponry.textColors.POSITIVE},
		[3] = {t = "Greatly increases hip fire accuracy", c = CustomizableWeaponry.textColors.POSITIVE}
	}
end

function att:attachFunc()
	if not self.FakeBipod then
		self.BipodInstalled = true
		self.BipodWasDeployed = false
	end
	
	if self.Animations.base_idle != nil then
		self:sendWeaponAnim("base_idle")
	else
		self:sendWeaponAnim("idle")
	end
end

function att:detachFunc()
	if not self.FakeBipod then
		self.BipodInstalled = false
	end
	
	if self.Animations.base_idle != nil then
		self:sendWeaponAnim("base_idle")
	else
		self:sendWeaponAnim("idle")
	end
end

function att:elementRender()
	if not self.FakeBipod then
		local is = self.dt.BipodDeployed	
		local was = self.BipodWasDeployed
		
		if is != was then
			if is then
				self.AttachmentModelsVM[att.name].ent:SetBodygroup(0,1)
			else
				self.AttachmentModelsVM[att.name].ent:SetBodygroup(0,0)
			end	
		end
		
		self.BipodWasDeployed = is
	else
		self.AttachmentModelsVM[att.name].ent:SetBodygroup(0,1)
	end
end

CustomizableWeaponry:registerAttachment(att)