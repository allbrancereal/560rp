
if SERVER then
	AddCSLuaFile("shared.lua")
end

if CLIENT then
	SWEP.PrintName = "Lock Pick"
	SWEP.Slot = 2
	SWEP.SlotPos = 1
	SWEP.DrawAmmo = false
	SWEP.DrawCrosshair = false
end

SWEP.Author = "Mario S."
SWEP.Instructions = "Left Click: Attempt to pick lock."
SWEP.Contact = "support@560rp.com"
SWEP.Purpose = "Break in to doors and cars."

SWEP.HoldType = "melee";
SWEP.ViewModel = "models/weapons/v_crowbar.mdl";
SWEP.WorldModel = "models/weapons/w_crowbar.mdl";

SWEP.ViewModelFOV = 62
SWEP.ViewModelFlip = false
SWEP.AnimPrefix	 = "melee"

SWEP.BreakSound = "doors/handle_pushbar_locked1.wav"
SWEP.BatterSound = "doors/door_locked2.wav"
SWEP.BreakSelfChance = 20;
SWEP.PercentChance = 5;
SWEP.Spawnable = false
SWEP.AdminSpawnable = true
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = 0
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = ""

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = 0
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = ""

function SWEP:Initialize() self:SetWeaponHoldType("melee") end
function SWEP:CanPrimaryAttack ( ) return true; end

function SWEP:TryToBatter ( Target )
	/*
	if Target:GetDoorOwner() == self.Owner then 
		self.Owner:Notify('You pick open your own doors. Use a key!');
		return false;
	end
	*/
	
	self:EmitSound(self.BatterSound);
	
	if SERVER then
	
		if !self or !self:IsValid() then return false; end
		
		local Randomness = math.random(1, 100);
		local _lv = 1;
		if self:GetOwner():GetRotoLevel(5) then
			_lv = self:GetOwner():GetRotoLevel(5)[1]
		end
		self.PercentChance = self.PercentChance + (_lv*0.5)
		self.BreakSelfChance = self.BreakSelfChance - (_lv*0.05);
		if Target:IsUnPickable() then return print("aborted picking because door is locked") end
		
		local SetOffHouseAlarm = true;
		if Randomness <= self.BreakSelfChance then
			self:EmitSound(self.BreakSound);
			self.Owner:Notify('Your lock pick broke!');
			
			self.Owner:RemoveFromSlot( 2 , true );
			
			self.Owner:AddRotoXP(5,RotoLevelSystem.config.RewardXP+(_lv*RotoLevelSystem.config.RewardXPPerLevel)/5)
		elseif Randomness <= self.BreakSelfChance + self.PercentChance then	

			Target:Fire('unlock', '', 0);
			Target:Fire('open', '', .5);
			SetOffHouseAlarm = false;
			
			if IsValid(self.Owner) then
			
				self.Owner:AddRotoXP(5,RotoLevelSystem.config.RewardXP+(_lv*RotoLevelSystem.config.RewardXPPerLevel))
			end

		end
		
		if SetOffHouseAlarm then			
			/*local GroupTable = Target:GetPropertyTable();

			if (GroupTable) then
				local Group = GroupTable.ID;
				
				if GAMEMODE.HouseAlarms[Group] and (!Target:GetTable().LastSirenPlay or Target:GetTable().LastSirenPlay + 30 < CurTime()) and Target:GetDoorOwner() and Target:GetDoorOwner():IsValid() and Target:GetDoorOwner():IsPlayer() then
					umsg.Start("perp_house_alarm");
						umsg.Entity(Target);
					umsg.End();
					
					Target:GetTable().LastSirenPlay = CurTime()
					
					local lifeAlertZone = Target:GetZoneName();
					
					if (lifeAlertZone) then
						GAMEMODE:PlayerSay(self:GetDoorOwner(), "/911 [Burglar Alarm] A break in has occured at " .. lifeAlertZone .. ". Police requested.", true, false);
					else
						Msg("no life alert zone.\n")
					end
				end
			end*/
			
		end
		
	end
	
	
	
end

