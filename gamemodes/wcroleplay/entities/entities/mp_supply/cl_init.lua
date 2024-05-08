



include('shared.lua')
local doOutline = false;

function ENT:Draw()
	self:DrawModel()

	local ang = self:GetAngles()
	local pos = self:GetPos() + ang:Forward()*15 + ang:Up() * 8 + ang:Right() * 12.5
	ang:RotateAroundAxis(ang:Forward(),-90)
	ang:RotateAroundAxis(ang:Up(),180)
	ang:RotateAroundAxis(ang:Right(),90)


end

