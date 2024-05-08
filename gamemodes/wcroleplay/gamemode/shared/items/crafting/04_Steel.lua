
local ITEM = ITEM || {};

ITEM.ID = 4
ITEM.Category = "Craftable"
ITEM.Name = "Steel Plate"
ITEM.Quality = 0
ITEM.Description = "When you have two metals you get this"
ITEM.Model	= "models/props_debris/metal_panel01a.mdl"
ITEM.Weight = 3.5;
ITEM.MaxStack = 25;
ITEM.Cost = 75;

ITEM.CamPos = Vector(100, 5.41, -100);
ITEM.LookAt = Vector(5.41, 0, -27.03);

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