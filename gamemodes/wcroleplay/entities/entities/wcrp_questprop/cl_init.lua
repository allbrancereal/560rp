



include('shared.lua')

local function shouldDraw(ent)
	local _p = LocalPlayer()

	local _finished, _lfinished = LocalPlayer():FinishedQuest(ent:getFlag("quest",nil))
	
	if _finished == false then
		return true
	end
	
	return _p:IsAdmin()
end

function ENT:Draw()
	
	if shouldDraw(self) then
		self:DrawModel()
	end

end
