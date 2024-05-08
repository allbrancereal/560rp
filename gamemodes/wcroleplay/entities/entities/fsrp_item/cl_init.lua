include('shared.lua')

function ENT:Initialize()
self.ShouldDrawHalo = false
end

Mat = Material("darksouls/money.png","noclamp smooth")
ENT.Alpha = 255;

surface.CreateFont("Trebuchet10", {
	font = "Trebuchet MS",
	size = 16,
	weight = 0,
	antialias =false
})
function ENT:Draw(  )
	local ang = LocalPlayer():EyeAngles()
	local pos = self:GetPos() + ang:Up() * 1 + ang:Right() * 1
	ang:RotateAroundAxis(ang:Forward(),90)
	ang:RotateAroundAxis(ang:Right(),90)
	
	local dist = self:GetPos():Distance(LocalPlayer():GetPos());
		
	local _skill = skillpoint_Helper_GetSkillPoint( LocalPlayer() , "perception" ) || 0;
	self.Alpha = 255;
					
	if (dist <= 300+(_skill*75)) then
		self:DrawModel()

		return
	end

	//self:DrawShadow( false )
	self:DestroyShadow()
	//self:Draw2DRepresentation()
end
function ENT:Draw2DRepresentation()

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
		
		cam.Start3D2D( pos ,  Angle(ang.p,ang.y,ang.r) , 0.5 )
		
			
			surface.SetMaterial(  Mat )
			surface.SetDrawColor( Color( 255, 255, 255, self.Alpha ) )
			surface.DrawTexturedRectRotated( 0, 0, 70*1.25 , 45*1.25 ,-_equa+EyePos().y )
			surface.DrawTexturedRectRotated( 0, 0, 75*1.25 , 50*1.25 ,_equa-EyePos().y )
			if !istable(self:getFlag("itemID", nil)) then
			
				draw.SimpleText( ITEMLIST[self:getFlag("itemID", 1)].Name , "Trebuchet10", 0, -25, Color(255,255,255,self.Alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
				
			else
				draw.SimpleText( "Multiple Items" , "Trebuchet10", 0, -25, Color(255,255,255,self.Alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
				
			end
			
		cam.End3D2D()
		
	end
	
end