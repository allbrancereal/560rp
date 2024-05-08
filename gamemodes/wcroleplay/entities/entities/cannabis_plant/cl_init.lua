include('shared.lua')

surface.CreateFont("cannabis_Plant_Font",{font = "Arial",size = 30,weight = 1000,blursize = 0,scanlines = 0,antialias = true})
surface.CreateFont("cannabis_Plant_Font2", {font = "Arial",size = 25,weight = 1000,blursize = 0,scanlines = 0,antialias = true})
/*local _lodConVar = CreateClientConVar( "fs_lod", "3", true, false );
function GetLod()

	return _lodConVar:GetInt()
	
end

local _lod = {
	[0] = 7500,
	[1] = 5000,
	[2] = 2500,
	[3] = 2000,
	[4] = 1500,
	[5] = 1000,
	[6] = 750,
	[7] = 500,
}
*/
function ENT:Initialize()

		
end

function ENT:Draw(  )
	local ang = LocalPlayer():EyeAngles()
	local pos = self:GetPos() + ang:Up() * 1 + ang:Right() * 1
	ang:RotateAroundAxis(ang:Forward(),90)
	ang:RotateAroundAxis(ang:Right(),90)
	
	local dist = self:GetPos():Distance(LocalPlayer():GetPos());
		
	local _skill = skillpoint_Helper_GetSkillPoint( LocalPlayer() , "perception" ) || 0;
	self.Alpha = 255;
					
	if (dist <= 3000+(_skill*75)) then
		self:DrawModel()

		return
	end

	//self:DrawShadow( false )
	self:DestroyShadow()
	//self:Draw2DRepresentation()
end
/*
function ENT:Draw()
	self:DrawShadow(false)
	if self:GetPos():Distance(LocalPlayer():GetPos()) < _lod[GetLod()] then
		self:DrawShadow(true)
		self:DrawModel() 
		/*
		local ang = self:GetAngles()
		local Time = CurTime()
		ang:RotateAroundAxis(ang:Forward(), 90);

		local plant_spawn_time = self:getFlag( "weed_SpawnTime", CurTime() )	

		//local plant_owner = (self:getFlag("ownedBy", "")
		
		
		cam.Start3D2D( self:GetPos()+(self:GetAngles():Right()*17)+(self:GetAngles():Up()*1), ang, 0.05 )

			--Plant Background
			surface.SetDrawColor( Color( 0,0,0, 200 ) )
			surface.DrawRect( -6*20, -11*20, 12*20, 12*13 )

			--Plant Title Text
			surface.SetDrawColor( Color( 255,255,255, 255 ) )
			surface.SetFont( "cannabis_Plant_Font" )
			surface.SetTextColor( 0, 255, 0, 255 )
			
			local TextWidth = surface.GetTextSize("cannabis Plant")
			surface.SetTextPos( -3.8*23,-10.5*20 ) 
			surface.DrawText("Cannabis Plant")	

			--Plant Owner Text
			surface.SetDrawColor( Color( 255,255,255, 255 ) )
			surface.SetFont( "cannabis_Plant_Font" )
			surface.SetTextColor( 255, 0, 0, 255 )
			
			local TextWidth = surface.GetTextSize(plant_owner)
			surface.SetTextPos( -4*23,-10.5*16 ) 
			surface.DrawText(string.sub(plant_owner, 1, 15).. "..")	

			--Plant Timer and Ready to pick Text
			surface.SetDrawColor( Color( 30,30,30, 255 ) )
			surface.DrawRect( -6*20, -2.5*48, 12*20, 2*20 )
			
			local timeleft = 1  		
			
			local timeleft = math.max(0, plant_spawn_time + 600 - Time )
			surface.SetDrawColor( Color( 128,128,128, 50 ) )
			surface.DrawRect( -6*20, -2.5*48, 12*20, 2*20 )
			surface.SetDrawColor( Color( 25,185,25, 255 ) )
			surface.DrawRect( -6*20, -2.5*48,math.Clamp(timeleft , ScrW() ,600) * 0.12, 2*20 )

			local timeleft = math.max(0, plant_spawn_time + 600 - Time)
			plant_timer_text = "Timer: " .. string.FormattedTime(timeleft, "%02i:%02i")

			if timeleft ~= 0 then
				surface.SetDrawColor(Color(255,255,255,255))
				surface.SetFont("cannabis_Plant_Font2")

				local TextWidth = surface.GetTextSize(plant_timer_text)

				surface.SetTextColor(255,255,255,255)
				surface.SetTextPos(0-(TextWidth/1.85),-2.1*53) 
				surface.DrawText(plant_timer_text)
			else
				surface.SetDrawColor(Color(255,255,255,255))
				surface.SetFont("cannabis_Plant_Font")

				local TextWidth = surface.GetTextSize("Ready to pick!")

				surface.SetTextColor(255,255,255,255)
				surface.SetTextPos(0-(TextWidth/2),-2.1*55) 
				surface.DrawText("Ready to pick!")		
			end
		cam.End3D2D()
		*//*
	end
end
*/