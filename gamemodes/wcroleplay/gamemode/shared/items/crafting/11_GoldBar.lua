
local ITEM = ITEM || {};

ITEM.ID = 11
ITEM.Category = "Craftable"
ITEM.Name = "Gold Bar"
ITEM.Quality = 0
ITEM.Description = "WE made it."
ITEM.Model	= "models/okxapack/valuables/valuable_bar.mdl"
ITEM.Weight = 300;
ITEM.MaxStack = 25;
ITEM.Cost = 1000;

ITEM.CamPos = Vector(0, 32.43, 54.05);
ITEM.LookAt = Vector(0, 5.41, 0);

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