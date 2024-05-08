
local ITEM = ITEM || {};

ITEM.ID = 764
ITEM.Category = "Craftable"
ITEM.Name = "Bleach"
ITEM.Quality = 0
ITEM.Description = "A whole lot of paint, but really worthless"
ITEM.Model	= "models/props_junk/garbage_plasticbottle002a.mdl"
ITEM.Weight = 15;
ITEM.MaxStack = 25;
ITEM.Cost = 25;
ITEM.Class = "meth_ingredient_c";
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