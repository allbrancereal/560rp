



include('shared.lua')


function ENT:Initialize( )

end
// fsrp.mining.config.RockViewDistance == 4550
function ENT:Draw()

	self:DrawShadow( false )
	self:DestroyShadow()
	local _p = LocalPlayer()
	local _rDist = 4550;
	if fsrp and fsrp.mining and fsrp.mining.config and fsrp.mining.config.RockViewDistance then
		_rDist = fsrp.mining.config.RockViewDistance;
	end
	
	if _p and self and _p:GetPos():Distance( self:GetPos() ) < (_rDist) then
	
		self:DrawModel()
		
	end
	
end
