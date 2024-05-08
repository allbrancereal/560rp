include("shared.lua")  


function ENT:Initialize( )	
    self:SetRenderBounds(Vector( -3000, -3000, -3000 ), Vector( 3000, 3000, 3000 ));
end  

-- Safe ParticleEmitter
-- 'Handsome' Matt Stevens
-- If you use this I won't send you a DMCA takedown notice.


function ENT:DrawTranslucent( ) 
	//self:DrawModel()
	if self:GetPos():Distance(LocalPlayer():GetPos()) > 2000 then return; end

	local pos = self:LocalToWorld(self:OBBMaxs());
	local ang = self:GetAngles();
	
	//ang:RotateAroundAxis(ang:Right(), 90); 
    ang:RotateAroundAxis(ang:Up(), -90);
	//ang:RotateAroundAxis(ang:Forward(), -90);
	
	cam.Start3D2D( pos, ang, .2);
		surface.SetFont("SignFont")
		local ShopName = "Test"
		Width, Height = surface.GetTextSize(ShopName)
		//Height = 15;
		//Width = 44;
		
		local xpos = (44 - Width)/2 - 10;
		local ypos = 0;

		surface.SetDrawColor(0, 0, 0, 255)
		surface.DrawRect(xpos, ypos -5 , Width + 20, Height + 10)
		draw.SimpleText(ShopName, 'SignFont', 22, 50, Color(255, 255, 255, 255), 1, 1);
	cam.End3D2D();
end
