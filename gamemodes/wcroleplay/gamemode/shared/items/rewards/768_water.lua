
local ITEM = ITEM || {};

ITEM.ID = 768
ITEM.Category = "Craftable"
ITEM.Name = "Water"
ITEM.Quality = 0
ITEM.Description = "Fresh water, perfect for a hot day!"
ITEM.Model	= "models/props/cs_office/water_bottle.mdl"
ITEM.Weight = 15;
ITEM.MaxStack = 100;
ITEM.Cost = 15;
ITEM.Class = "cooling_water";
ITEM.Illegal = false;
ITEM.Tradeable = true;
ITEM.CamPos = Vector(43.24, 21.62, 43.24);
ITEM.LookAt = Vector(0, 0, 5.41);

ITEM.OnPickedUp = function( _p )

end

ITEM.CanUse = function( _p ) return true
end

ITEM.OnUsed = function( _p )
	return false
end

ITEM.OnDropped = function( _p )
	return true
end


SetupItem ( ITEM ) 