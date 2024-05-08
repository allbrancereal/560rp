
local ITEM = ITEM || {};

ITEM.ID = 22
ITEM.Category = "Craftable"
ITEM.Name = "Graphics Card"
ITEM.Quality = 0
ITEM.Description = "You could play pong with this or display images"
ITEM.Model	= "models/gaming-models/nebukadnezar/gibs/pc_gibs/pc_grafix.mdl"
ITEM.Weight = 15;
ITEM.MaxStack = 25;
ITEM.Cost = 250;

ITEM.CamPos = Vector(0, -5.41, -16.22);
ITEM.LookAt = Vector(-5.41, 0, 0);

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