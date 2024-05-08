AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include( "shared.lua" )

function ENT:Initialize()
	self.Entity:SetModel( "models/props_junk/cardboard_box001a_gib01.mdl" )
	self.Entity:DrawShadow( false )
	self.Entity:SetColor( 0,0,0,255 )
	self.Entity:PhysicsInit( SOLID_VPHYSICS )
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
	self.Entity:SetSolid( SOLID_VPHYSICS )
	self.Entity:SetUseType( SIMPLE_USE )
	
	self.Entity:GetPhysicsObject():Wake();
	
end

function ENT:Use( activator, caller )
	if !activator:IsPlayer() then return false; end
	/*if activator:KeyDown(IN_WALK) then
	
		activator:GiveItem(115, 1, true);
	
		self:Remove();	
	else*/
	
	//end	
end



