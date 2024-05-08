
local ITEM = ITEM || {};

ITEM.ID = 26
ITEM.Category = "Craftable"
ITEM.Name = "Silicon Ore"
ITEM.Quality = 0
ITEM.Description = "A fancy rock, computers are made of this."
ITEM.Model	= "models/props_debris/tile_wall001a_chunk05.mdl"
ITEM.Weight = 10;
ITEM.MaxStack = 25;
ITEM.Cost = 25;
ITEM.CamPos = Vector(54.05, 21.62, 59.46);
ITEM.LookAt = Vector(-27.03, 21.62, 27.03);

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