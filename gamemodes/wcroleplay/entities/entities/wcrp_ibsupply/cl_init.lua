



include('shared.lua')

local function shouldDraw(ent)
	local _p = LocalPlayer()
	local _supp = ent:getFlag('supplyFlagTag',"")
	local _oursupp = _p:getFlag('supplyFlagTag',"")

	if _supp == _oursupp then
		return true;
	end
	
	return _p:IsAdmin()
end

function ENT:Draw()
	
	if shouldDraw(self) then
		self:DrawModel()
	end

end
