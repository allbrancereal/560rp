
if SERVER then
	AddCSLuaFile("shared.lua")
end

if CLIENT then
	SWEP.PrintName = "Battering Ram"
	SWEP.Slot = 2
	SWEP.SlotPos = 1
	SWEP.DrawAmmo = false
	SWEP.DrawCrosshair = false
end

SWEP.Author = "Tibba"
SWEP.Instructions = "Left Click: Batter Door. It's not always successful. Right Click: Remove player from car."
SWEP.Contact = ""
SWEP.Purpose = ""

SWEP.PercentChange = 20;
SWEP.HoldType = "rpg";
SWEP.ViewModel = "models/weapons/v_rpg.mdl";
SWEP.WorldModel = "models/weapons/w_rocket_launcher.mdl";

SWEP.ViewModelFOV = 62
SWEP.ViewModelFlip = false
SWEP.AnimPrefix	 = "rpg"

SWEP.BatterSound = Sound("physics/wood/wood_panel_break1.wav");
SWEP.BatterFailSound = Sound("physics/wood/wood_panel_impact_hard1.wav");

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

SWEP.NormalPos = Vector (-0.285, 7.1894, 2.9321)
SWEP.NormalAng = Vector (-4.2432, -9.1547, 0)

SWEP.IronSightsPos = Vector (-5, 15.1894, 2.9321)
SWEP.IronSightsAng = Vector (-4.2432, -9.1547, 0)



function SWEP:Deploy()
	if SERVER then
		self:SetColor(Color(0, 0, 0, 255))
	end
end

function SWEP:Initialize() self:SetWeaponHoldType("rpg") end
function SWEP:CanPrimaryAttack ( ) return true; end

function SWEP:TryToBatter ( Target )
	local Randomness = math.random(1, 100);
	
	if Randomness <= self.PercentChange then
		Target:EmitSound(self.BatterSound, 100);
		
		Target:Fire('unlock', '', 0);
		Target:Fire('open', '', .5);
	else
		Target:EmitSound(self.BatterFailSound, 100);
	end
end

function SWEP:PrimaryAttack()
	self.Weapon:SetNextPrimaryFire(CurTime() + 1)
	self.IsIronsighted = true;

	if CLIENT then return false; end
	
	local EyeTrace = self.Owner:GetEyeTrace()

	if (!EyeTrace.Entity:IsValid() or !EyeTrace.Entity:IsDoor()) then return false; end
	
	local Distance = self.Owner:EyePos():Distance(EyeTrace.HitPos);
	
	if Distance > 75 then return false; end
	
	local doorTable = EyeTrace.Entity:getFlag("doorID",nil); 

	local _IsClubHouseDoor = EyeTrace.Entity:getFlag("clubhouseDoor",nil);
	local _IsBusinessDoor = EyeTrace.Entity:getFlag("businessDoor",nil);
	if _IsClubHouseDoor then
		local _kicked = false;
		local _targetLoc = fsrp.ClubhousePropertyTable[_IsClubHouseDoor].ClubHouseInformation.ExitLoc
		local _count = 0;
		for k , v in pairs(player.GetAll() ) do
			
			if v:getFlag("ResidingInControlledProperty",nil) == _IsClubHouseDoor then
				local _wanted = v:getFlag("warrent", false);
				if _wanted == true then
					v:SetPos(_targetLoc[1]+(v:GetForward()*200) + Vector(0,_count*100,100))
					v:SetEyeAngles(_targetLoc[2])
					_kicked = true;
					self.Owner:Notify("You have kicked " .. v:getRPName() .. " out for having a warrant.")
					local _timePlayed = self.Owner:getFlag( "jobPlaytimes", {} );
					local _job = fsrp.JobRanks[TEAM_POLICE];
					local _nameIn = "Officer";
					if _timePlayed[TEAM_POLICE] && _timePlayed[TEAM_POLICE].Rank  then
						_nameIn  = _job[1].name;
						
						for x, y in pairs( _job ) do
							if y.rank == _timePlayed[TEAM_POLICE].Rank then
								_nameIn = y.name
																
							end
							
						end
						

					end
					v:Notify("Police " .. _nameIn .. " has kicked you out of your club house to make you serve your warrant.")
					_count = _count + 1;
					v:setFlag("ResidingInControlledProperty", nil );
					net.Start("clientShown")
					net.WriteBool(false)
					net.Send(v) 
					v:SetCollisionGroup(COLLISION_GROUP_PLAYER)
				end
			end

 		end
 		if _kicked == true then
 			return true;
 		end
 		return self.Owner:Notify("No criminal was found inside this Clubhouse.");
	end
	if _IsBusinessDoor then
		return self.Owner:Notify("Please do not batter business doors.");
	end

	if !doorTable == nil then return false; end
	
	local doorOwner = EyeTrace.Entity:GetDoorOwner();
	
	if !self.Owner:IsAdmin() && self.Owner:Team() != TEAM_POLICE then return end
	if (!doorOwner) then
		self:TryToBatter(EyeTrace.Entity);
	else
		local _pOwner = player.GetBySteamID(doorOwner);
		if _pOwner && _pOwner:getFlag("warrent", false) then
			self:TryToBatter(EyeTrace.Entity);
		elseif _pOwner then
			self.Owner:Notify(_pOwner:getRPName() .. " is not warranted.");
		end
	end
