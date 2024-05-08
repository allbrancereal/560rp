
if SERVER then

	AddCSLuaFile()
	
	SWEP.Weight = 5;
	
	SWEP.AutoSwitchTo = false;
	SWEP.AutoSwitchFrom = false

end

SWEP.PrintName		= "Carving"
SWEP.Base			= "swep_cons_base"
SWEP.Author 		= "Mario S."
SWEP.Contact 		= "sk8tra@gmail.com"
SWEP.Purpose 		= "Emits a sound based on it's type when thrown."
SWEP.Instructions 	= "Reload to hold normally. Right Click to ready your throw, Left Click to throw on the ground."

SWEP.Spawnable = true;
SWEP.AdminSpawnable = true;

if CLIENT then

	SWEP.Slot			= 2
	SWEP.SlotPos		= 3

	SWEP.DrawAmmo 		= false;
	SWEP.SwayScale 		= 2;
	SWEP.DrawCrosshair 	= false;

end

SWEP.Primary.ClipSize	 	= -1
SWEP.Primary.DefaultClip 	= -1
SWEP.Secondary.ClipSize	 	= -1
SWEP.Secondary.DefaultClip 	= -1
SWEP.Secondary.Automatic		= false
SWEP.Secondary.Ammo			= "none"
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "none"

//The category that you SWep will be shown in, in the Spawn (Q) Menu 
//(This can be anything, GMod will create the categories for you)
SWEP.Category = "Carvings"
SWEP.HoldType = "grenade"
SWEP.ViewModelFOV = 70
SWEP.ViewModelFlip = false
SWEP.UseHands = true
SWEP.ViewModel = "models/weapons/c_grenade.mdl"
SWEP.WorldModel = "models/props_debris/concrete_chunk05g.mdl"
SWEP.ShowViewModel = true
SWEP.ShowWorldModel = false
SWEP.soundMode = 0
SWEP.LastChange = 0;
SWEP.VElements = {
	["chunk"] = { type = "Model", model = "models/props_debris/concrete_chunk05g.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.635, 2.596, -0.519), angle = Angle(90, 0, -78.312), size = Vector(2.637, 1.534, 1.858), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}
SWEP.WElements = { 
	["rock"] = { type = "Model", model = "models/props_debris/concrete_chunk05g.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.596, 1.57, 0), angle = Angle(-55.598, 0, 0), size = Vector(1.014, 1.014, 1.014), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}
sound.Add( {
	name = "carving_hello",
	channel = CHAN_VOICE,
	volume = 1.0,
	level = 80,
	pitch = { 100, 100 },
	sound = "hello.wav"
} )

sound.Add( {
	name = "carving_sorry",
	channel = CHAN_VOICE,
	volume = 1.0,
	level = 80,
	pitch = { 100, 100 },
	sound = "imsorry.wav"
} )

sound.Add( {
	name = "carving_thankyou",
	channel = CHAN_VOICE,
	volume = 1.0,
	level = 80,
	pitch = { 100, 100 },
	sound = "thankyou.wav"
} )

sound.Add( {
	name = "carving_helpme",
	channel = CHAN_VOICE,
	volume = 1.0,
	level = 80,
	pitch = { 100, 100 },
	sound = "helpme.wav"
} )

sound.Add( {
	name = "carving_verygood",
	channel = CHAN_VOICE,
	volume = 1.0,
	level = 80,
	pitch = { 100, 100 },
	sound = "verygood.wav"
} )


function SWEP:throw_attack (model_file)
	//Get an eye trace. This basically draws an invisible line from
	//the players eye. This SWep makes very little use of the trace, except to 
	//calculate the amount of force to apply to the object thrown.
	local tr = self.Owner:GetEyeTrace()
	//Play some noises/effects using the sound we precached earlier
	//self:EmitSound(ShootSound)
	self.BaseClass.ShootEffects(self)
 
	//We now exit if this function is not running serverside
	if (!SERVER) then return end
 
	//The next task is to create a physics prop based on the supplied model
	local ent = ents.Create("carving")
 
	//Set the initial position and angles of the object. This might need some fine tuning;
	//but it seems to work for the models I have tried.
	ent:SetPos(self.Owner:EyePos() + (self.Owner:GetAimVector() * 16))
	ent:SetAngles(self.Owner:EyeAngles())
	if SERVER then
	
		ent.soundMode =  self.soundMode;
	
	end
	/*function ent:Think( )
	
	//	if self:IsOnGround() then
		
			if !self.HasSounded then
			
				self:EmitSound( "carving_" .. carvingSounds[ math.random( #carvingSounds ) ] )
				self.HasSounded = true;
				self:ChatPrint("hey")
			//end
			
		end	
	
	end*/
	ent:Spawn()
	
	//Now we need to get the physics object for our entity so we can apply a force to it
	local phys = ent:GetPhysicsObject()
 
	//Check if the physics object is valid. If not, remove the entity and stop the function
	if !(phys && IsValid(phys)) then ent:Remove() return end
 
	//Time to apply the force. My method for doing this was almost entirely empirical 
	//and it seems to work fairly intuitively with chairs.
	phys:ApplyForceCenter(self.Owner:GetAimVector():GetNormalized() *  math.pow(tr.HitPos:Length(), 0.6))
	//Now for the important part of adding the spawned objects to the undo and cleanup lists.
	timer.Simple( 1, function() 
	
		ent:Remove() 
	
	end)

end

function SWEP:PrimaryAttack()

	if self.PulledBack then 
		
		self:SendWeaponAnim( ACT_VM_THROW )
		
		if self:GetNextPrimaryFire() < CurTime() && !self.Owner:IsSuperAdmin() then
		
			
			self:SetNextPrimaryFire( CurTime() + 1 )
		end
		
		self:throw_attack( "models/props_debris/concrete_chunk05g.mdl" )
		self.PulledBack = false;
	
	end
	
end

function SWEP:SecondaryAttack()
		
		
	self.PulledBack = !self.PulledBack;
	
	if self.PulledBack then
	
		self:SendWeaponAnim( ACT_VM_PULLBACK_HIGH )
		
			
	else
		
		self:SendWeaponAnim( ACT_VM_IDLE )
	
	end

end

local carvingSounds = {
	{"helpme", "Help Me!"},
	{"hello", "Hello!"},
	{"sorry", "I'm sorry."},
	{"verygood", "Very.. good." },
	{"thankyou" , "Thank you!"},
}

function SWEP:Reload()
	if self.LastChange > CurTime() then return end
	
	local _newValue = ( self.soundMode == 5 && 0 || self.soundMode + 1 )
	
	self.soundMode = math.Clamp( _newValue , 0 , 5 )

	
	if CLIENT then return end

	if _newValue > 0 then
	
		self.Owner:ChatPrint( "Your currently selected sound is '" .. carvingSounds[_newValue][2] .. "'" )
	
	else
	
		self.Owner:ChatPrint( "Your currently selected sound is Random!"  )	
	
	end
	
	self.LastChange = CurTime() + 1
end