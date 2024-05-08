ENT.Type                = "anim"
ENT.Base                = "base_anim"
ENT.PrintName           = "560Roleplay Monitor"
ENT.Category            = "Computers"
ENT.Author              = "Mario.S"
ENT.Purpose             = "Making money without a display? Good luck."
ENT.Instructions        = "Use to find out that you need a computer."
ENT.Spawnable 			= true  
ENT.AdminSpawnable 		= true
ENT.MonitorStatus = false; // true = on false = off;

function ENT:IsOn()
	
	return true;--self.Entity:getFlag("monitorStatus", false );
	
end

 
function ENT:Initialize()
	if SERVER then
		self.Entity:SetUseType( SIMPLE_USE )
		self.Entity:SetModel( "models/props/cs_office/computer_monitor.mdl" )
		self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
		self.Entity:SetSolid( SOLID_VPHYSICS )
		self.Entity:PhysicsInit( SOLID_VPHYSICS )
	end
	if IsValid(self.Entity:GetPhysicsObject()) then
		self.Entity:GetPhysicsObject():Wake()
	end
	self.Entity:setFlag("monitorStatus", self.MonitorStatus );
	
	self.Entity:SetCollisionGroup( COLLISION_GROUP_NONE )

end
 