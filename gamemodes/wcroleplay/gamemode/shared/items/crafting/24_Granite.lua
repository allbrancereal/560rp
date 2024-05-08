
local ITEM = ITEM || {};

ITEM.ID = 24
ITEM.Category = "Craftable"
ITEM.Name = "Granite Rock"
ITEM.Quality = 0
ITEM.Description = "A very special type of rock"
ITEM.Model	= "models/props_debris/concrete_chunk04a.mdl"
ITEM.Weight = 10;
ITEM.MaxStack = 25;
ITEM.Cost = 45;
ITEM.CamPos = Vector(0, 10.81, 0);
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