
local ITEM = ITEM || {};

ITEM.ID = 51
ITEM.Category = "Craftable"
ITEM.Name = "Steel"
ITEM.Quality = 0
ITEM.Description = "Recycled steel made from two metals."
ITEM.Model	= "models/gibs/metal_gib4.mdl"
ITEM.Weight = 0.5;
ITEM.MaxStack = 25;
ITEM.Cost = 25;
ITEM.CamPos = Vector(0,0,8);
ITEM.LookAt = Vector(0, 0, 0);
ITEM.OnPickedUp = function( _p )

end

ITEM.CanUse = function( _p )
	return true
end

ITEM.OnUsed = function( _p )
	return false
end

ITEM.OnDropped = function( _p )
	return true
end 


SetupItem ( ITEM ) 