
local ITEM = ITEM || {};

ITEM.ID = 42
ITEM.Category = "Misc"
ITEM.Name = "Large Ammo Kit"
ITEM.Quality = 0
ITEM.Description = "This crate contains a considerable amount of gunpowder."
ITEM.Model	= "models/Items/item_item_crate.mdl"
ITEM.Weight = 0.5;
ITEM.MaxStack = 25;
ITEM.Class = "cw_ammo_crate_small";
ITEM.Cost = 25;
ITEM.CamPos = Vector(0, 0, 0);
ITEM.LookAt = Vector(0, 0, 10.81);
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