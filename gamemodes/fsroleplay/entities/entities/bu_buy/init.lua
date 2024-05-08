AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )



function ENT:Initialize()
 	self:SetModel( "models/props_phx/construct/wood/wood_boardx1.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:GetPhysicsObject():Wake()
	self:SetUseType( SIMPLE_USE )
end


/*
function ENT:Use( activator, caller )

end
*/

function ENT:Think(  )
	
		
end