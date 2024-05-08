local att = {}
att.name = "bg_blackops3_stock_light"
att.displayName = "Light Stock"
att.displayNameShort = "L.Stock"
att.isBG = true

att.statModifiers = {DrawSpeedMult = 0.2,
VelocitySensitivityMult = 0.2,
OverallMouseSensMult = 0.25,
RecoilMult = 0.25}

if CLIENT then
	att.displayIcon = surface.GetTextureID("blackops3/icon_atts/t7_icon_attach_ar_fastburst_extstock_01")
end

function att:attachFunc()
	if self.StockBGs then
		self:setBodygroup(self.StockBGs.main, self.StockBGs.light)
	end
end

function att:detachFunc()
	if self.StockBGs then
		self:setBodygroup(self.StockBGs.main, self.StockBGs.regular)
	end
end

CustomizableWeaponry:registerAttachment(att)