function SWEP:TryToPickCar ( Target )
	if self:getFlag("unPickable",false) == true then return false; end

	self:EmitSound(self.BatterSound);
	
	if SERVER then
	
		if !self or !self:IsValid() then return false; end
		
		local Randomness = math.random(1, 100);
		local _lv = 1;
		if self:GetOwner():GetRotoLevel(5) then
			_lv = self:GetOwner():GetRotoLevel(5)[1]
		end
		self.PercentChance = self.PercentChance + (_lv*0.5)
		self.BreakSelfChance = self.BreakSelfChance - (_lv*0.05);
		
		if Randomness <= self.BreakSelfChance then
			self:EmitSound(self.BreakSound);
			self.Owner:Notify('Your lock pick broke!');
			
			self.Owner:RemoveFromSlot( 2 , true );
			
			self.Owner:AddRotoXP(5,RotoLevelSystem.config.RewardXP+(_lv*RotoLevelSystem.config.RewardXPPerLevel)/5)
		elseif Randomness <= self.BreakSelfChance + self.PercentChance then
			Target:Fire('unlock', '', 0);
			Target:Fire('open', '', .5);
	
				//umsg.Start("perp_car_alarm");
					//umsg.Entity(Target);
				//umsg.End();
				
				//local CarOwner = Target:GetSharedEntity("owner");
				
				//CarOwner.StolenCarTimeLimit = CurTime() + 180;
				
				//self.Owner:Notify("Car lockpicked, take it to the chop shop for some extra cash");
				//self.Owner.StolenCar = Target;
			
			if IsValid(self.Owner) then
			
				self.Owner:AddRotoXP(5,RotoLevelSystem.config.RewardXP+(_lv*RotoLevelSystem.config.RewardXPPerLevel))
				//self.Owner:GiveExperience(SKILL_LOCK_PICKING, 25);
				
			end
		end
	end
	
		
	
	
end

local _pMeta = FindMetaTable('Player')

function _pMeta:IsNoob()

    if self:GetTimePlayed() < 86400 then
	
	    return true
		
	else
	
	    return false
		
    end	
	
end


function SWEP:PrimaryAttack()
	local EyeTrace = self.Owner:GetEyeTrace()

	if ( !EyeTrace.Entity:IsValid() ) then return false; end
	local Distance1 = self.Owner:EyePos():Distance(EyeTrace.HitPos);	
	if self.Weapon:GetNextPrimaryFire() > CurTime() && self.Weapon:GetNextSecondaryFire() > CurTime() then return end
	
	//if (EyeTrace.Entity:IsVehicle() and Distance1 < 125) or (EyeTrace.Entity:IsDoor() and Distance1 < 75) then
	if (EyeTrace.Entity:IsDoor() and Distance1 < 75) then
		if (!EyeTrace.Entity || !IsValid(EyeTrace.Entity)) then return false; end
	
		if Distance1 > 75 and EyeTrace.Entity:IsDoor() then return false; end
		local _id = EyeTrace.Entity:getFlag("doorID", nil)
		
		
		local _pTbl = fsrp.PropertyTable[_id];
		
		if !_pTbl then return false end
		
		local _prosOwner = _pTbl.PrimaryOwner && _pTbl.PrimaryOwner[2] || "";
			
		if self.Owner:SteamID() == _prosOwner then
		
			self.Owner:Notify("You can not raid your own property! Use keys!")
			
			return false
			
		end
		
		if player.GetBySteamID( _prosOwner ) && player.GetBySteamID( _prosOwner ):IsNoob() then
			
			self.Owner:Notify('Do not try to raid a new player!');		
			
			return false;	
			
		end
	
		self:TryToBatter(EyeTrace.Entity);
		local _Buffer = math.random(3) ;
		
		self.Weapon:SetNextPrimaryFire( CurTime() + _Buffer )
		self.Weapon:SetNextSecondaryFire(CurTime() + _Buffer)
	elseif (EyeTrace.Entity:IsValid() && EyeTrace.Entity:IsVehicle()) then
		
		self.Owner.lastattempt = self.Owner.lastattempt or 0;
		if (self.Owner.lastattempt > CurTime()) then return; end
		
		local Distance = self.Owner:EyePos():Distance(EyeTrace.HitPos);
		
		if Distance > 75 then return false; end
		
		local Owner = EyeTrace.Entity:getFlag("carOwner");
		
		if player.GetBySteamID( Owner ) then
		
			Owner = player.GetBySteamID( Owner )
			
		else
		
			return false
			
		end
		
		if (Owner:Team() != TEAM_CITIZEN) then
			self.Owner:Notify("You cannot lockpick government vehicles.");
			self.Owner.lastattempt = CurTime() + 1;
			return false;
		elseif (Owner == self.Owner) then
			self.Owner:Notify("You cannot lockpick your own car.");
			self.Owner.lastattempt = CurTime() + 1;
			return false;
		elseif (EyeTrace.Entity:getFlag("unPickable", false) == true) then
			self.Owner:Notify("This vehicle is equiped with security package. It cannot be picked.");
			Owner:Notify("Someone has attempted to break in your car.");
			self.Owner.lastattempt = CurTime() + 1;
			return false;
		end
		
		self:TryToPickCar(EyeTrace.Entity);
		local _Buffer = math.random(3) ;
		
		self.Weapon:SetNextPrimaryFire( CurTime() + _Buffer )
		self.Weapon:SetNextSecondaryFire(CurTime() + _Buffer)
	end
end

function SWEP:SecondaryAttack()
	self:PrimaryAttack();
end
