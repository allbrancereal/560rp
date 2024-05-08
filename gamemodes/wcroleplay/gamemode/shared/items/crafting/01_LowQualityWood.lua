
local ITEM = ITEM || {};

ITEM.ID = 1
ITEM.Category = "Craftable"
ITEM.Name = "Low Quality Wood"
ITEM.Quality = 0
ITEM.Description = "It's a wonder that they sell this stuff to people in the first place."
ITEM.Model	= "models/props_c17/FurnitureShelf001b.mdl"
ITEM.Weight = 0.5;
ITEM.MaxStack = 25;
ITEM.Cost = 25;
ITEM.CamPos = Vector(0, 0, 37.837837837838);
ITEM.LookAt = Vector(0, 0, 0);
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