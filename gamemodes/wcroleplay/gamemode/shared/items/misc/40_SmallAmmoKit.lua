
local ITEM = ITEM || {};

ITEM.ID = 40
ITEM.Category = "Misc"
ITEM.Name = "Small Ammo Kit"
ITEM.Quality = 0
ITEM.Description = "Contains multiple magazines of different types of ammo."
ITEM.Model	= "models/Items/BoxSRounds.mdl"
ITEM.Class = "cw_ammo_kit_small";
ITEM.Weight = 0.5;
ITEM.MaxStack = 25;
ITEM.Cost = 3000;
ITEM.CamPos = Vector(21.62, 5.41, 5.41);
ITEM.LookAt = Vector(-91.89, -27.03, -5.41);
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