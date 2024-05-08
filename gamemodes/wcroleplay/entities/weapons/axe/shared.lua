
AddCSLuaFile()

SWEP.PrintName				= "Axe"
SWEP.Author				= "Fried rice"
SWEP.Instructions			= "Primary attack: Cut Wood, Secondary: Push Person"
SWEP.Category				= "Fried Weapons"

SWEP.Slot				= 1
SWEP.SlotPos				= 0

SWEP.Spawnable				= true

SWEP.ViewModel				= Model( "models/weapons/HL2meleepack/v_axe.mdl" )
SWEP.WorldModel				= Model( "models/weapons/HL2meleepack/w_axe.mdl" )
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
	self:Hitscan()

end

function SWEP:SecondaryAttack()

	self.Weapon:SetNextPrimaryFire( CurTime() + 0.35 )
	self.Weapon:SetNextSecondaryFire( CurTime() + 1.0 )

	self:EmitSound( SwingSound )

	local vm = self.Owner:GetViewModel()
	vm:SendViewModelMatchingSequence( vm:LookupSequence( "pushback" ) )

	local tr = util.TraceLine( {
		start = self.Owner:GetShootPos(),
		endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * 1.5 * 40,
		filter = self.Owner,
		mask = MASK_SHOT_HULL
	} )

	if ( tr.Hit ) then
		
		self:EmitSound( PushSoundBody )
		
		if tr.Entity:IsPlayer() or string.find(tr.Entity:GetClass(),"npc") or string.find(tr.Entity:GetClass(),"prop_ragdoll") or string.find(tr.Entity:GetClass(),"prop_physics") then
	
			tr.Entity:SetVelocity( self.Owner:GetAimVector() * Vector( 1, 1, 0 ) * 500 )
		
		end


	end

end

function SWEP:OnDrop()

	
end


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
		local _matsToDetect = {
			[87] = "wood",
		}

		if _matsToDetect[tr.MatType] && SERVER then
			
			local _skChance = math.random( 10000 )
			local _lv = 1;
			if self.Owner:GetRotoLevel(18) then
				_lv = self.Owner:GetRotoLevel(18)[1]
			end
			_skChance = math.max(_skChance - (10*_lv),1)
			self.Owner:AddRotoXP(18,RotoLevelSystem.config.RewardXP	+(RotoLevelSystem.config.RewardXPPerLevel*_lv))
			if _skChance < 101 then
				
				self.Owner:AddFreeSkillPoints(1)
			end
			local _chance = math.random( 100 )
			
			if _chance < fsrp.mining.config.AxeChance then
			
				//self.Owner:AddItemByID( 109 )
				
				local _AmountItems = math.random( #fsrp.mining.config.AxeTable );
				local _toGiveTbl = {};
				
				for i = 1, _AmountItems do
					
					table.insert( _toGiveTbl ,{ ID = fsrp.mining.config.AxeTable[math.random(#fsrp.mining.config.AxeTable)] , amount = math.random(3)})
										
				end
				
				if #_toGiveTbl > 0 then
					
						for k , v in pairs( _toGiveTbl ) do
						
							for i = 1, v.amount do
							
								self.Owner:AddItemByID( v.ID );
							
							end
							
						
					
					end
					
					self.Owner:Notify("Received items." )
					
				end
				
			local _breakChance = math.random( 100 )
				
				if _breakChance > 80 then
				
					self.Owner:Notify("Your weapon broke")
					self.Owner:RemoveFromSlot( 2 , true )
				end
				
			end
			
		//vm:SendViewModelMatchingSequence( vm:LookupSequence( "hitcenter1" ) )

			local vPoint = (self.Owner:GetShootPos() + (self.Owner:EyeAngles():Forward() * 5) - ( self.Owner:EyeAngles():Up() ))
			
			local effectdata = EffectData()
			
			effectdata:SetOrigin( vPoint )
			
			util.Effect( "GlassImpact", effectdata )
			
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