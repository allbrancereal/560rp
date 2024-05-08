
local ITEM = ITEM || {};

ITEM.ID = 28
ITEM.Category = "Craftable"
ITEM.Name = "Sodium Ore"
ITEM.Quality = 0
ITEM.Description = "Rocking premium."
ITEM.Model	= "models/gibs/glass_shard03.mdl"
ITEM.Weight = 10;
ITEM.MaxStack = 25;
ITEM.Cost = 45;
ITEM.CamPos = Vector(10.81, 5.41, 16.22);
ITEM.LookAt = Vector(-5.41, 0, 15);

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