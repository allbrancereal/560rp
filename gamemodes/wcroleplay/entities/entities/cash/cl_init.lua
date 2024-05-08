include('shared.lua')

function ENT:Initialize()

end

ENT.Mat = Material( "darksouls/money.png" )
ENT.Alpha = 0;

function ENT:Think()
	
	if self.Alpha < 128 then
	
		self.Alpha = Lerp( 0.01, self.Alpha , 128 )
		
	end

end

function ENT:Draw()

	//self:DrawModel()
	self:DrawShadow( false )
	self:DestroyShadow()
	local ang = LocalPlayer():EyeAngles()
	local pos = self:GetPos() + ang:Up() * 1 + ang:Right() * 1
	ang:RotateAroundAxis(ang:Forward(),90)
	ang:RotateAroundAxis(ang:Right(),90)
	
	local dist = self:GetPos():Distance(LocalPlayer():GetPos());
		
	local Alpha = 255;
					
	if (dist >= 300) then
		local moreDist = 550 - dist;
		local percOff = moreDist / 250;
				
		self.Alpha = math.Clamp(255 * percOff,0,255);
	end
	if LocalPlayer():GetPos():Distance( self:GetPos() ) < 1000 then
		local _equa = 5* math.sin(CurTime() );
		
		cam.Start3D2D( pos ,  Angle(ang.p,ang.y,ang.r) , 1 )
		
			
			surface.SetMaterial(  self.Mat )
			surface.SetDrawColor( Color( 255, 255, 255, self.Alpha ) )
			surface.DrawTexturedRectRotated( 0, 0, 75 , 50 ,-_equa )
			surface.DrawTexturedRectRotated( 0, 0, 70 , 45 ,_equa )

			
		cam.End3D2D()
		
	end
	
end
