
local ITEM = ITEM || {};

ITEM.ID = 14
ITEM.Category = "Craftable"
ITEM.Name = "Alcohol Bottle"
ITEM.Quality = 0
ITEM.Description = "Flammable liquid, 70%"
ITEM.Model	= "models/props_junk/garbage_glassbottle003a.mdl"
ITEM.Weight = 10;
ITEM.MaxStack = 25;
ITEM.Cost = 5;

ITEM.CamPos = Vector(27.03, -5.41, 5.41);
ITEM.LookAt = Vector(5.41, 0, 0);


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