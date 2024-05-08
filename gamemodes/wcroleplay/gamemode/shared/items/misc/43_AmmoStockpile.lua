
local ITEM = ITEM || {};

ITEM.ID = 43
ITEM.Category = "Misc"
ITEM.Name = "Ammo Stockpile"
ITEM.Quality = 0
ITEM.Description = "This crate contains enough ammo to last someone for life."
ITEM.Model	= "models/Items/ammocrate_smg1.mdl"
ITEM.Weight = 0.5;
ITEM.Class = "cw_ammo_crate_regular";
ITEM.MaxStack = 25;
ITEM.Cost = 25;
ITEM.CamPos = Vector(70.27, 10.81, 5.41);
ITEM.LookAt = Vector(-100, -16.22, -5.41);
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