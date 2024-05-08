
local ITEM = ITEM || {};

ITEM.ID = 10
ITEM.Category = "Craftable"
ITEM.Name = "Electrical Board"
ITEM.Quality = 0
ITEM.Description = "Basic logic circuits. Pentium-style."
ITEM.Model	= "models/gaming-models/nebukadnezar/gibs/pc_gibs/pc_mother.mdl"
ITEM.Weight = 15;
ITEM.MaxStack = 25;
ITEM.Cost = 125;

 ITEM.CamPos = Vector(-5.41, -37.84, 21.62);
ITEM.LookAt = Vector(-5.41, 21.62, 0);
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