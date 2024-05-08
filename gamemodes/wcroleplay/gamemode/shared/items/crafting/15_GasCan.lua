
local ITEM = ITEM || {};

ITEM.ID = 15
ITEM.Category = "Weapon"
ITEM.Name = "Gas Can"
ITEM.Quality = 0
ITEM.Description = "Petroleum. Waste of money."
ITEM.Model	= "models/props_junk/gascan001a.mdl"
ITEM.Weight = 75;
ITEM.MaxStack = 25;
ITEM.Cost = 25;
ITEM.CamPos = Vector(48.65, 0, 10.81);
ITEM.LookAt = Vector(10.81, 0, 0);
ITEM.Class = "vc_pickup_fuel_petrol";
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