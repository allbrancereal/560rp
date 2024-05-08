


AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

function ENT:Initialize()
	self:SetModel("models/env/lighting/lamp_trumpet/lamp_trumpet_tall.mdl");
	
	self.Entity:PhysicsInit( SOLID_VPHYSICS )
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
	self.Entity:SetSolid( SOLID_VPHYSICS )
	self.Entity:SetUseType( SIMPLE_USE )
	
	self.Entity:GetPhysicsObject():Wake();
	self.Entity:SetPos( self.Entity:GetPos() + Vector( 0,0,15 ) )
	self:setFlag("isOff", true);
end


function ENT:Use( activator, caller )
	if !activator:IsPlayer() then return false; end
	/*if self.Entity:GetTable().Tapped and self.Entity:GetTable().Tapped > CurTime() then return false; end
	if (activator != self:GetTable().Owner) then return false; end
	if activator:KeyDown(IN_WALK) then 
		if (self:GetTable().Owner == activator) then
			activator:GiveItem(self:GetTable().ItemID, 1, true);
			self.Tapped = CurTime() + 5
			self:Remove()
		end	
		
	    return
	end*/
	
	if activator:KeyDown(IN_WALK) then 
		if activator:SteamID() != self:getFlag( "ownedBy" ,"" )  then return; end
		
		activator:setFlag("amountLamps", activator:getFlag("amountLamps", 0 ) - 1 );
		activator:AddItemByID( 138 )
		self:Remove()
		return
		
	end
	
	self:setFlag( "isOff", !self:getFlag("isOff", false) );
end

-- Called when the entity's transmit state should be updated.
function ENT:UpdateTransmitState()
	return TRANSMIT_ALWAYS;
end;