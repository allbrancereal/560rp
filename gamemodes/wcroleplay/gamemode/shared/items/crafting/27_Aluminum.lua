
local ITEM = ITEM || {};

ITEM.ID = 27
ITEM.Category = "Craftable"
ITEM.Name = "Aluminum Ore"
ITEM.Quality = 0
ITEM.Description = "Lightweight rocks"
ITEM.Model	= "models/props_c17/canisterchunk01a.mdl"
ITEM.Weight = 10;
ITEM.MaxStack = 25;
ITEM.Cost = 35;
ITEM.CamPos = Vector(14, 0, 18)
ITEM.LookAt = Vector(0, 0, 20)
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