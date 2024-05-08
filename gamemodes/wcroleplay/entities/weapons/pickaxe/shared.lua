
AddCSLuaFile()

SWEP.PrintName				= "Pickaxe"
SWEP.Author				= "Fried Rice"
SWEP.Instructions			= "Primary attack: Mine at Object ; Secondary Attack: Mine at Object"
SWEP.Category				= "Fried Weapons"

SWEP.Slot				= 1
SWEP.SlotPos				= 0

SWEP.Spawnable				= false
SWEP.AdminSpawnable			= true

SWEP.ViewModel				= Model( "models/weapons/HL2meleepack/v_pickaxe.mdl" )
SWEP.WorldModel				= Model( "models/weapons/HL2meleepack/w_pickaxe.mdl" )
SWEP.ViewModelFOV			= 67
SWEP.UseHands				= true

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo		= "none"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= true
SWEP.Secondary.Ammo		= "none"

SWEP.DrawAmmo			= false

SWEP.HitDistance		= 40
SWEP.HitInclination		= 0.4
SWEP.HitPushback		= 1000
SWEP.HitRate			= 1.35
SWEP.MinDamage			= 34
SWEP.MaxDamage			= 50

local SwingSound = Sound( "WeaponFrag.Roll" )
local HitSoundWorld = Sound( "Canister.ImpactHard" )
local HitSoundBody = Sound( "Flesh.ImpactHard" )
local PushSoundBody = Sound( "Flesh.ImpactSoft" )

function SWEP:Initialize()

	self:SetHoldType( "melee2" )
end

function SWEP:PrimaryAttack()

	self.Owner:SetAnimation( PLAYER_ATTACK1 )

	local vm = self.Owner:GetViewModel()
	
	self:EmitSound( SwingSound )
	self.Weapon:SetNextPrimaryFire( CurTime() + self.HitRate )
	self.Weapon:SetNextSecondaryFire( CurTime() + self.HitRate )

	vm:SendViewModelMatchingSequence( vm:LookupSequence( "misscenter1" ) )

	timer.Create("hitdelay", 0.1, 1, function() self:Hitscan() end)

	timer.Start( "hitdelay" )

end

function SWEP:SecondaryAttack()

	self.Weapon:SetNextPrimaryFire( CurTime() + 0.35 )
	self.Weapon:SetNextSecondaryFire( CurTime() + 1.0 )
	
	self.Weapon:PrimaryAttack()


end

function SWEP:OnDrop()

	
end
local treeTable = {
	"models/map_detail/foliage/coconut_tree_01.mdl";
	
}

function SWEP:Hitscan()

//This function calculate the trajectory

	for i=0, 170 do

	local tr = util.TraceLine( {
		start = (self.Owner:GetShootPos() - (self.Owner:EyeAngles():Up() * 10)),
		endpos = (self.Owner:GetShootPos() - (self.Owner:EyeAngles():Up() * 10)) + ( self.Owner:EyeAngles():Up() * ( self.HitDistance * 0.7 * math.cos(math.rad(i)) ) ) + ( self.Owner:EyeAngles():Forward() * ( self.HitDistance * 1.5 * math.sin(math.rad(i)) ) ) + ( self.Owner:EyeAngles():Right() * self.HitInclination * self.HitDistance * math.cos(math.rad(i)) ),
		filter = self.Owner,
		mask = MASK_SHOT_HULL
	} )

//This if shot the bullets

	if ( tr.Hit ) then
		local strikevector = ( self.Owner:EyeAngles():Up() * ( self.HitDistance * 0.5 * math.cos(math.rad(i)) ) ) + ( self.Owner:EyeAngles():Forward() * ( self.HitDistance * 1.5 * math.sin(math.rad(i)) ) ) + ( self.Owner:EyeAngles():Right() * self.HitInclination * self.HitDistance * math.cos(math.rad(i)) )


		self:EmitSound( SwingSound )
		
		if tr.Entity:GetClass() == "fsrp_rock" || table.HasValue( treeTable , tr.Entity:GetModel() ) || table.HasValue( fsrp.mining.config.RockSpawns , tr.Entity:GetModel() ) then
		//vm:SendViewModelMatchingSequence( vm:LookupSequence( "hitcenter1" ) )

			local vPoint = (self.Owner:GetShootPos() + (self.Owner:EyeAngles():Forward() * 5) - ( self.Owner:EyeAngles():Up() ))
			local effectdata = EffectData()
			effectdata:SetOrigin( vPoint )
			util.Effect( "MetalSpark", effectdata )
			
		end
		
		if tr.Entity:GetClass() == "fsrp_rock" && SERVER then
			local _chance = math.random( fsrp.mining.config.PickRockChance[1] , fsrp.mining.config.PickRockChance[2] );
				
			if _chance > 75 then
				if SERVER then
					self.Owner:Notify( "Received items from a " .. tr.Entity:getFlag("mining_rockType", "ass") .. " rock.")
					fsrp.mining.GiveRock( self.Owner , tr.Entity:getFlag("mining_rockType", "ass") )
				 
					local _breakChance = math.random( fsrp.mining.config.PickaxeBreakChance[1] , fsrp.mining.config.PickaxeBreakChance[2] );
					
						//self.Owner:PrintMessage(HUD_PRINTTALK, "Chance: " .. _breakChance )
					if _breakChance > 90 then
						
						self.Owner:RemoveFromSlot( 2, true )
						
					end
						

				end
				
				
			
			end
			
	
			local _skChance = math.random( 10000 )
			local _lv = 1;
			if self.Owner:GetRotoLevel(16) then
				_lv = self.Owner:GetRotoLevel(16)[1]
			end

			_skChance = math.max(_skChance - (10*_lv),1)
			if _skChance < 101 then
				
				self.Owner:AddFreeSkillPoints(1)
				self.Owner:Notify("You have gained a skillpoint.")
			end
			_skChance = math.random( 10000 )
			_skChance = math.max(_skChance - (10*_lv),1)
			if _skChance < 101 then
				
				self.Owner:AddItemByID(59)
				self.Owner:Notify("You have found a soapstone.")
			end
			_skChance = math.random( 10000 )
			_skChance = math.max(_skChance - (10*_lv),1)
			if _skChance < 101 then
				
				self.Owner:AddItemByID(58)
				self.Owner:Notify("You have found a carving.")
			end
			self.Owner:AddRotoXP(16,RotoLevelSystem.config.RewardXP	+(RotoLevelSystem.config.RewardXPPerLevel*_lv))
		end
		
		if tr.Entity:IsPlayer() or string.find(tr.Entity:GetClass(),"npc") or string.find(tr.Entity:GetClass(),"prop_ragdoll") then
			self:EmitSound( HitSoundBody )
			tr.Entity:SetVelocity( self.Owner:GetAimVector() * Vector( 1, 1, 0 ) * self.HitPushback )
		else
			self:EmitSound( HitSoundWorld )
		end
//if break
		break
//if end
		//else vm:SendViewModelMatchingSequence( vm:LookupSequence( "misscenter1" ) )
		end
end

end

function SWEP:Deploy()

	local vm = self.Owner:GetViewModel()
	vm:SendViewModelMatchingSequence( vm:LookupSequence( "draw" ) )
	
	self.Weapon:SetNextPrimaryFire( CurTime() + 0.5 )
	self.Weapon:SetNextSecondaryFire( CurTime() + 0.5 )
	
	return true
end

function SWEP:Holster()

	return true
end

function SWEP:OnRemove()
	
	timer.Remove("hitdelay")
	return true
end