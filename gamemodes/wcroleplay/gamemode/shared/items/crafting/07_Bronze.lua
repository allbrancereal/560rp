
local ITEM = ITEM || {};

ITEM.ID = 7
ITEM.Category = "Craftable"
ITEM.Name = "Bronze"
ITEM.Quality = 0
ITEM.Description = "You could find something useful to craft with it"
ITEM.Model	= "models/killermine/ore_1_3.mdl"
ITEM.Weight = 2.5;
ITEM.MaxStack = 25;
ITEM.Cost = 50;
ITEM.CamPos = Vector(5.41, 5.41, 16.22);
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