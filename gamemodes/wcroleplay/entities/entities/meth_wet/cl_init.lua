



include('shared.lua')
local doOutline = false;

function ENT:Draw()
	self:DrawModel()
	

end

function ENT:Think()
	if self:getFlag("drawHalo",true) then
		
		self.ShouldDrawHalo = true


	end
end