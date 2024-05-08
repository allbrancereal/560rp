AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

function ENT:Initialize()
	--self.Entity:SetModel("models/props_c17/pottery06a.mdl")

	self.Entity:SetMoveType( MOVETYPE_NONE )
	self.Entity:SetSolid( SOLID_NONE )
	self.Entity:SetCollisionGroup( COLLISION_GROUP_NONE )
	self.Entity:DrawShadow( false )
	
end

function ENT:Think()

end

function ENT:Use( activator, caller )
end
