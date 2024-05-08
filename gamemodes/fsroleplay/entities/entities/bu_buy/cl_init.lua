include('shared.lua')

function ENT:Initialize()
end


function ENT:Draw(  )
	self:DrawModel()

	local Pos = self:GetPos()
	local Ang = self:GetAngles()

	Ang:RotateAroundAxis( Ang:Up(), 90)
	Ang:RotateAroundAxis( Ang:Forward(), 2)

	Ang = Ang + Angle( 0, 0, 0 )

	cam.Start3D2D(Pos + Vector( 0, -25 , 0 ), Ang + Angle(90, -90 , 90 ) , 0.125)
		draw.SimpleTextOutlined( "The Bank", "Trebuchet18", 0, -60, Color(255, 169, 0, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Color( 0, 0, 0, 255 ) ) 
	cam.End3D2D()
end
