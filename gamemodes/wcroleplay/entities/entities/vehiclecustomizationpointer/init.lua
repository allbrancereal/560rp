
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

function ENT:Initialize()
//self.Entity:PhysicsInit(SOLID_BSP)

	self:SetPos( Vector(-1940 , -6175 , -185 ) )
	self:SetAngles( Angle( 0, 0 , 0 ) )

end
