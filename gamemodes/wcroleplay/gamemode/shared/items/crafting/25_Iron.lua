
local ITEM = ITEM || {};

ITEM.ID = 25
ITEM.Category = "Craftable"
ITEM.Name = "Iron Ore"
ITEM.Quality = 0
ITEM.Description = "Ironic isn't it?"
ITEM.Model	= "models/props_debris/concrete_chunk05g.mdl"
ITEM.Weight = 10;
ITEM.MaxStack = 25;
ITEM.Cost = 30;
ITEM.CamPos = Vector(0, 0, -10.81);
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