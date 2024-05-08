
local ITEM = ITEM || {};

ITEM.ID = 18
ITEM.Category = "Craftable"
ITEM.Name = "Wheel"
ITEM.Quality = 0
ITEM.Description = "A car requires four of these to run"
ITEM.Model	= "models/Mechanics/wheels/rim_1.mdl"
ITEM.Weight = 100;
ITEM.MaxStack = 25;
ITEM.Cost = 50;
ITEM.CamPos = Vector(-5.41, 5.41, 81.08);
ITEM.LookAt = Vector(0, -5.41, -100);

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