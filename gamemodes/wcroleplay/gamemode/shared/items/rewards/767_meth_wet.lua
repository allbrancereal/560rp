
local ITEM = ITEM || {};

ITEM.ID = 767
ITEM.Category = "Craftable"
ITEM.Name = "Meth (Wet)"
ITEM.Quality = 0
ITEM.Description = "Uncooked meth, not ready for sale."
ITEM.Model	= "models/props_wasteland/coolingtank02.mdl"
ITEM.Weight = 15;
ITEM.MaxStack = 25;
ITEM.Cost = 600;
ITEM.Class = "meth_wet";
ITEM.Illegal = true;
ITEM.Scale = 0.15
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