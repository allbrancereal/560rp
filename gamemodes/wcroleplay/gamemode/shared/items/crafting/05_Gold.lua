
local ITEM = ITEM || {};

ITEM.ID = 5
ITEM.Category = "Craftable"
ITEM.Name = "Gold"
ITEM.Quality = 0
ITEM.Description = "This is a valuable element"
ITEM.Model	= "models/killermine/ore_1_3.mdl"
ITEM.Skin = 3;
ITEM.Weight = 5;
ITEM.MaxStack = 25;
ITEM.Cost = 80;

ITEM.CamPos = Vector(5.41, 5.41, 16.22);
ITEM.LookAt = Vector(0, 0, -5.41);

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