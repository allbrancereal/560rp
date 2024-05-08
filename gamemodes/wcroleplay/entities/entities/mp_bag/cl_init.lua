



include('shared.lua')
local doOutline = false;

function ENT:Draw()
	self:DrawModel()

	local ang = self:GetAngles()
	local pos = self:GetPos() + ang:Forward()*0 + ang:Up() * 1 + ang:Right() * 1
	ang:RotateAroundAxis(ang:Forward(),0)
	ang:RotateAroundAxis(ang:Up(),180)
	ang:RotateAroundAxis(ang:Right(),0)
	if ( LocalPlayer():GetPos( ):Distance(  pos ) <= ( 300 ) ) then

		cam.Start3D2D(pos,Angle(ang.p,ang.y,ang.r),0.25) 
			local _heat = "$".. self:getFlag("amount",0)
		
			draw.SimpleTextOutlined(_heat,"Trebuchet24",2,2,Color(224,224,224),TEXT_ALIGN_CENTER,1,1,Color(0,0,0))
		cam.End3D2D()
	end

end

