


AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

local MixRange = 150;

function ENT:Initialize()
	self.Entity:SetModel("models/props_junk/garbage_plasticbottle002a.mdl")
	//self.Entity:SetModelScale(0.25);
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
	self.Entity:SetSolid( SOLID_VPHYSICS )
	self.Entity:SetUseType( SIMPLE_USE )
	self.Entity:PhysicsInit( SOLID_VPHYSICS )
	self.Entity:GetPhysicsObject():Wake();

end

function ENT:SetupID( id, owner )

	self.ID = id;
	self:setFlag("itemID", id )
	self:setFlag("savedInvEntity", true )
	self:setFlag("ownedBy", owner )
		

end
function ENT:Use( activator, caller )
	if !activator:IsPlayer() then return false; end
	if !self.ID then self:Remove(); return false; end
	if activator:KeyDown(IN_WALK) then 
	
		if activator:SteamID() != self:getFlag( "ownedBy" ,"" )  then return false; end
		if self.Entity:getFlag("useDelay", 0 ) and self.Entity:getFlag("useDelay", 0 ) > CurTime() then return false; end
		
		self.Entity:setFlag("useDelay", CurTime() + 2.5 )
		
		activator:EmitSound("items/ammocrate_open.wav")
		activator:AddItemByID( ITEMLIST[self.ID].ID )

		
		self:Remove();
	
	end
	
end


