-- to be completed
function SWEP:makeFireEffects()
	if SP and SERVER then
		SendUserMessage("CW20_EFFECTS")
		return
	end
	
	if CLIENT then
		if self.MuzzleEffect then
			self:CreateMuzzle()
		end
		
		if not self.BoltActionLogic and self.Shell then
			self:CreateShell()
		end
	end
end