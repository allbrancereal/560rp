function EFFECT:Init( data )

	self.EffectTimer = CurTime() + 0.001;
	
	local Offset = data:GetOrigin();
	local Size = data:GetScale();
	local Health = math.Clamp((data:GetRadius() - 15) * 10, 0, 200);
	
 	for i= 0, 1 do 
 		local emitter = ParticleEmitter(Vector(0, 0, 0))
		local particle1 = emitter:Add( "particles/smokey", Offset );
		local Velocity = math.random(0,700);
		local Death = math.random() * 2;
		local Roll = math.random(0, 360);
		local RollDelta = math.random(-0.5, 0.5);
		local SetColor = math.random(150, 255);
		local StartAlpha = math.random(150,255);
		local Gravity = Vector(math.Rand(-100, 10), math.Rand(-100, 10), math.Rand(2, 400));
 		if particle1 then
	 		particle1:SetVelocity(data:GetStart() * (SetColor / 10));
	 		particle1:SetLifeTime(0);
	 		particle1:SetDieTime(Death);
	 		particle1:SetStartAlpha(StartAlpha);
	 		particle1:SetEndAlpha(0); 
	 		particle1:SetStartSize(math.random(1, 10));
	 		particle1:SetEndSize(math.random(10, 20));	 				
	 		particle1:SetRoll(Roll);
	 		particle1:SetRollDelta(RollDelta);
		end
 	emitter:Finish();
	end
end

function EFFECT:ParticleEmitter( OffSet )
	if !self.Emitter then self.Emitter = ParticleEmitter(OffSet); end
	return self.Emitter
end

function EFFECT:Think( ) return false; end
function EFFECT:Render() end
