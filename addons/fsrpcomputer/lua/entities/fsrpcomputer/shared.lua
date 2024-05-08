ENT.Type                = "anim"
ENT.Base                = "base_anim"
ENT.PrintName           = "560Roleplay Computer"
ENT.Category            = "Computers"
ENT.Author              = "Mario.S"
ENT.Purpose             = "Making money using the internet"
ENT.Instructions        = "Use to find out how to make money."
ENT.Spawnable 			= true  
ENT.AdminSpawnable 		= true
ENT.ComputerStatus = false; // true = on false = off;
ENT.Specifications		= {
	{ Components = { { Level = 1 } }} ;
	{ Components = { { Level = 1 } }} ;
	{ Components = { { Level = 1 } }} ;
	{ Components = { { Level = 1 } }} ;
}

function ENT:IsOn()
	
	return true;--self.Entity:getFlag("computerStatus", false );
	
end


function ENT:Initialize()
	self.health = 75
	self.timer = 0;
	self.PlayersInUse = {};
	if SERVER then
		self.Entity:SetUseType( SIMPLE_USE )
		self.Entity:SetModel( "models/gaming-models/nebukadnezar/environment/indoors/alien_pc.mdl" )
		self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
		self.Entity:SetSolid( SOLID_VPHYSICS )
		self.Entity:PhysicsInit( SOLID_VPHYSICS )
	
		self.Entity:SetSpecifications( { { Components = { { Level = 1 } }},	{ Components = { { Level = 1 } }},	{ Components = { { Level = 1 } }},{ Components = { { Level = 1 } }} })
		self.Entity:setFlag("computerStatus", self.ComputerStatus );
	
	end
	if IsValid(self.Entity:GetPhysicsObject()) then
		self.Entity:GetPhysicsObject():Wake()
	end
	self.Entity:SetCollisionGroup( COLLISION_GROUP_NONE )

end
 