

function EFFECT:Init(data)
	
	local NumParticles = 64
	local emitter = ParticleEmitter(data:GetOrigin())
		for i = 0, NumParticles do
			local Pos = (data:GetOrigin())
			local particle = emitter:Add("particles/smokey", Pos)
			if (particle) then
				particle:SetVelocity(VectorRand()*12)
				particle:SetGravity(Vector(5,5,3))
				particle:SetDieTime(math.Rand(2,4))
				particle:SetStartAlpha(math.Rand(60,70))
				particle:SetEndAlpha(0)
				particle:SetStartSize(math.Rand(9,14))
				particle:SetEndSize(math.Rand(35,45))
				particle:SetRoll(math.Rand(200,300))
				particle:SetRollDelta(math.Rand(-1,1))
				//particle:SetColor(_col)
				particle:SetAirResistance(5)
			end
		end
	emitter:Finish()
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end