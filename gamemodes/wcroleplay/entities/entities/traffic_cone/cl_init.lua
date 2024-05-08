--[[
Name: "cl_init.lua".
--]]

include("sh_init.lua");

local BARRICADE_LOCAL_POS = { Vector(32, 2, 32), Vector(-32, 2, 32) };
local CONE_POS_LOCAL = Vector(0, 0, 12);
local GLOW_MATERIAL = Material("sprites/glow04_noz");
local GLOW_COLOR = Color(255, 150, 0, 255);

-- Called each frame.
function ENT:Think()
	if ( !self:getFlag("isOff", false) ) then
		local curTime = UnPredictedCurTime();
		
		if (!self.NextBeaconFlashTime) then
			self.NextBeaconFlashTime = curTime + 1;
		end;
		
		if (curTime >= self.NextBeaconFlashTime) then
			self.ShowBeaconGlowSprite = curTime + 0.5;
			self.NextBeaconFlashTime = nil;
			
			if (self:GetModel() == "models/props_junk/trafficcone001a.mdl") then
				local dynamicLight = DynamicLight( "beacon_"..self:EntIndex() );
				local beaconPos = self:LocalToWorld(CONE_POS_LOCAL);
				
				if (dynamicLight) then
					dynamicLight.Brightness = 5;
					dynamicLight.DieTime = curTime + 0.5;
					dynamicLight.Decay = 256;
					dynamicLight.Size = 256;
					dynamicLight.Pos = beaconPos;
					dynamicLight.r = GLOW_COLOR.r;
					dynamicLight.g = GLOW_COLOR.g;
					dynamicLight.b = GLOW_COLOR.b;
				end;
			else
				for i = 1, 2 do
					local dynamicLight = DynamicLight("beacon_"..self:EntIndex().."_"..i);
					local beaconPos = self:LocalToWorld( BARRICADE_LOCAL_POS[i] );
					
					if (dynamicLight) then
						dynamicLight.Brightness = 5;
						dynamicLight.DieTime = curTime + 0.5;
						dynamicLight.Decay = 256;
						dynamicLight.Size = 256;
						dynamicLight.Pos = beaconPos;
						dynamicLight.r = GLOW_COLOR.r;
						dynamicLight.g = GLOW_COLOR.g;
						dynamicLight.b = GLOW_COLOR.b;
					end;
				end;
			end;
		end;
	end;
end;

-- Called when the entity should draw.
function ENT:Draw()
	self:DrawModel();
	
	if ( !self:getFlag("isOff", false) ) then
		local curTime = UnPredictedCurTime();
		
		if (self.ShowBeaconGlowSprite) then
			if (self.ShowBeaconGlowSprite > curTime) then
				cam.Start3D( EyePos(), EyeAngles() );
					if (self:GetModel() == "models/props_junk/trafficcone001a.mdl") then
						render.SetMaterial(GLOW_MATERIAL);
						render.DrawSprite(self:LocalToWorld(CONE_POS_LOCAL), 16, 16, GLOW_COLOR);
					else
						for i = 1, 2 do
							render.SetMaterial(GLOW_MATERIAL);
							render.DrawSprite(self:LocalToWorld( BARRICADE_LOCAL_POS[i] ), 16, 16, GLOW_COLOR);
						end;
					end;
				cam.End3D();
			else
				self.ShowBeaconGlowSprite = nil;
			end;
		end;
	end;
end;