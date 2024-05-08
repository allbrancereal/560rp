
if SERVER then
	AddCSLuaFile("shared.lua")
end

if CLIENT then
	SWEP.PrintName = "Nose/Inspect"
	SWEP.Slot = 1
	SWEP.SlotPos = 1
	SWEP.DrawAmmo = false
	SWEP.DrawCrosshair = false
end

SWEP.Author = "Mario S."
SWEP.Instructions = "Left Click: Sniff/Inspect an entity:Reload to inspect yourself."
SWEP.Contact = ""
SWEP.Purpose = "Inspecting the objects around you."

SWEP.ViewModelFOV = 62
SWEP.ViewModelFlip = false 
SWEP.AnimPrefix	 = "rpg"


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

SWEP.ViewModel		= ""
SWEP.WorldModel = ""

function SWEP:Initialize()
	self:SetWeaponHoldType("normal")
end

function SWEP:CanPrimaryAttack ( ) return true; end

local noticableEntities = {
	
	["cannabis_plant"] = { Implementation = function( ent , owner ) 
	
		local _timeElapsed = CurTime() - ent:getFlag( "weed_SpawnTime", 0 )
		local _returnText = " freshly potted cannabis. (Elapsed: " .. math.ceil(_timeElapsed) .. "s)" ;
		if _timeElapsed > 300 && _timeElapsed < 450 then
		
			_returnText = " growing cannabis.";
		
		elseif  _timeElapsed > 450 then
		
			_returnText = " finished dank bud.";
		
		end
		
		return _returnText;
	end 
	};
	["prop_door_rotating"] = { Implementation = function( ent , owner ) 
	
		if !ent:IsDoor() then return false end
		
		local _doorID = ent:getFlag("doorID", nil)
		local _name = "";
		
		if _doorID then
		
			_name = fsrp.PropertyTable[_doorID].Name;
		
		end
		
						 
		local _text = "You inspect the door to the " .. _name;
			
		if (ent:IsPoliceDoor()) then
			
			_text = "You inspect the door to a ";
			_name = "Municipal Building";
			return _text .. _name;
			
		elseif (ent:IsNeutralDoor()) then
					
			_text = "You inspect the door to a ";
			_name = "Civil Building";
			return _text .. _name;
			
		elseif ent:IsCustomNameDoor() then
					
			_text = "You inspect the door to the ";
			_name = ent:GetCustomName()
			return _text .. _name;	
				
		
		end
		
		
		return _text;
	
	end };
	["func_door_rotating"] = { Implementation = function( ent , owner ) 
	
		if !ent:IsDoor() then return false end
		
		local _doorID = ent:getFlag("doorID", nil)
		
		local _name = "";
		
		if _doorID then
		
			_name = fsrp.PropertyTable[_doorID].Name;
		
		end
		
		local _text = "You inspect the door to the " .. _name;

		if (ent:IsPoliceDoor()) then
			
			_text = "You inspect the door to a ";
			_name = "Municipal Building";
			return _text .. _name;
			
		elseif (ent:IsNeutralDoor()) then
					
			_text = "You inspect the door to a ";
			_name = "Civil Building";
			return _text .. _name;
			
		elseif ent:IsCustomNameDoor() then
					
			_text = "You inspect the door to the ";
			_name = ent:GetCustomName()
			return _text .. _name;	
				
		
		end
		
		
		return _text;
	
	end };
	["func_door"] = { Implementation = function( ent , owner ) 
	
		if !ent:IsDoor() then return false end
		
		local _doorID = ent:getFlag("doorID", nil)
		
		local _name = "";
		
		if _doorID then
		
			_name = fsrp.PropertyTable[_doorID].Name;
		
		end
		
						 
		local _text = "You inspect the door to the " .. _name;
			
		if (ent:IsPoliceDoor()) then
			
			_text = "You inspect the door to a ";
			_name = "Municipal Building";
			return (_text .. _name)
			
		elseif (ent:IsNeutralDoor()) then
					
			_text = "You inspect the door to a ";
			_name = "Civil Building";
			return (_text .. _name)
			
		elseif ent:IsCustomNameDoor() then
					
			_text = "You inspect the door to the ";
			_name = ent:GetCustomName()
			return (_text .. _name)
				
		
		end
		
		
		return _text
	end };
	["cn_npc"] = {Implementation = function( ent, owner ) 
		
		return "You are looking at " .. cnQuests[ent:GetQuest()].name;	
	
	end };
	["soapstonewriting"] = {Implementation = function( ent , owner )
	
		return "You are looking at a soap stone carving."
	
	end }
}
function SWEP:PrimaryAttack()
	if CLIENT then return end
	
	self.Weapon:SetNextPrimaryFire(CurTime() + math.random( 1,3 ) )			
	local EyeTrace = self.Owner:GetEyeTrace()
	local Distance1 = self.Owner:EyePos():Distance(EyeTrace.HitPos);	
		
	//if (EyeTrace.Entity:IsVehicle() and Distance1 < 125) or (EyeTrace.Entity:IsDoor() and Distance1 < 75) then
	//if (EyeTrace.Entity:IsDoor() and Distance1 < 75) && self:GetNextPrimaryFire() < CurTime() then
	
	if Distance1 < 175 then
		
	
		if (!EyeTrace.Entity || !IsValid(EyeTrace.Entity)) then return false; end
		//self.Owner:Notify(EyeTrace.Entity:GetClass());
		if !noticableEntities[EyeTrace.Entity:GetClass()] then return false end
		
			
			local _text = noticableEntities[EyeTrace.Entity:GetClass()].Implementation( EyeTrace.Entity , self.Owner ) ;
			if !_text then return end;
			
			self.Owner:Notify( _text );
		
		
		
	end
			
end
local _timeToDo = 0;
function SWEP:Reload()

	if SERVER then return end
	
	if _timeToDo > CurTime() then return end
	
	_timeToDo = CurTime() + math.random(1,3);
	
	local _ownerHealth = self.Owner:Health()
	local _text = "naturally healthy."
	
	if _ownerHealth > 80 && _ownerHealth <= 99 then
	
		_text = "have slight stomach discomfort."
		
	elseif _ownerHealth > 60 && _ownerHealth <= 79 then
	
		_text = "are visibly bruised arm."
		
	elseif _ownerHealth > 40 && _ownerHealth <= 59 then
	
		_text = "have blurred vision and noticably bruised."
		
	elseif _ownerHealth > 20 && _ownerHealth <= 39 then
	
		_text = "are actively bleeding.. I should get to a medic."
		
	elseif _ownerHealth > 1 && _ownerHealth <= 19 then
	
		_text = "are close to death."
		
	end
	
	self.Owner:Notify( "You inspect yourself to see that you " .. _text );
	
end 

function SWEP:SecondaryAttack()
	return
end

function SWEP:GetViewModelPosition ( pos, ang )
	return pos, ang
	
end