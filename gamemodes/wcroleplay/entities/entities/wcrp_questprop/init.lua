


AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

local MixRange = 150;

function ENT:Initialize()
	self.Entity:PhysicsInit( SOLID_BBOX  )
	self.Entity:SetMoveType( MOVETYPE_NONE )
	self.Entity:SetUseType( SIMPLE_USE )
	//self.Entity:SetCollisionGroup(COLLISION_GROUP_DEBRIS_TRIGGER)
	self.Entity:UseTriggerBounds(true,24)	
	self.Entity:SetTrigger(true)
	self.Entity:SetCollisionBounds( Vector(-1,-1,19), Vector(1,1,23) ) 
	
	self.Entity:SetPos(self.Entity:GetPos()+Vector(0,0,20))
	//self.Entity:SetAngles(Angle(0,0,90))
	//self.Entity:SetCustomCollisionCheck(true)
	self.Constraints = {};
end


function ENT:Touch(entity )
	
	if entity && entity:IsPlayer() then

		local _q = QUEST_TABLE[self:getFlag("quest",0)];
		if _q and _q.OnItemUse then
			_q.OnItemUse(self,entity);
		end
	end
end

function ENT:Think()
	if self:getFlag("rotate",false) == true then
		self:SetAngles(Angle(self:GetAngles().p,self:GetAngles().y+2,self:GetAngles().r ));
	end
end


function ENT:Use( activator, caller )
	
end


