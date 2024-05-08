
local ITEM = ITEM || {};

ITEM.ID = 12
ITEM.Category = "Craftable"
ITEM.Name = "Oil Drum"
ITEM.Quality = 0
ITEM.Description = "Can hold things, is empty."
ITEM.Model	= "models/props_c17/oildrum001.mdl"
ITEM.Weight = 50;
ITEM.MaxStack = 25;
ITEM.Cost = 100;

ITEM.CamPos = Vector(86.49, 0, 64.86);
ITEM.LookAt = Vector(-21.62, 5.41, 5.41);
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