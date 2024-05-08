
local ITEM = ITEM || {};

ITEM.ID = 17
ITEM.Category = "Craftable"
ITEM.Name = "Gear"
ITEM.Quality = 0
ITEM.Description = "You could craft an engine if you had enough of these"
ITEM.Model	= "models/props_phx/gears/bevel12.mdl"
ITEM.Weight = 5;
ITEM.MaxStack = 25;
ITEM.Cost =10 ;
 ITEM.CamPos = Vector(0, 5.41, 43.24);
ITEM.LookAt = Vector(0, 0, -5.41);

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