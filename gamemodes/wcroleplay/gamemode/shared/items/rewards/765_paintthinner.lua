
local ITEM = ITEM || {};

ITEM.ID = 765
ITEM.Category = "Craftable"
ITEM.Name = "Paint Thinner"
ITEM.Quality = 0
ITEM.Description = "Paint thinner, useful for removing paint from places or diluting things."
ITEM.Model	= "models/props_junk/metal_paintcan001a.mdl"
ITEM.Weight = 15;
ITEM.MaxStack = 25;
ITEM.Cost = 25;
ITEM.Class = "meth_ingredient_a";
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