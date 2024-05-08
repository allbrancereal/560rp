
local ITEM = ITEM || {};

ITEM.ID = 59
ITEM.Category = "Weapon"
ITEM.Name = "Soapstone"
ITEM.Quality = 0
ITEM.Description = "A extremely awesome little rock. You can write messages!"
ITEM.WeaponClass = "weapon_soapstone";
ITEM.Model	= "models/props_debris/concrete_chunk05g.mdl"
ITEM.Weight = 0.5;
ITEM.MaxStack = 5;
ITEM.Cost = 25;
ITEM.CamPos = Vector(5.41, -27.03, 16.22);
ITEM.LookAt = Vector(10.81, 0, 0);
ITEM.OnPickedUp = function( _p )

end
ITEM.SlotType = 2;
ITEM.CamPos = Vector(0, 10.81, 0);
ITEM.LookAt = Vector(0, 0, 0);

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