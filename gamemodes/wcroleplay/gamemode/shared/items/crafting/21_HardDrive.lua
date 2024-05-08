
local ITEM = ITEM || {};

ITEM.ID = 21
ITEM.Category = "Craftable"
ITEM.Name = "Hard Drive"
ITEM.Quality = 0
ITEM.Description = "Holds about 15 minutes of porn."
ITEM.Model	= "models/gaming-models/nebukadnezar/gibs/pc_gibs/pc_harddrive.mdl"
ITEM.Weight = 10;
ITEM.MaxStack = 25;
ITEM.Cost = 25;
ITEM.CamPos = Vector(0, -5.41, 16.22);
ITEM.LookAt = Vector(5.41, 0, 0);

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