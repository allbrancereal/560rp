


AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

sound.Add( {
	name = "methsmoke",
	channel = CHAN_AUTO,
	volume = 1,
	level = 35,
	pitch = { 100, 100 },
	sound = "ambient/gas/steam_loop1.wav"
} )
function ENT:Initialize()

	self.Entity:SetModel("models/props_wasteland/coolingtank02.mdl")
	self.Entity:SetModelScale(0.15);
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
	self.Entity:SetSolid( SOLID_VPHYSICS )
	self.Entity:SetUseType( SIMPLE_USE )
	self.Entity:PhysicsInit( SOLID_VPHYSICS )
	self.Entity:GetPhysicsObject():Wake();
	self.Entity:SetTrigger(true)
	self.TargetIngredient =fsrp.config.Meth.itemstoconsider[math.random(#fsrp.config.Meth.itemstoconsider)]
	self.RequiredProgress =math.random(fsrp.config.Meth.itemamountchance[1],fsrp.config.Meth.itemamountchance[2])
	self.Activated = false;
	self.Finished = false;
	self.Progress = 0;
	self.StartTime = 0;
	self.ExplodeTime = 0;
	self.FoundIngredient = false;
	self.LastIngredient = self.TargetIngredient;
end

function ENT:StartCooking(v)

	if  self.Finished == false  and self.Activated == false then

		if !self.effectdata then
			self:CreateEffect()		
		end
		self.StartTime = CurTime() + math.random(fsrp.config.Meth.timebetweeningredient[1],fsrp.config.Meth.timebetweeningredient[2]);
		self.ExplodeTime = CurTime() + fsrp.config.Meth.timeuntilexplode;
		self.Activated = true;
		self:SetEffectColor()

		self.targetStove = v;
		self:EmitSound("methsmoke")
	end

end

function ENT:StartTouch(otherEnt)

	if  self.Finished != true  and self.Activated == true then

		if self.targetStove then
			if self:GetPos():Distance(self.targetStove:GetPos()) > fsrp.config.Meth.mixrange then
				self.Activated = false;
				self.Progress = 0;

				self.effectdata = nil;
				self:StopSound("methsmoke")

				return

			end

			if table.HasValue(fsrp.config.Meth.itemstoconsider,otherEnt:GetClass() ) then
				if self.TargetIngredient == otherEnt:GetClass() then
					
					//self.TargetIngredient =fsrp.config.Meth.itemstoconsider[math.random(#fsrp.config.Meth.itemstoconsider)]
					//self:SetEffectColor()
					self.FoundIngredient = true;
					self.LastIngredient = self.TargetIngredient;
					otherEnt:Remove()
					return
				elseif self.TargetIngredient != otherEnt:GetClass() then
					
					self:Explode()
					otherEnt:Remove()
					self:Remove()
					return
				end
			end	

			if self.ExplodeTime and self.ExplodeTime < CurTime() then
				
				self:Explode()
				self:Remove()
				return
			end

		else
			
			local _toconsider = {};
			local _count =1;
			for k , v in pairs(fsrp.config.Meth.itemstoconsider) do 
				if v != self.TargetIngredient then
					_toconsider[_count] =v;
				end
				_count = _count+1;
			end
			self.TargetIngredient = table.Random(_toconsider)
			self.LastIngredient = self.TargetIngredient;
			self.Activated = false;
			self.Progress = 0;

			self.effectdata = nil;
				self:StopSound("methsmoke")

			return
		end
	end

end

function ENT:CreateEffect()
	
	self.effectdata = EffectData()
	local ang = self:GetAngles()
	ang:RotateAroundAxis( self:GetForward(),90);
	ang:RotateAroundAxis(self:GetRight(),90)
	self.effectdata:SetOrigin( self:GetPos() + ang:Forward()*20 )
	self.effectdata:SetEntIndex(self:EntIndex());
	self:SetEffectColor()
	//self.effectdata:SetRadius(64);
	//util.Effect( "meth_smoke", self.effectdata )

end

function ENT:SetEffectColor()
	/*if self.effectdata then
		local _color = fsrp.config.Meth.itemcolors[self.TargetIngredient];
		local clr = _color
		

		local r = bit.band( clr.r, 255 )
		local g = bit.band( clr.g, 255 )
		local b = bit.band( clr.b, 255 )
		local a = bit.band( clr.a, 255 )

		local numberClr = bit.lshift( r, 24 ) + bit.lshift( r,16 ) + bit.lshift(r, 8 ) + a

		self.effectdata:SetColor(numberClr);
	end*/

end

function ENT:Use( activator, caller )

	if self.Finished == false then
		for k , v in pairs(ents.FindInSphere(self:GetPos(),fsrp.config.Meth.mixrange)) do

			local _class = v:GetClass();

			if _class == "methstove" then
				self:StartCooking(v)
			end

		end
	elseif self.Finished == true then
		
		activator:AddItemByID(766)
		self:Remove()
	end
	
end

function ENT:OnRemove()
				self:StopSound("methsmoke")

end
function ENT:Explode()

	self:StopSound("methsmoke")


	self.effectdata = EffectData()
	local ang = self:GetAngles()
	ang:RotateAroundAxis( self:GetForward(),90);
	ang:RotateAroundAxis(self:GetRight(),90)
	self.effectdata:SetOrigin( self:GetPos() + ang:Forward()*20 )
	self.effectdata:SetEntIndex(self:EntIndex());
	//self.effectdata:SetRadius(64);
	util.Effect( "explosion_meth", self.effectdata )
	

	for k , v in pairs(ents.FindInSphere(self:GetPos(),300) ) do
		if v and v:IsPlayer() then


			local _skill = skillpoint_Helper_GetSkillPoint(v, "luck" ) || 0;
			local _rand = math.random( 100 - (_skill*5) )
			


			if _rand > 50 then
				v:Kill()
			else
				v:Notify("You have survived a meth explosion.")
			end
		elseif v and v:GetClass() == "meth_wet" then
			v:Remove()
		elseif v and v:GetClass() == "methstove" then
			
			v:AddHeat(math.random(50));
		end
	end
	//self:Remove()

end
function ENT:Think()
	if ( not self.m_bInitialized ) then
		local _Target = self.Entity:GetPos()+Vector(0,0,60);
		self.Entity:SetPos(_Target)
		self.m_bInitialized = true
		return
	end



	if  self.Finished != true and self.Activated == true then
		if self.targetStove then
			if self:GetPos():Distance(self.targetStove:GetPos()) > fsrp.config.Meth.mixrange then
				self.Activated = false;
				self.Progress = 0;

				self.effectdata = nil;
				self:StopSound("methsmoke")

				return

			end

			if self.StartTime < CurTime() and self.FoundIngredient == true then
				self.Progress = self.Progress + 1;
				self.FoundIngredient = false;
				if self.targetStove then
					self.targetStove:AddHeat(10);
				end
				if self.TargetIngredient == self.LastIngredient then
					if self.Progress >= self.RequiredProgress then
						self:StopSound("methsmoke")
						self.effectdata = nil;
						self.Finished = true;
						self:setFlag("drawHalo", true);
						//print("Finished meth")
						return;
					end
					local _toconsider = {};
					local _count =1;
					for k , v in pairs(fsrp.config.Meth.itemstoconsider) do 
						if v != self.TargetIngredient then
							_toconsider[_count] =v;
						end
						_count = _count+1;
					end
					self.TargetIngredient = table.Random(_toconsider)
					
					self:SetEffectColor()
					self.StartTime = CurTime() + math.random(fsrp.config.Meth.timebetweeningredient[1],fsrp.config.Meth.timebetweeningredient[2]);
					self.ExplodeTime = CurTime() + fsrp.config.Meth.timeuntilexplode;
				end

			elseif self.StartTime < CurTime() and self.FoundIngredient != true then
				self:Explode()
				self:Remove()
			end

			if self.ExplodeTime and self.ExplodeTime < CurTime() then
				
				self:Explode()
				self:Remove()
			end

		else
			self.TargetIngredient =fsrp.config.Meth.itemstoconsider[math.random(#fsrp.config.Meth.itemstoconsider)]
			self.LastIngredient = self.TargetIngredient;
			self.Activated = false;
			self.Progress = 0;
			self:StopSound("methsmoke")
			self.effectdata = nil;
		end
	end
	
	if self.effectdata then
		local ang = self:GetAngles()
		ang:RotateAroundAxis( self:GetForward(),90);
		ang:RotateAroundAxis(self:GetRight(),90)
		self.effectdata:SetOrigin( self:GetPos() + ang:Forward()*20 )
		util.Effect( fsrp.config.Meth.smokes[self.TargetIngredient], self.effectdata, true, true )	
		return
	end
	-- Other code
end