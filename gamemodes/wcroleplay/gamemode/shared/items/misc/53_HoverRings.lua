
local ITEM = ITEM || {};

ITEM.ID = 56
ITEM.Category = "Misc"
ITEM.Name = "Hover Rings"
ITEM.Quality = 0
ITEM.Description = "A mystical force pushes the equilibrium of this object from eversolasting peace."
ITEM.Model	= "models/maxofs2d/hover_rings.mdl"
ITEM.Weight = 0.5;
ITEM.MaxStack = 25;
ITEM.Cost = 25;
ITEM.CamPos = Vector(0, -37.84, 0);
ITEM.LookAt = Vector(0, 0, 0);
ITEM.OnPickedUp = function( _p )

end

ITEM.CanUse = function( _p )
	return false
end

ITEM.OnUsed = function( _p )
	return false
end

ITEM.OnDropped = function( _p )
	return true
end 


SetupItem ( ITEM ) 