
local ITEM = ITEM || {};

ITEM.ID = 16
ITEM.Category = "Craftable"
ITEM.Name = "Lever"
ITEM.Quality = 0
ITEM.Description = "Useful for turning things on/off"
ITEM.Model	= "models/props_c17/TrapPropeller_Lever.mdl"
ITEM.Weight = 2.5;
ITEM.MaxStack = 25;
ITEM.Cost = 5;
ITEM.CamPos = Vector(10.81, 0, 0);
ITEM.LookAt = Vector(0, 0, 0);

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