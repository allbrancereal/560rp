


AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')


function ENT:Initialize()

	self.Entity:SetModel("models/props/cs_assault/money.mdl")
	//self.Entity:SetModelScale(0.15);
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
	self.Entity:SetSolid( SOLID_VPHYSICS )
	self.Entity:SetUseType( SIMPLE_USE )
	self.Entity:PhysicsInit( SOLID_VPHYSICS )
	self.Entity:GetPhysicsObject():Wake();
	self.Entity:SetTrigger(false)
end
function ENT:Use( activator, caller )
	if !activator:IsPlayer() then return false; end
	local _am = self:getFlag("amount",0);
	if activator:IsGovernmentOfficial() then
		activator:addMoney(_am/5)
		activator:PrintMessage("You have confiscated printed money.")
		self:Remove()
	end
	activator:addMoney(_am)
	activator:Notify("Picked up $" .. _am)
	self:Remove()
	/*if !self.ID then self:Remove(); return false; end
	if activator:KeyDown(IN_WALK) then 
	
		if activator:SteamID() != self:getFlag( "ownedBy" ,"" )  then return false; end
		if self.Entity:getFlag("useDelay", 0 ) and self.Entity:getFlag("useDelay", 0 ) > CurTime() then return false; end
		
		self.Entity:setFlag("useDelay", CurTime() + 2.5 )
		
		activator:EmitSound("items/ammocrate_open.wav")
		activator:AddItemByID( ITEMLIST[self.ID].ID )

		
		self:Remove();
	
	end*/
	
end


function ENT:StartTouch(otherEnt)
	if otherEnt:GetClass() == "mp_bag" then
		local _worth = self:getFlag("amount",0)
		local _otherWorth = otherEnt:getFlag("amount",0)
		otherEnt:Remove();
		self:setFlag("amount",_otherWorth+_worth);
	end
end
