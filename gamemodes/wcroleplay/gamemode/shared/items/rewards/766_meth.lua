
local ITEM = ITEM || {};

ITEM.ID = 766
ITEM.Category = "Craftable"
ITEM.Name = "Meth (Dry)"
ITEM.Quality = 0
ITEM.Description = "A expensive and addictive substance."
ITEM.Model	= "models/props_wasteland/coolingtank02.mdl"
ITEM.Weight = 15;
ITEM.MaxStack = 500;
ITEM.Cost = 1500;
ITEM.Scale = 0.15
ITEM.Illegal = true;
ITEM.Tradeable = true;
ITEM.CamPos = Vector(100, 100, 21.62);
ITEM.LookAt = Vector(-16.22, 0, 0);

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