
local ITEM = ITEM || {};

ITEM.ID = 2
ITEM.Category = "Craftable"
ITEM.Name = "Upper Class Wood"
ITEM.Quality = 0;
ITEM.Description = "This is some high quality wood.";
ITEM.Model	= "models/props_phx/construct/wood/wood_boardx1.mdl";
ITEM.Weight = 0.5;
ITEM.MaxStack = 25;
ITEM.Cost = 75;

ITEM.CamPos = Vector(5.4054054054054, 16.216216216216, 48.648648648649);
ITEM.LookAt = Vector(5.4054054054054, 5.4054054054054, 5.4054054054054);
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