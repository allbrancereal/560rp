
local ITEM = ITEM || {};

ITEM.ID = 50
ITEM.Category = "Weapon"
ITEM.Name = "Physics Gun"
ITEM.Quality = 0
ITEM.Description = "Using a physics handle, you may grab objects!"
ITEM.Model	= "models/weapons/w_Physics.mdl"
ITEM.Weight = 0.5;
ITEM.MaxStack = 25;
ITEM.Cost = 8000;
ITEM.WeaponClass = "weapon_physgun";

ITEM.SlotType = 2;
ITEM.CamPos = Vector(-16.22, 27.03, 10.81);
ITEM.LookAt = Vector(5.41, 0, 0);
ITEM.OnPickedUp = function( _p )

end

ITEM.CanUse = function( _p )
	return true
end

ITEM.OnUsed = function( _p )
	return false
end

ITEM.OnDropped = function( _p )
	return true
end 


SetupItem ( ITEM ) 