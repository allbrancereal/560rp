


AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

local MixRange = 150;

function ENT:Initialize()
	self.Entity:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_NONE )
	self.Entity:SetSolid( SOLID_VPHYSICS )
	self.Entity:SetRenderMode( RENDERMODE_TRANSALPHA )
	self.Entity:SetCollisionGroup( COLLISION_GROUP_INTERACTIVE )
	//self.Entity:SetCollisionGroup(COLLISION_GROUP_DEBRIS_TRIGGER)
	self.Entity:UseTriggerBounds(true,24)	
	self.Entity:SetTrigger(true)
	self.Entity:SetCollisionBounds( Vector(-1,-1,19), Vector(1,1,23) ) 
	
	self.Entity:SetPos(self.Entity:GetPos()+Vector(0,0,20))
	self.Entity:SetAngles(Angle(0,0,90))
	//self.Entity:SetCustomCollisionCheck(true)
	self.Constraints = {};
	self.Entity:SetModel("models/props_c17/SuitCase_Passenger_Physics.mdl")
end
function ENT:Touch(entity )

	if entity && entity:IsPlayer() then 
		self:SetCollisionGroup(COLLISION_GROUP_PASSABLE_DOOR)
		self.LastPassthrough = CurTime()
		if entity:getFlag("supplyFlagTag","") == self:getFlag('supplyFlagTag',"") && (fsrp.config.SupplyMissions[self:getFlag('supplyFlagTag',"")] ||fsrp.config.InitMissions[self:getFlag('supplyFlagTag',"")]  )then
				
			if self.Constraints[entity:SteamID()] && self.Constraints[entity:SteamID()] > os.time()  then
				return;		
			else
				self.Constraints[entity:SteamID()] = os.time()+5;
			end

			if fsrp.config.SupplyMissions[self:getFlag('supplyFlagTag',"")]  then		
				fsrp.config.SupplyMissions[self:getFlag('supplyFlagTag',"")].supplyStep[game.GetMap()].AdvanceCriteria(entity,self)
			end
			if fsrp.config.InitMissions[self:getFlag('supplyFlagTag',"")]  then		
				fsrp.config.InitMissions[self:getFlag('supplyFlagTag',"")].supplyStep[game.GetMap()].AdvanceCriteria(entity,self)
			end
			
			//entity:setFlag("supplyFlagTag",nil)
			entity:Notify("You have picked up the package.")
		end
	
	end
end

function ENT:Think()
	self:SetAngles(Angle(self:GetAngles().p,self:GetAngles().y+2,self:GetAngles().r ));
	if self.LastPassthrough  and CurTime() - self.LastPassthrough  >1 then
		local _found = false;
		for k , v in pairs(ents.FindInSphere(self:GetPos(),30)) do
			if v:IsPlayer() then 
				_found = true; 
				break; 
			end 
		end
		if _found != true then			
			self.Entity:SetCollisionGroup( COLLISION_GROUP_INTERACTIVE )
		end
	end
end


function ENT:Use( activator, caller )
	
end


