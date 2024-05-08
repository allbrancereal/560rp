


include('shared.lua')

local BARRICADE_LOCAL_POS = { Vector(32, 2, 32), Vector(-32, 2, 32) };
local CONE_POS_LOCAL = Vector(0, 0,55);
local GLOW_MATERIAL = Material("sprites/glow04_noz");
local GLOW_COLOR = Color(255, 200, 100, 255);



function ENT:Initialize() 

	self.lastLight = 0;

end

function ENT:Think( )
	if self:GetPos():Distance( LocalPlayer():GetPos() ) > 500 then return end
	
	if !self:getFlag( "isOff" , false ) then
		local curTime = UnPredictedCurTime();
		self.DieTime = curTime;
		
		self.dynamicLight = DynamicLight( "beacon_"..self:EntIndex() );
		local beaconPos = self:LocalToWorld(CONE_POS_LOCAL - Vector( 0 , 0 , 50 ) );
				
		if (self.dynamicLight) && self.lastLight < CurTime() then
			self.dynamicLight.Brightness = 1;
			self.dynamicLight.DieTime = self.DieTime + 1;
			self.dynamicLight.Decay = 0;
			self.dynamicLight.Size = 256;
			self.dynamicLight.Pos = beaconPos;
			self.dynamicLight.r = 255;
			self.dynamicLight.g = 255;
			self.dynamicLight.b = 100;
			self.lastLight = self.DieTime + 1;
		end;
				
	end
	
end
function ENT:Draw()
	
	if self:GetPos():Distance( LocalPlayer():GetPos() ) < 500 then

		self:DrawModel();
		if ( !self:getFlag("isOff", false) ) then
			
			self:DrawLights()
			
		else
		
			if self.dynamicLight then
			
				self.dynamicLight.DieTime = 5;
			
			end
			
		end
	

		
	end
	
end


				
function ENT:DrawLights( )
	
	if self:GetPos():Distance( LocalPlayer():GetPos() ) < 500 then
	
		cam.Start3D( EyePos(), EyeAngles() );
					
				render.SetMaterial(GLOW_MATERIAL);
				render.DrawSprite(self:LocalToWorld(CONE_POS_LOCAL), 32,32,GLOW_COLOR);
				//render.SetLocalModelLights( { _Light } )
				
		cam.End3D();
				
	end
	local pos = self:GetPos()

end
