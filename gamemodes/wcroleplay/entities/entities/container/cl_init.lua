


include('shared.lua')


function ENT:Draw()
	local _f = self:getFlag("invisible",false);
	if self:GetPos():Distance( LocalPlayer():GetPos() ) < 3000 and _f == false then

		self:DrawModel();
		
	end
	
end

