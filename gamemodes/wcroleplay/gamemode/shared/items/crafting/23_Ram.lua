
local ITEM = ITEM || {};

ITEM.ID = 23
ITEM.Category = "Craftable"
ITEM.Name = "Ram"
ITEM.Quality = 0
ITEM.Description = "x2 GB DDR2 Stick"
ITEM.Model	= "models/gaming-models/nebukadnezar/gibs/pc_gibs/pc_ram.mdl"
ITEM.Weight = 1;
ITEM.MaxStack = 25;
ITEM.Cost = 300;
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