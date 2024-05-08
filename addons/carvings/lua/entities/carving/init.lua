
AddCSLuaFile( "cl_init.lua" ) -- Make sure clientside
AddCSLuaFile( "shared.lua" )  -- and shared scripts are sent.
 
include('shared.lua')
 
	local carvingSounds = {
		{"helpme", "Help Me!"},
		{"hello", "Hello!"},
		{"sorry", "I'm sorry."},
		{"verygood", "Very.. good." },
		{"thankyou" , "Thank you!"},
	}
	
	function ENT:Initialize()
	 
		self:SetModel( "models/props_debris/concrete_chunk05g.mdl" )
		self:PhysicsInit( SOLID_VPHYSICS )      -- Make us work with physics,
		self:SetMoveType( MOVETYPE_VPHYSICS )   -- after all, gmod is a physics
		self:SetSolid( SOLID_VPHYSICS )         -- Toolbox
		self:SetTrigger(true)
		//self.soundMode = 0
			local phys = self:GetPhysicsObject()
		if (phys:IsValid()) then
			phys:Wake()
		end
	end
	
	function ENT:SetSoundMode( int )
	
		self.soundMode = int;
	
	end
	 
	function ENT:Use( activator, caller )
		return
	end
	 
	function ENT:StartTouch( ent )
	
		if self.DidSound then return end
		
		self.DidSound = true;
		
		if self.soundMode == 0 then
		
			self:EmitSound( "physics/concrete/concrete_break3.wav", 50 , 100 )
			self:EmitSound( "carving_" .. carvingSounds[ math.random( #carvingSounds ) ][1] )
	
		else
		
			self:EmitSound( "carving_" .. carvingSounds[self.soundMode][1] );
			
		end
		
		
	end
	
	function ENT:Think()
		if self:OnGround() && self.DidSound then return end
		
		self.DidSound = true;
		
		
	end	 
	 
 