end

function SWEP:SecondaryAttack()
	self.Weapon:SetNextSecondaryFire(CurTime() + 1)
	self.IsIronsighted = true;

	if CLIENT then return false; end
	
	local EyeTrace = self.Owner:GetEyeTrace()

	if !EyeTrace.Entity:IsValid() or !EyeTrace.Entity:IsVehicle() then return false; end
	
	local Distance = self.Owner:EyePos():Distance(EyeTrace.HitPos);
	
	if Distance > 75 then return false; end
	
	if !EyeTrace.Entity:GetDriver() or !EyeTrace.Entity:GetDriver():IsValid() or !EyeTrace.Entity:GetDriver():IsPlayer() then return false; end
	
	if EyeTrace.Entity:GetDriver():getFlag("warrent", false) then
		EyeTrace.Entity:GetDriver():ExitVehicle();
	else
		self.Owner:Notify(EyeTrace.Entity:GetDriver():getRPName() .. " is not warranted.");
	end
end

local IRONSIGHT_TIME = 0.1
function SWEP:GetViewModelPosition ( pos, ang )

	if ( !self.IronSightsPos ) then return pos, ang end

	local bIron = self.IsIronsighted;
	
	if ( bIron != self.bLastIron ) then
	
		self.bLastIron = bIron 
		self.fIronTime = CurTime()
		
		if ( bIron ) then 
			self.SwayScale 	= 0.3
			self.BobScale 	= 0.1
		else 
			self.SwayScale 	= 1.0
			self.BobScale 	= 1.0
		end
	
	end
	
	local fIronTime = self.fIronTime or 0
	
	local Right 	= ang:Right()
	local Up 		= ang:Up()
	local Forward 	= ang:Forward()
	
	local Mul = 1

	if ( !bIron && fIronTime < CurTime() - IRONSIGHT_TIME ) then
		if self.NormalAng then
			ang = ang * 1
			ang:RotateAroundAxis( ang:Right(), 		self.NormalAng.x * Mul )
			ang:RotateAroundAxis( ang:Up(), 		self.NormalAng.y * Mul )
			ang:RotateAroundAxis( ang:Forward(), 	self.NormalAng.z * Mul )
		end
		
		if self.NormalPos then
			pos = pos + self.NormalPos.x * Right * Mul
			pos = pos + self.NormalPos.y * Forward * Mul
			pos = pos + self.NormalPos.z * Up * Mul
		end
	
		return pos, ang;
	end
	
	if ( fIronTime > CurTime() - IRONSIGHT_TIME ) then
	
		Mul = math.Clamp( (CurTime() - fIronTime) / IRONSIGHT_TIME, 0, 1 )
		
		if (!bIron) then Mul = 1 - Mul end
	
	end

	local Offset	= self.IronSightsPos
	
	if ( self.IronSightsAng ) then
	
		if (Mul == 1) then
			self.IsIronsighted = nil;
		end
	
		ang = ang * 1
		ang:RotateAroundAxis( ang:Right(), 		self.IronSightsAng.x * Mul )
		ang:RotateAroundAxis( ang:Up(), 		self.IronSightsAng.y * Mul )
		ang:RotateAroundAxis( ang:Forward(), 	self.IronSightsAng.z * Mul )
	
	end
	
	if self.NormalAng then
		ang = ang * 1
		ang:RotateAroundAxis( ang:Right(), 		self.NormalAng.x * (1 - Mul) )
		ang:RotateAroundAxis( ang:Up(), 		self.NormalAng.y * (1 - Mul) )
		ang:RotateAroundAxis( ang:Forward(), 	self.NormalAng.z * (1 - Mul) )
	end

	pos = pos + Offset.x * Right * Mul
	pos = pos + Offset.y * Forward * Mul
	pos = pos + Offset.z * Up * Mul
	
	if self.NormalPos then
		pos = pos + self.NormalPos.x * Right * (1 - Mul)
		pos = pos + self.NormalPos.y * Forward * (1 - Mul)
		pos = pos + self.NormalPos.z * Up * (1 - Mul)
	end

	return pos, ang
	
end