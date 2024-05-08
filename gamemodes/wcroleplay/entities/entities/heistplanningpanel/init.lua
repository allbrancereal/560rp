AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include( "shared.lua" )

function ENT:Initialize()
	self.Entity:SetModel( "models/hunter/plates/plate2x3.mdl" )
	self.Entity:DrawShadow( false )
	//self.Entity:PhysicsInit( SOLID_VPHYSICS )
	//self.Entity:SetSolid( SOLID_VPHYSICS )
	self.Entity:SetUseType( SIMPLE_USE )
	
	//self.Entity:GetPhysicsObject():Sleep()
	self.Entity:SetCollisionGroup( COLLISION_GROUP_INTERACTIVE)
	self.Entity:SetMoveType( MOVETYPE_NONE )
end

function ENT:Use( activator, caller )
	if !activator:IsPlayer() then return false; end
	/*if activator:KeyDown(IN_WALK) then
	
		activator:GiveItem(115, 1, true);
	
		self:Remove();	
	else*/
	
	//end	
end



