local att = {}
att.name = "bg_blackops3_stock_heavy"
att.displayName = "Heavy Stock"
att.displayNameShort = "H.Stock"
att.isBG = true

att.statModifiers = {DrawSpeedMult = -0.1,
RecoilMult = -0.15,
VelocitySensitivityMult = -0.1,
OverallMouseSensMult = -0.1}

if CLIENT then
	att.displayIcon = surface.GetTextureID("blackops3/icon_atts/cac_mods_extended_stock")
end

function att:attachFunc()
	if self.StockBGs then
		self:setBodygroup(self.StockBGs.main, self.StockBGs.heavy)
	end
end

function att:detachFunc()
	if self.StockBGs then
		self:setBodygroup(self.StockBGs.main, self.StockBGs.regular)
	end
end

CustomizableWeaponry:registerAttachment(att)