
local ITEM = ITEM || {};

ITEM.ID = 20
ITEM.Category = "Craftable"
ITEM.Name = "Propane Tank"
ITEM.Quality = 0
ITEM.Description = "You need a few accessories for this."
ITEM.Model	= "models/props_junk/PropaneCanister001a.mdl"
ITEM.Weight = 25;
ITEM.MaxStack = 25;
ITEM.Cost = 100;
ITEM.CamPos = Vector(10.81, 37.84, 10.81);
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