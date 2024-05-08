
local ITEM = ITEM || {};

ITEM.ID = 114
ITEM.Category = "Craftable"
ITEM.Name = "Tin"
ITEM.Quality = 0
ITEM.Description = "Maybe if you put it with something it would prevent corrosion."
ITEM.Model	= "models/gaming-models/nebukadnezar/gibs/pc_gibs/pc_cable.mdl"
ITEM.Weight = 2;
ITEM.MaxStack = 25;
ITEM.Cost = 40;
ITEM.CamPos = Vector(0, 5.41, -5.41);
ITEM.LookAt = Vector(0, 0, 5.41);

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