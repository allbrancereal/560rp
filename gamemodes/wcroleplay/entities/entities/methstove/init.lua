


AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')


function ENT:Initialize()

	self.Entity:SetModel("models/props_c17/furnitureStove001a.mdl")
	//self.Entity:SetModelScale(0.15);
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
	self.Entity:SetSolid( SOLID_VPHYSICS )
	self.Entity:SetUseType( SIMPLE_USE )
	self.Entity:PhysicsInit( SOLID_VPHYSICS )
	self.Entity:GetPhysicsObject():Wake();
	self.Heat=math.random(20)
	self.HeatMax = 100;
	self.Entity:SetTrigger(false)
	self:OnHeatAdd()
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



function ENT:AddHeat(am)

	self.Heat = math.Clamp( self.Heat+am,0,100);

	self:OnHeatAdd()
end


function ENT:Explode()

	self.effectdata = EffectData()
	local ang = self:GetAngles()
	ang:RotateAroundAxis( self:GetForward(),90);
	ang:RotateAroundAxis(self:GetRight(),90)
	self.effectdata:SetOrigin( self:GetPos() + ang:Forward()*20 )
	self.effectdata:SetEntIndex(self:EntIndex());
	//self.effectdata:SetRadius(64);

	util.Effect( "explosion_meth", self.effectdata )
	for k , v in pairs(ents.FindInSphere(self:GetPos(),300) ) do
		if v and v:GetClass() == "wet_meth" then
			v:Explode()
			v:Remove()
		elseif v and v:IsPlayer() then


			local _skill = skillpoint_Helper_GetSkillPoint(v , "luck" ) || 0;
			local _rand = math.random( 100 - (_skill*5) )

			if _rand > 50 then
				v:Kill()
			end
		end
	end

end

function ENT:OnHeatAdd()
	if self.Heat > self.HeatMax then
			
		self:Explode()
		self:Remove()


		return
	end
	local _alpha = 255* (self.Heat/100);
	//print(Color(255, 255-_alpha , 255-_alpha,255))

	self:SetColor( Color(255, 255-_alpha , 255-_alpha,255) );

	self:setFlag("stoveheat",self.Heat);
end

function ENT:StartTouch(otherEnt)
	if otherEnt:GetClass() == "cooling_water" then
		self:AddHeat(-10);
		self:OnHeatAdd();
		otherEnt:Remove()
	end
end
