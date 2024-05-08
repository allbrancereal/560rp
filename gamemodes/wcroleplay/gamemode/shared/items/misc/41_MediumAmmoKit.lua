
local ITEM = ITEM || {};

ITEM.ID = 41
ITEM.Category = "Misc"
ITEM.Name = "Medium Ammo Kit"
ITEM.Quality = 0
ITEM.Description = "This crate contains loads of ammo."
ITEM.Model	= "models/Items/BoxMRounds.mdl"
ITEM.Weight = 0.5;
ITEM.Class = "cw_ammo_kit_regular";
ITEM.MaxStack = 25;
ITEM.Cost = 25;
ITEM.CamPos = Vector(27.03, -5.41, 10.81);
ITEM.LookAt = Vector(-100, 16.22, -16.22);
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